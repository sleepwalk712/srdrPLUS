class ScreeningQualificationsController < ApplicationController
  def create
    respond_to do |format|
      format.json do
        qualification_type = params[:qualification_type]
        unless ScreeningQualification::ALL_QUALIFICATIONS.include?(qualification_type)
          return render json: [],
                        status: :unprocessable_entity
        end

        citations_projects = CitationsProject.includes(:project).where(id: params[:citations_project_ids])
        citations_projects.each { |cp| authorize(cp.project, policy_class: ScreeningQualificationPolicy) }
        results = []
        citations_projects.each do |citations_project|
          existing_sqs = citations_project.screening_qualifications.where(qualification_type:)
          if existing_sqs.present?
            existing_sqs.destroy_all
            citations_project.abstract_screening_results.each(&:evaluate_screening_qualifications)
            citations_project.fulltext_screening_results.each(&:evaluate_screening_qualifications)
            citations_project.evaluate_extraction_qualification_status(false)
            citations_project.evaluate_extraction_qualification_status(true)
          else
            if (opposite_qualification = ScreeningQualification.opposite_qualification(qualification_type))
              citations_project.screening_qualifications.where(qualification_type: opposite_qualification).destroy_all
            end
            citations_project.screening_qualifications.find_or_create_by!(qualification_type:, user: current_user)
          end

          citations_project.evaluate_screening_status

          results << { citations_project_id: citations_project.id,
                       screening_status: citations_project.screening_status,
                       abstract_qualification: citations_project.qualification('as'),
                       fulltext_qualification: citations_project.qualification('fs'),
                       extraction_qualification: citations_project.qualification('e-'),
                       consolidation_qualification: citations_project.qualification('c-') }
        end

        render json: results
      end
    end
  end
end
