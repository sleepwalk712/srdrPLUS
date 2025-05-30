class RobotScreenService
  def initialize(project_id, url, method = 'abstract_screenings')
    @project_id = project_id
    @project = Project.find(@project_id)
    @url = url
    @method = method
  end

  def send_post_request(url, body)
    start_time = Time.now 
    puts "Start time: #{start_time.strftime('%Y-%m-%d %H:%M:%S')}"

    begin
      res = HTTParty.post(
        url,
        {
          body: body.to_json,
          headers: { 'Content-Type' => 'application/json', 'Accept': 'application/json', "Connection" => 'keep-alive' },
          timeout: 10800
        }
      )
    rescue Net::ReadTimeout => e
      elapsed_time = Time.now - start_time  # Calculate elapsed time
      Rails.logger.error "Net::ReadTimeout after #{elapsed_time.round(2)} seconds"
      puts "Net::ReadTimeout after #{elapsed_time.round(2)} seconds"
      raise
    rescue StandardError => e
      elapsed_time = Time.now - start_time  # Calculate elapsed time
      Rails.logger.error "Request failed after #{elapsed_time.round(2)} seconds: #{e.message}"
      puts "Request failed after #{elapsed_time.round(2)} seconds: #{e.message}"
      raise
    end

    elapsed_time = Time.now - start_time  # Calculate elapsed time for a successful request
    end_time = Time.now
    puts "Request completed in #{elapsed_time.round(2)} seconds, at #{end_time.strftime('%Y-%m-%d %H:%M:%S')}"

    JSON.parse(res.body)
  end

  def check_labels(data)
    labels = data.map { |item| item['label'] }.uniq
    labels.include?('0') && labels.include?('1')
  end

  def train
    data = MachineLearningDataSupplyingService.get_labeled_abstract(@project_id)

    return "Failed (message: The training data must contain both '0' and '1' labels)" unless check_labels(data)

    train_url = "#{@url}/train/#{@method}/#{@project_id}"
    response_hash = send_post_request(train_url, { labeled_data: data })

    if response_hash['success']
      timestamp = response_hash['timestamp']
      data_0_count = data.count { |item| item['label'] == '0' }
      data_1_count = data.count { |item| item['label'] == '1' }

      ml_model = @project.ml_models.create(timestamp: timestamp)
      ml_model.training_data_infos.create(category: '0', count: data_0_count)
      ml_model.training_data_infos.create(category: '1', count: data_1_count)
      "Training complete (model timestamp: #{timestamp})"
    else
      "Failed (message: #{response_hash['message']})"
    end
  end

  def get_predictions(timestamp, data)
    Rails.logger.info "Preparing to send predict POST request for unlabeled data.."
    predict_url = "#{@url}/predict/#{@method}/#{@project_id}"
    Rails.logger.info "Sending POST request for unlabeled data.."
    response_hash = send_post_request(predict_url, { input_citations: data, timestamp: timestamp })
    Rails.logger.info "Prediction scores received for unlabeled data.."
    predictions = response_hash['predictions']
    ml_model = @project.ml_models.find_by(timestamp: timestamp)
    return predictions, ml_model
  end

  def check_predictions(predictions, score_threshold, percentage_threshold)
    Rails.logger.info "Checking predictions.."
    total_predictions = predictions.size
    high_score_count = predictions.count { |score| score >= score_threshold }
    percentage = (high_score_count.to_f / total_predictions) * 100

    mean_score = predictions.sum.to_f / total_predictions
    std_dev = Math.sqrt(predictions.map { |score| (score - mean_score) ** 2 }.sum / total_predictions)

    if mean_score < 0.05
      true
    else
      percentage < percentage_threshold && std_dev > 0.01
    end
  end

  def save_predictions(data, predictions, ml_model)
    Rails.logger.info "Saving predictions.."
    total_predictions = predictions.size
    prediction_records = data.map.with_index do |citation, index|
      citation_id = citation['citation_id']
      score = predictions[index]
      citations_project = CitationsProject.find_by(citation_id: citation_id, project_id: @project_id)
      { citations_project_id: citations_project.id, ml_model_id: ml_model.id, score: score }
    end

    MlPrediction.insert_all(prediction_records)

    'Predictions saved'
  end

  def partial_train_and_predict(x)
    all_data = MachineLearningDataSupplyingService.get_labeled_abstract(@project_id)
    return "Failed (message: The training data must contain both '0' and '1' labels)" unless check_labels(all_data)

    data_0 = all_data.select { |data| data['label'] == '0' }
    data_1 = all_data.select { |data| data['label'] == '1' }

    train_size_0 = [(data_0.size * (x / 100.0)).round, 1].max
    train_size_1 = [(data_1.size * (x / 100.0)).round, 1].max

    train_data = data_0.take(train_size_0) + data_1.take(train_size_1)
    predict_data = data_0.drop(train_size_0) + data_1.drop(train_size_1)

    train_url = "#{@url}/train/#{@method}/#{@project_id}"
    Rails.logger.info "Sending training POST request to #{train_url}.."
    train_response_hash = send_post_request(train_url, { labeled_data: train_data })
    Rails.logger.info "Done!"

    return "Failed (message: #{train_response_hash['message']})" unless train_response_hash['success']

    timestamp = train_response_hash['timestamp']
    ml_model = @project.ml_models.create(timestamp: timestamp)
    ml_model.training_data_infos.create(category: '0', count: train_size_0)
    ml_model.training_data_infos.create(category: '1', count: train_size_1)

    predict_url = "#{@url}/predict/#{@method}/#{@project_id}"
    Rails.logger.info "Sending predict POST request for human labeled data to #{predict_url}.."
    predict_response_hash = send_post_request(predict_url, { input_citations: predict_data, timestamp: timestamp })

    Rails.logger.info "Predictions for human labeled data successfully received.."
    predictions = predict_response_hash['predictions']

    human_labels = predict_data.map { |data| data['label'] }

    Rails.logger.info "Preparing to update ModelPerformance table.."
    performance_data = human_labels.zip(predictions).map do |label, prediction|
      { ml_model_id: ml_model.id, label: label, score: prediction, created_at: Time.current, updated_at: Time.current }
    end
    ModelPerformance.insert_all(performance_data)
    Rails.logger.info "ModelPerformance table updated!"

    "Training complete (model timestamp: #{timestamp})"
  end
end
