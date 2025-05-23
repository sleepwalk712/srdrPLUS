# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_03_22_183941) do
  create_table "abstrackr_settings", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "profile_id"
    t.boolean "authors_visible", default: true
    t.boolean "journal_visible", default: true
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["profile_id"], name: "index_abstrackr_settings_on_profile_id"
  end

  create_table "abstract_screening_results", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "abstract_screening_id"
    t.bigint "user_id"
    t.bigint "citations_project_id"
    t.integer "label", limit: 1
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "privileged", default: false
    t.boolean "form_complete", default: false, null: false
    t.index ["abstract_screening_id", "user_id", "citations_project_id", "privileged"], name: "unique_abstract_screening_results", unique: true
    t.index ["abstract_screening_id"], name: "index_abstract_screening_results_on_abstract_screening_id"
    t.index ["citations_project_id"], name: "asr_on_cp"
    t.index ["user_id"], name: "asr_on_u"
  end

  create_table "abstract_screening_results_reasons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "abstract_screening_result_id", null: false
    t.bigint "reason_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abstract_screening_result_id", "reason_id"], name: "asrr_asr_on_r", unique: true
    t.index ["abstract_screening_result_id"], name: "asrr_on_asr"
    t.index ["reason_id"], name: "asrr_on_r"
  end

  create_table "abstract_screening_results_tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "abstract_screening_result_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abstract_screening_result_id", "tag_id"], name: "asrt_asr_on_t", unique: true
    t.index ["abstract_screening_result_id"], name: "asrt_on_asr"
    t.index ["tag_id"], name: "asrt_on_t"
  end

  create_table "abstract_screenings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "project_id"
    t.string "abstract_screening_type", default: "single-perpetual", null: false
    t.integer "no_of_citations", default: 0, null: false
    t.boolean "exclusive_users", default: false, null: false
    t.boolean "yes_tag_required", default: false, null: false
    t.boolean "no_tag_required", default: false, null: false
    t.boolean "maybe_tag_required", default: false, null: false
    t.boolean "yes_reason_required", default: false, null: false
    t.boolean "no_reason_required", default: false, null: false
    t.boolean "maybe_reason_required", default: false, null: false
    t.boolean "yes_note_required", default: false, null: false
    t.boolean "no_note_required", default: false, null: false
    t.boolean "maybe_note_required", default: false, null: false
    t.boolean "hide_author", default: false, null: false
    t.boolean "hide_journal", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "yes_form_required", default: false, null: false
    t.boolean "no_form_required", default: false, null: false
    t.boolean "maybe_form_required", default: false, null: false
    t.index ["project_id"], name: "index_abstract_screenings_on_project_id"
  end

  create_table "abstract_screenings_reasons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "abstract_screening_id", null: false
    t.bigint "reason_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pos", default: 999999
    t.index ["abstract_screening_id", "reason_id"], name: "asr_as_on_r", unique: true
    t.index ["abstract_screening_id"], name: "asr_on_as"
    t.index ["reason_id"], name: "asr_on_r"
  end

  create_table "abstract_screenings_reasons_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "abstract_screening_id"
    t.bigint "reason_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pos", default: 999999
    t.index ["abstract_screening_id", "reason_id", "user_id"], name: "as_r_u", unique: true
    t.index ["abstract_screening_id"], name: "asru_on_as"
    t.index ["reason_id"], name: "asru_on_r"
    t.index ["user_id"], name: "asru_on_u"
  end

  create_table "abstract_screenings_tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "abstract_screening_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pos", default: 999999
    t.index ["abstract_screening_id", "tag_id"], name: "ast_as_on_t", unique: true
    t.index ["abstract_screening_id"], name: "ast_on_as"
    t.index ["tag_id"], name: "ast_on_t"
  end

  create_table "abstract_screenings_tags_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "abstract_screening_id"
    t.bigint "tag_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pos", default: 999999
    t.index ["abstract_screening_id", "tag_id", "user_id"], name: "as_t_u", unique: true
    t.index ["abstract_screening_id"], name: "astu_on_as"
    t.index ["tag_id"], name: "astu_on_t"
    t.index ["user_id"], name: "astu_on_u"
  end

  create_table "abstract_screenings_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "abstract_screening_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abstract_screening_id", "user_id"], name: "u_id_on_as_id", unique: true
    t.index ["abstract_screening_id"], name: "asu_on_as"
    t.index ["user_id"], name: "asu_on_u"
  end

  create_table "action_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "actions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "action_type_id"
    t.string "actionable_type"
    t.integer "actionable_id"
    t.integer "action_count"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["action_type_id"], name: "index_actions_on_action_type_id"
    t.index ["actionable_type", "actionable_id"], name: "index_actions_on_actionable_type_and_actionable_id"
    t.index ["user_id"], name: "index_actions_on_user_id"
  end

  create_table "active_storage_attachments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_id"], name: "index_active_storage_attachments_on_record_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true
  end

  create_table "ahoy_events", charset: "utf8", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.text "properties", size: :long, collation: "utf8mb4_bin"
    t.datetime "time", precision: nil
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", charset: "utf8", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at", precision: nil
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "approvals", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "approvable_type"
    t.integer "approvable_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["approvable_type", "approvable_id", "user_id"], name: "index_approvals_on_approvable_type_and_approvable_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_approvals_on_user_id"
  end

  create_table "authors", id: :integer, charset: "utf8mb4", collation: "utf8mb4_bin", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", collation: "utf8_general_ci"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_authors_on_name"
  end

  create_table "authors_citations", charset: "utf8", force: :cascade do |t|
    t.integer "citation_id", null: false
    t.integer "author_id", null: false
    t.integer "position", default: 999999
    t.index ["author_id"], name: "index_authors_citations_on_author_id"
    t.index ["citation_id", "author_id"], name: "index_authors_citations_on_citation_id_and_author_id"
    t.index ["position"], name: "index_authors_citations_on_position"
  end

  create_table "citation_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "citations", id: :integer, charset: "utf8mb4", collation: "utf8mb4_bin", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "citation_type_id"
    t.string "name", limit: 500, collation: "utf8_general_ci"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "refman", collation: "utf8_general_ci"
    t.string "pmid", collation: "utf8_general_ci"
    t.binary "abstract"
    t.string "page_number_start"
    t.string "page_number_end"
    t.string "registry_number"
    t.string "doi"
    t.string "other"
    t.string "accession_number"
    t.text "authors"
    t.index ["authors"], name: "index_citations_on_authors", length: 255
    t.index ["citation_type_id"], name: "index_citations_on_citation_type_id"
    t.index ["name"], name: "index_citations_on_name"
    t.index ["pmid"], name: "index_citations_on_pmid"
  end

  create_table "citations_keywords", id: false, charset: "utf8", force: :cascade do |t|
    t.integer "citation_id", null: false
    t.integer "keyword_id", null: false
    t.index ["citation_id", "keyword_id"], name: "index_citations_keywords_on_citation_id_and_keyword_id"
    t.index ["keyword_id"], name: "index_citations_keywords_on_keyword_id"
  end

  create_table "citations_projects", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "citation_id"
    t.integer "project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "consensus_type_id"
    t.boolean "pilot_flag"
    t.string "screening_status", default: "asu"
    t.text "refman"
    t.text "other_reference"
    t.index ["citation_id"], name: "index_citations_projects_on_citation_id"
    t.index ["consensus_type_id"], name: "index_citations_projects_on_consensus_type_id"
    t.index ["project_id"], name: "index_citations_projects_on_project_id"
    t.index ["screening_status"], name: "index_citations_projects_on_screening_status"
  end

  create_table "color_choices", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "hex_code"
    t.string "rgb_code"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "colorings", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "colorable_type"
    t.bigint "colorable_id"
    t.integer "color_choice_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["color_choice_id"], name: "index_colorings_on_color_choice_id"
    t.index ["colorable_type", "colorable_id"], name: "index_colorings_on_colorable_type_and_colorable_id"
  end

  create_table "colors", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "hex_code"
    t.string "name"
  end

  create_table "comparable_elements", id: :integer, charset: "utf8", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "comparable_type"
    t.integer "comparable_id"
    t.index ["comparable_type", "comparable_id"], name: "index_comparable_elements_on_comparable_type_and_comparable_id"
  end

  create_table "comparate_groups", id: :integer, charset: "utf8", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "comparison_id"
    t.index ["comparison_id"], name: "index_comparate_groups_on_comparison_id"
  end

  create_table "comparates", id: :integer, charset: "utf8", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "comparate_group_id"
    t.integer "comparable_element_id"
    t.index ["comparable_element_id"], name: "index_comparates_on_comparable_element_id"
    t.index ["comparate_group_id"], name: "index_comparates_on_comparate_group_id"
  end

  create_table "comparisons", id: :integer, charset: "utf8", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "is_anova", default: false, null: false
  end

  create_table "comparisons_arms_rssms", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "comparison_id"
    t.integer "extractions_extraction_forms_projects_sections_type1_id"
    t.integer "result_statistic_sections_measure_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["comparison_id"], name: "index_comparisons_arms_rssms_on_comparison_id"
    t.index ["extractions_extraction_forms_projects_sections_type1_id"], name: "index_comparisons_arms_rssms_on_eefpst_id"
    t.index ["result_statistic_sections_measure_id"], name: "index_comparisons_arms_rssms_on_rssm_id"
  end

  create_table "comparisons_measures", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "measure_id"
    t.integer "comparison_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["comparison_id"], name: "index_comparisons_measures_on_comparison_id"
    t.index ["measure_id"], name: "index_comparisons_measures_on_measure_id"
  end

  create_table "comparisons_result_statistic_sections", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "comparison_id"
    t.integer "result_statistic_section_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["comparison_id", "result_statistic_section_id"], name: "index_crss_on_c_id_rss_id"
    t.index ["result_statistic_section_id"], name: "index_crss_on_rss_id"
  end

  create_table "consensus_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "data_analysis_levels", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "data_audits", id: :integer, charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.boolean "epc_source"
    t.string "epc_name"
    t.string "non_epc_name"
    t.string "capture_method"
    t.string "distiller_w_results"
    t.string "single_multiple_w_consolidation"
    t.text "notes"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "pct_extractions_with_unstructured_data"
    t.integer "project_id"
    t.index ["project_id"], name: "index_data_audits_on_project_id"
  end

  create_table "degrees", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_degrees_on_name", unique: true
  end

  create_table "degrees_profiles", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "degree_id"
    t.integer "profile_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["degree_id", "profile_id"], name: "index_degrees_profiles_on_degree_id_and_profile_id", unique: true
    t.index ["profile_id"], name: "index_degrees_profiles_on_profile_id"
  end

  create_table "dependencies", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "dependable_type"
    t.integer "dependable_id"
    t.string "prerequisitable_type"
    t.integer "prerequisitable_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["dependable_type", "dependable_id", "prerequisitable_type", "prerequisitable_id"], name: "index_dependencies_on_dtype_did_ptype_pid_uniq", unique: true
    t.index ["prerequisitable_type", "prerequisitable_id"], name: "index_dependencies_on_ptype_pid"
  end

  create_table "dispatches", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "dispatchable_type"
    t.integer "dispatchable_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["dispatchable_type", "dispatchable_id"], name: "index_dispatches_on_dispatchable_type_and_dispatchable_id"
    t.index ["user_id"], name: "index_dispatches_on_user_id"
  end

  create_table "eefps_qrcfs", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "extractions_extraction_forms_projects_sections_type1_id"
    t.integer "extractions_extraction_forms_projects_section_id"
    t.integer "question_row_column_field_id"
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["extractions_extraction_forms_projects_section_id"], name: "index_eefpsqrcf_on_eefps_id"
    t.index ["extractions_extraction_forms_projects_sections_type1_id", "extractions_extraction_forms_projects_section_id", "question_row_column_field_id"], name: "index_eefpsqrcf_on_eefpst1_id_eefps_id_qrcf_id"
    t.index ["question_row_column_field_id"], name: "index_eefpsqrcf_on_qrcf_id"
  end

  create_table "eefpsqrcf_qrcqrcos", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "eefps_qrcf_id"
    t.integer "question_row_columns_question_row_column_option_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["eefps_qrcf_id", "question_row_columns_question_row_column_option_id"], name: "index_eefpsqrcfqrcqrco_on_eefps_qrcf_id_qrcqrco_id"
    t.index ["question_row_columns_question_row_column_option_id"], name: "index_eefpsqrcfqrcqrco_on_qrcqrco_id"
  end

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "sent"
    t.string "action"
    t.string "resource"
    t.integer "resource_id"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "export_types", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_export_types_on_name", unique: true
  end

  create_table "exported_files", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.integer "file_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["file_type_id"], name: "index_exported_files_on_file_type_id"
    t.index ["project_id"], name: "index_exported_files_on_project_id"
    t.index ["user_id"], name: "index_exported_files_on_user_id"
  end

  create_table "exported_items", charset: "utf8", force: :cascade do |t|
    t.bigint "export_type_id"
    t.text "external_url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "user_email"
    t.bigint "project_id"
    t.index ["export_type_id"], name: "index_exported_items_on_export_type_id"
    t.index ["project_id"], name: "index_exported_items_on_project_id"
  end

  create_table "external_service_providers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "external_service_providers_projects_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "external_service_provider_id", null: false
    t.integer "project_id", null: false
    t.integer "user_id", null: false
    t.string "api_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_service_provider_id"], name: "index_esppu_on_esp_id"
    t.index ["project_id"], name: "index_esppu_on_project_id"
    t.index ["user_id"], name: "index_esppu_on_user_id"
  end

  create_table "extraction_checksums", charset: "utf8", force: :cascade do |t|
    t.bigint "extraction_id"
    t.string "hexdigest"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "is_stale"
    t.index ["extraction_id"], name: "index_extraction_checksums_on_extraction_id"
  end

  create_table "extraction_forms", id: :integer, charset: "utf8", collation: "utf8_bin", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_extraction_forms_on_name", unique: true
  end

  create_table "extraction_forms_project_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_extraction_forms_project_types_on_name", unique: true
  end

  create_table "extraction_forms_projects", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "extraction_forms_project_type_id"
    t.integer "extraction_form_id"
    t.integer "project_id"
    t.boolean "public", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["extraction_form_id", "project_id"], name: "index_efp_on_ef_id_p_id"
    t.index ["extraction_forms_project_type_id", "extraction_form_id", "project_id"], name: "index_efp_on_efpt_id_ef_id_p_id"
    t.index ["project_id"], name: "index_efp_on_p_id"
  end

  create_table "extraction_forms_projects_section_options", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "extraction_forms_projects_section_id"
    t.boolean "by_type1"
    t.boolean "include_total"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["extraction_forms_projects_section_id"], name: "efpso_on_efps_id", unique: true
  end

  create_table "extraction_forms_projects_section_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_extraction_forms_projects_section_types_on_name", unique: true
  end

  create_table "extraction_forms_projects_sections", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "extraction_forms_project_id"
    t.integer "extraction_forms_projects_section_type_id"
    t.integer "section_id"
    t.integer "extraction_forms_projects_section_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "hidden", default: false
    t.string "helper_message"
    t.integer "pos", default: 999999
    t.text "instructions"
    t.index ["extraction_forms_project_id", "extraction_forms_projects_section_type_id", "section_id", "extraction_forms_projects_section_id"], name: "index_efps_on_efp_id_efpst_id_s_id_efps_id"
    t.index ["extraction_forms_projects_section_id"], name: "index_efps_on_efps_id"
    t.index ["extraction_forms_projects_section_type_id"], name: "index_efps_on_efpst_id"
    t.index ["pos"], name: "index_extraction_forms_projects_sections_on_pos"
    t.index ["section_id"], name: "index_efps_on_s_id"
  end

  create_table "extraction_forms_projects_sections_type1_rows", charset: "utf8", force: :cascade do |t|
    t.bigint "extraction_forms_projects_sections_type1_id"
    t.bigint "population_name_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["extraction_forms_projects_sections_type1_id"], name: "index_efpst1r_on_efpst1_id"
    t.index ["population_name_id"], name: "index_efpst1r_on_pn_id"
  end

  create_table "extraction_forms_projects_sections_type1s", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "extraction_forms_projects_section_id"
    t.integer "type1_id"
    t.integer "type1_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.text "instructions"
    t.index ["extraction_forms_projects_section_id", "type1_id", "type1_type_id"], name: "index_efpst1_on_efps_id_t1_id_t1_type_id_uniq", unique: true
    t.index ["pos"], name: "index_extraction_forms_projects_sections_type1s_on_pos"
    t.index ["type1_id"], name: "index_efpst1_on_t1_id"
    t.index ["type1_type_id"], name: "index_efpst1_on_t1_type_id"
  end

  create_table "extraction_forms_projects_sections_type1s_timepoint_names", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "extraction_forms_projects_sections_type1_id"
    t.integer "timepoint_name_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["extraction_forms_projects_sections_type1_id", "timepoint_name_id"], name: "index_efpst1tn_on_efpst1_id_tn_id"
    t.index ["timepoint_name_id"], name: "index_efpst1tn_on_tn_id"
  end

  create_table "extractions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "project_id"
    t.integer "citations_project_id"
    t.integer "projects_users_role_id"
    t.boolean "consolidated", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.datetime "approved_on"
    t.index ["citations_project_id"], name: "index_extractions_on_citations_project_id"
    t.index ["project_id", "citations_project_id", "projects_users_role_id"], name: "index_e_on_p_id_cp_id_pur_id_uniq"
    t.index ["projects_users_role_id"], name: "index_extractions_on_projects_users_role_id"
    t.index ["user_id"], name: "index_extractions_on_user_id"
  end

  create_table "extractions_extraction_forms_projects_sections", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "extraction_id"
    t.integer "extraction_forms_projects_section_id"
    t.integer "extractions_extraction_forms_projects_section_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["extraction_forms_projects_section_id"], name: "index_eefps_on_efps_id"
    t.index ["extraction_id", "extraction_forms_projects_section_id", "extractions_extraction_forms_projects_section_id"], name: "index_eefps_on_e_id_efps_id_eefps_id"
    t.index ["extractions_extraction_forms_projects_section_id"], name: "index_eefps_on_eefps_id"
  end

  create_table "extractions_extraction_forms_projects_sections_followup_fields", charset: "utf8", force: :cascade do |t|
    t.bigint "extractions_extraction_forms_projects_section_id"
    t.bigint "followup_field_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "extractions_extraction_forms_projects_sections_type1_id"
    t.index ["extractions_extraction_forms_projects_section_id", "extractions_extraction_forms_projects_sections_type1_id", "followup_field_id"], name: "index_eefpsff_on_eefps_eefpst1_ff_id", unique: true
    t.index ["extractions_extraction_forms_projects_sections_type1_id"], name: "eefpst1_index"
    t.index ["followup_field_id"], name: "index_eefpsff_on_followup_field_id"
  end

  create_table "extractions_extraction_forms_projects_sections_type1_row_columns", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "extractions_extraction_forms_projects_sections_type1_row_id"
    t.integer "timepoint_name_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["extractions_extraction_forms_projects_sections_type1_row_id", "timepoint_name_id"], name: "index_eefpst1rc_on_eefpst1r_id_tn_id"
    t.index ["timepoint_name_id"], name: "index_eefpst1rc_on_tn_id"
  end

  create_table "extractions_extraction_forms_projects_sections_type1_rows", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "extractions_extraction_forms_projects_sections_type1_id"
    t.integer "population_name_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["extractions_extraction_forms_projects_sections_type1_id", "population_name_id"], name: "index_eefpst1r_on_eefpst1_id_pn_id"
    t.index ["population_name_id"], name: "index_eefpst1r_on_pn_id"
  end

  create_table "extractions_extraction_forms_projects_sections_type1s", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "type1_type_id", default: 1
    t.integer "extractions_extraction_forms_projects_section_id"
    t.integer "type1_id"
    t.string "units"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.boolean "comparisons_assisted", default: false
    t.index ["extractions_extraction_forms_projects_section_id"], name: "index_eefpst1_on_eefps_id"
    t.index ["pos"], name: "eefpst1_id"
    t.index ["type1_id"], name: "index_eefpst1_on_t1_id"
    t.index ["type1_type_id", "extractions_extraction_forms_projects_section_id", "type1_id"], name: "index_eefpst1_on_t1t_id_eefps_id_t1_id", unique: true
  end

  create_table "extractions_key_questions_projects_selections", charset: "utf8", force: :cascade do |t|
    t.bigint "extraction_id"
    t.bigint "key_questions_project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["extraction_id"], name: "index_ekqps_on_extractions_id"
    t.index ["key_questions_project_id"], name: "index_ekqps_on_key_questions_projects_id"
  end

  create_table "file_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_file_types_on_name", unique: true
  end

  create_table "followup_fields", charset: "utf8", force: :cascade do |t|
    t.bigint "question_row_columns_question_row_column_option_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "followup_field_id"
    t.index ["followup_field_id"], name: "index_ffs_on_followup_field_id"
    t.index ["question_row_columns_question_row_column_option_id"], name: "index_followup_fields_on_qrcqrco_id"
  end

  create_table "frequencies", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "fulltext_screening_results", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "fulltext_screening_id"
    t.bigint "user_id"
    t.bigint "citations_project_id"
    t.integer "label", limit: 1
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "privileged", default: false
    t.boolean "form_complete", default: false, null: false
    t.index ["citations_project_id"], name: "fsr_on_cp"
    t.index ["fulltext_screening_id", "user_id", "citations_project_id", "privileged"], name: "unique_fulltext_screening_results", unique: true
    t.index ["fulltext_screening_id"], name: "index_fulltext_screening_results_on_fulltext_screening_id"
    t.index ["user_id"], name: "fsr_on_u"
  end

  create_table "fulltext_screening_results_reasons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "fulltext_screening_result_id", null: false
    t.bigint "reason_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fulltext_screening_result_id", "reason_id"], name: "fsrr_fsr_on_r", unique: true
    t.index ["fulltext_screening_result_id"], name: "fsrr_on_fsr"
    t.index ["reason_id"], name: "fsrr_on_r"
  end

  create_table "fulltext_screening_results_tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "fulltext_screening_result_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fulltext_screening_result_id", "tag_id"], name: "fsrt_fsr_on_t", unique: true
    t.index ["fulltext_screening_result_id"], name: "fsrt_on_fsr"
    t.index ["tag_id"], name: "fsrt_on_t"
  end

  create_table "fulltext_screenings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "project_id"
    t.string "fulltext_screening_type", default: "single-perpetual", null: false
    t.integer "no_of_citations", default: 0, null: false
    t.boolean "exclusive_users", default: false, null: false
    t.boolean "yes_tag_required", default: false, null: false
    t.boolean "no_tag_required", default: false, null: false
    t.boolean "maybe_tag_required", default: false, null: false
    t.boolean "yes_reason_required", default: false, null: false
    t.boolean "no_reason_required", default: false, null: false
    t.boolean "maybe_reason_required", default: false, null: false
    t.boolean "yes_note_required", default: false, null: false
    t.boolean "no_note_required", default: false, null: false
    t.boolean "maybe_note_required", default: false, null: false
    t.boolean "hide_author", default: false, null: false
    t.boolean "hide_journal", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "yes_form_required", default: false, null: false
    t.boolean "no_form_required", default: false, null: false
    t.boolean "maybe_form_required", default: false, null: false
    t.index ["project_id"], name: "index_fulltext_screenings_on_project_id"
  end

  create_table "fulltext_screenings_reasons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "fulltext_screening_id", null: false
    t.bigint "reason_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pos", default: 999999
    t.index ["fulltext_screening_id", "reason_id"], name: "fsr_fs_on_r", unique: true
    t.index ["fulltext_screening_id"], name: "fsr_on_fs"
    t.index ["reason_id"], name: "fsr_on_r"
  end

  create_table "fulltext_screenings_reasons_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "fulltext_screening_id"
    t.bigint "reason_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pos", default: 999999
    t.index ["fulltext_screening_id", "reason_id", "user_id"], name: "fs_r_u", unique: true
    t.index ["fulltext_screening_id"], name: "fsru_on_fs"
    t.index ["reason_id"], name: "fsru_on_r"
    t.index ["user_id"], name: "fsru_on_u"
  end

  create_table "fulltext_screenings_tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "fulltext_screening_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pos", default: 999999
    t.index ["fulltext_screening_id", "tag_id"], name: "fst_fs_on_t", unique: true
    t.index ["fulltext_screening_id"], name: "fst_on_fs"
    t.index ["tag_id"], name: "fst_on_t"
  end

  create_table "fulltext_screenings_tags_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "fulltext_screening_id"
    t.bigint "tag_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pos", default: 999999
    t.index ["fulltext_screening_id", "tag_id", "user_id"], name: "fs_t_u", unique: true
    t.index ["fulltext_screening_id"], name: "fstu_on_fs"
    t.index ["tag_id"], name: "fstu_on_t"
    t.index ["user_id"], name: "fstu_on_u"
  end

  create_table "fulltext_screenings_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "fulltext_screening_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fulltext_screening_id", "user_id"], name: "u_id_on_fs_id", unique: true
    t.index ["fulltext_screening_id"], name: "fsu_on_fs"
    t.index ["user_id"], name: "fsu_on_u"
  end

  create_table "funding_sources", id: :integer, charset: "utf8", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "funding_sources_sd_meta_data", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "funding_source_id"
    t.integer "sd_meta_datum_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["funding_source_id"], name: "index_funding_sources_sd_meta_data_on_funding_source_id"
    t.index ["sd_meta_datum_id"], name: "index_funding_sources_sd_meta_data_on_sd_meta_datum_id"
  end

  create_table "import_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_import_types_on_name", unique: true
  end

  create_table "imported_files", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "file_type_id"
    t.integer "section_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "key_question_id"
    t.integer "import_id"
    t.index ["file_type_id"], name: "index_imported_files_on_file_type_id"
    t.index ["import_id"], name: "index_imported_files_on_import_id"
    t.index ["key_question_id"], name: "index_imported_files_on_key_question_id"
    t.index ["section_id"], name: "index_imported_files_on_section_id"
  end

  create_table "imports", charset: "utf8", force: :cascade do |t|
    t.integer "import_type_id"
    t.integer "projects_user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["import_type_id"], name: "index_imports_on_import_type_id"
    t.index ["projects_user_id"], name: "index_imports_on_projects_user_id"
  end

  create_table "invitations", charset: "utf8", force: :cascade do |t|
    t.integer "role_id"
    t.string "invitable_type"
    t.bigint "invitable_id"
    t.boolean "enabled", default: false
    t.string "token"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["invitable_type", "invitable_id"], name: "index_invitations_on_invitable_type_and_invitable_id"
    t.index ["role_id"], name: "index_invitations_on_role_id"
    t.index ["token"], name: "index_invitations_on_token", unique: true
  end

  create_table "journals", id: :integer, charset: "utf8mb4", collation: "utf8mb4_bin", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "citation_id"
    t.string "volume"
    t.string "issue"
    t.string "name", limit: 1000, collation: "utf8_general_ci"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "publication_date", collation: "utf8_general_ci"
    t.index ["citation_id"], name: "index_journals_on_citation_id"
  end

  create_table "key_question_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "key_questions", id: :integer, charset: "utf8mb4", collation: "utf8mb4_bin", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.text "name", collation: "utf8_bin"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_key_questions_on_name", unique: true, length: 255
  end

  create_table "key_questions_projects", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "key_question_id"
    t.integer "project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["key_question_id", "project_id"], name: "index_kqp_on_efps_id_kq_id_p_id"
    t.index ["key_question_id", "project_id"], name: "index_kqp_on_kq_id_p_id"
    t.index ["pos"], name: "index_key_questions_projects_on_pos"
    t.index ["project_id"], name: "index_kqp_on_p_id"
  end

  create_table "key_questions_projects_questions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "key_questions_project_id"
    t.integer "question_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["key_questions_project_id"], name: "index_kqpq_on_kqp_id"
    t.index ["question_id"], name: "index_kqpq_on_q_id"
  end

  create_table "keywords", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name", limit: 5000
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "label_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "measures", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name", collation: "utf8mb4_bin"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_measures_on_name", unique: true
  end

  create_table "mesh_descriptors", charset: "utf8", force: :cascade do |t|
    t.text "name"
    t.text "resource_uri"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "mesh_descriptors_projects", charset: "utf8", force: :cascade do |t|
    t.bigint "mesh_descriptor_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["mesh_descriptor_id"], name: "index_mesh_descriptors_projects_on_mesh_descriptor_id"
    t.index ["project_id"], name: "index_mesh_descriptors_projects_on_project_id"
  end

  create_table "message_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.integer "frequency_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["frequency_id"], name: "index_message_types_on_frequency_id"
  end

  create_table "messages", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "message_type_id"
    t.string "name"
    t.text "description"
    t.datetime "start_at", precision: nil
    t.datetime "end_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "active", default: true
    t.index ["message_type_id"], name: "index_messages_on_message_type_id"
  end

  create_table "ml_models", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "timestamp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ml_models_projects", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "ml_model_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ml_model_id", "project_id"], name: "index_ml_models_projects_on_ml_model_id_and_project_id", unique: true
  end

  create_table "ml_predictions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "citations_project_id", null: false
    t.bigint "ml_model_id", null: false
    t.float "score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["citations_project_id"], name: "fk_rails_c7d0d53a87"
    t.index ["ml_model_id"], name: "fk_rails_6c1d59597a"
  end

  create_table "model_performances", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "ml_model_id"
    t.string "label"
    t.float "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ml_model_id"], name: "index_model_performances_on_ml_model_id"
  end

  create_table "notes", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "notable_type"
    t.integer "notable_id"
    t.text "value"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "projects_users_role_id"
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable_type_and_notable_id"
    t.index ["projects_users_role_id"], name: "index_notes_on_projects_users_role_id"
  end

  create_table "oauth_access_grants", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "revoked_at", precision: nil
    t.string "scopes"
    t.index ["application_id"], name: "fk_rails_b4b53e07b8"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "fk_rails_732cb83ab7"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "orderings", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "orderable_type"
    t.integer "orderable_id"
    t.integer "position"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["orderable_type", "orderable_id"], name: "index_orderings_on_type_id_uniq", unique: true
  end

  create_table "organizations", id: :integer, charset: "utf8mb4", collation: "utf8mb4_bin", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", collation: "utf8_general_ci"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
  end

  create_table "pending_invitations", charset: "utf8", force: :cascade do |t|
    t.bigint "invitation_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["invitation_id"], name: "index_pending_invitations_on_invitation_id"
    t.index ["user_id"], name: "index_pending_invitations_on_user_id"
  end

  create_table "population_names", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.text "description", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "predictions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "citations_project_id"
    t.integer "value"
    t.integer "num_yes_votes"
    t.float "predicted_probability"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["citations_project_id"], name: "index_predictions_on_citations_project_id"
  end

  create_table "priorities", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "citations_project_id"
    t.integer "value"
    t.integer "num_times_labeled"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["citations_project_id"], name: "index_priorities_on_citations_project_id"
  end

  create_table "profiles", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "organization_id"
    t.string "time_zone", default: "UTC"
    t.string "username"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.boolean "advanced_mode", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "projects_paginate_per"
    t.boolean "conflict_resolution_label_visibility", default: false
    t.text "storage"
    t.boolean "follow_project_settings_in_conflict_resolution", default: true, null: false
    t.index ["organization_id"], name: "index_profiles_on_organization_id"
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
    t.index ["username"], name: "index_profiles_on_username", unique: true
  end

  create_table "projects", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "attribution"
    t.text "methodology_description"
    t.string "prospero"
    t.string "doi"
    t.text "notes"
    t.string "funding_source"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "authors_of_report"
    t.boolean "exclude_personal_conflicts", default: false, null: false
    t.boolean "as_limit_one_reason", default: true, null: false
    t.boolean "fs_limit_one_reason", default: true, null: false
    t.boolean "as_allow_adding_reasons", default: true, null: false
    t.boolean "as_allow_adding_tags", default: true, null: false
    t.boolean "fs_allow_adding_reasons", default: true, null: false
    t.boolean "fs_allow_adding_tags", default: true, null: false
    t.boolean "force_training", default: false, null: false
    t.integer "source_project_id"
  end

  create_table "projects_reasons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "reason_id", null: false
    t.string "screening_type", null: false
    t.integer "pos", default: 999999
    t.integer "integer", default: 999999
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pos"], name: "index_projects_reasons_on_pos"
    t.index ["project_id", "reason_id", "screening_type"], name: "p_r_st_on_pr", unique: true
    t.index ["project_id"], name: "index_projects_reasons_on_project_id"
    t.index ["reason_id"], name: "index_projects_reasons_on_reason_id"
  end

  create_table "projects_tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "tag_id", null: false
    t.string "screening_type", null: false
    t.integer "pos", default: 999999
    t.integer "integer", default: 999999
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pos"], name: "index_projects_tags_on_pos"
    t.index ["project_id", "tag_id", "screening_type"], name: "index_projects_tags_on_project_id_and_tag_id_and_screening_type", unique: true
    t.index ["project_id"], name: "index_projects_tags_on_project_id"
    t.index ["tag_id"], name: "index_projects_tags_on_tag_id"
  end

  create_table "projects_users", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "permissions", default: 0, null: false
    t.boolean "is_expert", default: false
    t.index ["project_id", "user_id"], name: "index_pu_on_p_id_u_id_uniq", unique: true
    t.index ["user_id"], name: "index_projects_users_on_user_id"
  end

  create_table "projects_users_roles", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "projects_user_id"
    t.integer "role_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["projects_user_id", "role_id"], name: "index_pur_on_pu_id_r_id_uniq", unique: true
    t.index ["role_id"], name: "index_projects_users_roles_on_role_id"
  end

  create_table "projects_users_roles_teams", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "projects_users_role_id"
    t.integer "team_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["projects_users_role_id"], name: "index_projects_users_roles_teams_on_projects_users_role_id"
    t.index ["team_id"], name: "index_projects_users_roles_teams_on_team_id"
  end

  create_table "projects_users_term_groups_colors", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "term_groups_color_id"
    t.integer "projects_user_id"
    t.index ["projects_user_id"], name: "index_projects_users_term_groups_colors_on_projects_user_id"
    t.index ["term_groups_color_id"], name: "index_projects_users_term_groups_colors_on_term_groups_color_id"
  end

  create_table "projects_users_term_groups_colors_terms", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "projects_users_term_groups_color_id"
    t.integer "term_id"
    t.index ["projects_users_term_groups_color_id"], name: "index_putgcp_on_putc_id"
    t.index ["term_id"], name: "index_putgcp_on_terms_id"
  end

  create_table "publication_reminders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publishings", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "publishable_type"
    t.integer "publishable_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["publishable_type", "publishable_id", "user_id"], name: "index_publishings_on_type_id_user_id_uniq", unique: true
    t.index ["user_id"], name: "index_publishings_on_user_id"
  end

  create_table "quality_dimension_options", id: :integer, charset: "utf8", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "quality_dimension_questions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "quality_dimension_section_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["quality_dimension_section_id"], name: "index_qdq_on_qds_id"
  end

  create_table "quality_dimension_questions_quality_dimension_options", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "quality_dimension_question_id"
    t.integer "quality_dimension_option_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["quality_dimension_option_id"], name: "index_qdqqdo_on_qdo_id"
    t.index ["quality_dimension_question_id", "quality_dimension_option_id"], name: "index_qdq_id_qdo_id_uniq", unique: true
  end

  create_table "quality_dimension_section_groups", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "quality_dimension_sections", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "quality_dimension_section_group_id"
    t.index ["quality_dimension_section_group_id"], name: "index_qds_on_qdsg_id"
  end

  create_table "question_row_column_fields", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "question_row_column_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "question_row_column_field_id"
    t.index ["question_row_column_field_id"], name: "index_qrcfs_on_question_row_column_field_id"
    t.index ["question_row_column_id"], name: "index_qrcf_on_qrc_id_deleted_at"
    t.index ["question_row_column_id"], name: "index_question_row_column_fields_on_question_row_column_id"
  end

  create_table "question_row_column_options", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "description"
    t.string "field_type"
    t.string "label"
  end

  create_table "question_row_column_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "question_row_columns", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "question_row_id"
    t.integer "question_row_column_type_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["question_row_column_type_id"], name: "fk_rails_9753342129"
    t.index ["question_row_id", "question_row_column_type_id"], name: "index_qrc_on_qr_id_qrct_id"
  end

  create_table "question_row_columns_question_row_column_options", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "question_row_column_id"
    t.integer "question_row_column_option_id"
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_question_row_columns_question_row_column_options_on_pos"
    t.index ["question_row_column_id", "question_row_column_option_id"], name: "index_qrcqrco_on_qrc_id_qrco_id"
    t.index ["question_row_column_option_id"], name: "fk_rails_dd7bf341f1"
  end

  create_table "question_rows", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "question_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["question_id"], name: "index_question_rows_on_question_id"
  end

  create_table "questions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "extraction_forms_projects_section_id"
    t.text "name"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["extraction_forms_projects_section_id"], name: "index_questions_on_extraction_forms_projects_section_id"
    t.index ["pos"], name: "index_questions_on_pos"
  end

  create_table "reasons", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name", limit: 1000, collation: "utf8mb4_bin"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "records", id: :integer, charset: "utf8", force: :cascade do |t|
    t.text "name"
    t.string "recordable_type"
    t.integer "recordable_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["recordable_id"], name: "index_records_on_recordable_id"
    t.index ["recordable_type", "recordable_id"], name: "index_records_on_recordable_type_and_recordable_id"
  end

  create_table "result_statistic_section_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "result_statistic_section_types_measures", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "result_statistic_section_type_id"
    t.integer "measure_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "default", default: false
    t.integer "type1_type_id"
    t.integer "result_statistic_section_types_measure_id"
    t.index ["measure_id"], name: "index_rsstm_on_m_id"
    t.index ["result_statistic_section_type_id"], name: "index_rsstm_on_rsst_id"
    t.index ["result_statistic_section_types_measure_id"], name: "index_rsstm_on_rsstm_id"
    t.index ["type1_type_id"], name: "index_result_statistic_section_types_measures_on_type1_type_id"
  end

  create_table "result_statistic_sections", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "result_statistic_section_type_id"
    t.integer "population_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["population_id"], name: "index_result_statistic_sections_on_population_id"
    t.index ["result_statistic_section_type_id", "population_id"], name: "index_rss_on_rsst_id_eefpst1rc_id_uniq", unique: true
  end

  create_table "result_statistic_sections_measures", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "measure_id"
    t.integer "result_statistic_section_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "result_statistic_sections_measure_id"
    t.integer "pos", default: 999999
    t.index ["measure_id", "result_statistic_section_id", "result_statistic_sections_measure_id"], name: "index_rssm_on_m_id_rss_id_rssm_id"
    t.index ["pos"], name: "index_result_statistic_sections_measures_on_pos"
    t.index ["result_statistic_section_id"], name: "fk_rails_9c731fa440"
    t.index ["result_statistic_sections_measure_id"], name: "fk_rails_13a8ed2ac3"
  end

  create_table "result_statistic_sections_measures_comparisons", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "result_statistic_section_id"
    t.integer "comparison_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["comparison_id"], name: "index_rssmc_on_comparison_id"
    t.index ["result_statistic_section_id"], name: "index_rssmc_on_rss_id"
  end

  create_table "review_types", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "roles", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "screening_forms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "project_id"
    t.string "form_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_screening_forms_on_project_id"
  end

  create_table "screening_option_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "screening_options", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "label_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "project_id"
    t.integer "screening_option_type_id"
    t.index ["label_type_id"], name: "index_screening_options_on_label_type_id"
    t.index ["project_id"], name: "index_screening_options_on_project_id"
    t.index ["screening_option_type_id"], name: "index_screening_options_on_screening_option_type_id"
  end

  create_table "screening_qualifications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "citations_project_id"
    t.bigint "user_id"
    t.string "qualification_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["citations_project_id", "user_id", "qualification_type"], name: "cp_u_qt", unique: true
    t.index ["citations_project_id"], name: "index_screening_qualifications_on_citations_project_id"
    t.index ["user_id"], name: "index_screening_qualifications_on_user_id"
  end

  create_table "sd_analytic_frameworks", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_meta_datum_id"
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_analytic_frameworks_on_pos"
    t.index ["sd_meta_datum_id"], name: "index_sd_analytic_frameworks_on_sd_meta_datum_id"
  end

  create_table "sd_evidence_tables", charset: "utf8", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "sd_result_item_id"
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_evidence_tables_on_pos"
    t.index ["sd_result_item_id"], name: "index_sd_evidence_tables_on_sd_result_item_id"
  end

  create_table "sd_grey_literature_searches", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_meta_datum_id"
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_grey_literature_searches_on_pos"
    t.index ["sd_meta_datum_id"], name: "index_sd_grey_literature_searches_on_sd_meta_datum_id"
  end

  create_table "sd_journal_article_urls", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_meta_datum_id"
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_journal_article_urls_on_pos"
    t.index ["sd_meta_datum_id"], name: "index_sd_journal_article_urls_on_sd_meta_datum_id"
  end

  create_table "sd_key_questions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_meta_datum_id"
    t.integer "sd_key_question_id"
    t.integer "key_question_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "includes_meta_analysis"
    t.integer "pos", default: 999999
    t.index ["key_question_id"], name: "index_sd_key_questions_on_key_question_id"
    t.index ["pos"], name: "index_sd_key_questions_on_pos"
    t.index ["sd_key_question_id"], name: "index_sd_key_questions_on_sd_key_question_id"
    t.index ["sd_meta_datum_id"], name: "index_sd_key_questions_on_sd_meta_datum_id"
  end

  create_table "sd_key_questions_key_question_types", charset: "utf8", force: :cascade do |t|
    t.bigint "sd_key_question_id"
    t.bigint "key_question_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["key_question_type_id"], name: "index_kq_types"
    t.index ["sd_key_question_id", "key_question_type_id"], name: "index_sd_kqs_kq_types"
  end

  create_table "sd_key_questions_projects", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_key_question_id"
    t.integer "key_questions_project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["key_questions_project_id"], name: "index_sd_key_questions_projects_on_key_questions_project_id"
    t.index ["sd_key_question_id"], name: "index_sd_key_questions_projects_on_sd_key_question_id"
  end

  create_table "sd_key_questions_sd_picods", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_key_question_id"
    t.integer "sd_picod_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_key_questions_sd_picods_on_pos"
    t.index ["sd_key_question_id"], name: "index_sd_key_questions_sd_picods_on_sd_key_question_id"
    t.index ["sd_picod_id"], name: "index_sd_key_questions_sd_picods_on_sd_picod_id"
  end

  create_table "sd_meta_data", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "project_id"
    t.string "report_title"
    t.datetime "date_of_last_search", precision: nil
    t.datetime "date_of_publication_to_srdr", precision: nil
    t.datetime "date_of_publication_full_report", precision: nil
    t.text "authors_conflict_of_interest_of_full_report"
    t.text "protocol_link"
    t.text "full_report_link"
    t.text "structured_abstract_link"
    t.text "key_messages_link"
    t.text "abstract_summary_link"
    t.text "evidence_summary_link"
    t.text "disposition_of_comments_link"
    t.text "srdr_data_link"
    t.text "most_previous_version_srdr_link"
    t.text "most_previous_version_full_report_link"
    t.text "overall_purpose_of_review"
    t.string "state", default: "DRAFT", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "section_flag_0", default: false, null: false
    t.boolean "section_flag_1", default: false, null: false
    t.boolean "section_flag_2", default: false, null: false
    t.boolean "section_flag_3", default: false, null: false
    t.boolean "section_flag_4", default: false, null: false
    t.boolean "section_flag_5", default: false, null: false
    t.boolean "section_flag_6", default: false, null: false
    t.string "report_accession_id"
    t.text "authors"
    t.boolean "section_flag_7", default: false, null: false
    t.string "prospero_link"
    t.bigint "review_type_id"
    t.text "stakeholders_key_informants"
    t.text "stakeholders_technical_experts"
    t.text "stakeholders_peer_reviewers"
    t.text "stakeholders_others"
    t.boolean "section_flag_8", default: false, null: false
    t.text "organization"
    t.index ["project_id"], name: "index_sd_meta_data_on_project_id"
    t.index ["report_accession_id"], name: "index_sd_meta_data_on_report_accession_id"
    t.index ["review_type_id"], name: "index_sd_meta_data_on_review_type_id"
  end

  create_table "sd_meta_data_figures", charset: "utf8", force: :cascade do |t|
    t.bigint "sd_figurable_id"
    t.string "sd_figurable_type"
    t.string "p_type"
    t.text "alt_text"
    t.string "outcome_type", default: "Categorical"
    t.string "intervention_name"
    t.string "comparator_name"
    t.string "effect_size_measure_name"
    t.string "overall_effect_size"
    t.string "overall_95_ci_low"
    t.string "overall_95_ci_high"
    t.string "overall_i_squared"
    t.text "other_heterogeneity_statistics"
    t.index ["sd_figurable_id", "sd_figurable_type"], name: "index_sd_analysis_figures_on_type_id"
  end

  create_table "sd_meta_data_queries", charset: "utf8", force: :cascade do |t|
    t.text "query_text"
    t.bigint "sd_meta_datum_id"
    t.bigint "projects_user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["projects_user_id"], name: "index_sd_meta_data_queries_on_projects_user_id"
    t.index ["sd_meta_datum_id"], name: "index_sd_meta_data_queries_on_sd_meta_datum_id"
  end

  create_table "sd_meta_regression_analysis_results", charset: "utf8", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "sd_result_item_id"
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_meta_regression_analysis_results_on_pos"
    t.index ["sd_result_item_id"], name: "index_sd_meta_regression_analysis_results_on_sd_result_item_id"
  end

  create_table "sd_narrative_results", charset: "utf8", force: :cascade do |t|
    t.text "narrative_results"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "narrative_results_by_population"
    t.text "narrative_results_by_intervention"
    t.bigint "sd_result_item_id"
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_narrative_results_on_pos"
    t.index ["sd_result_item_id"], name: "index_sd_narrative_results_on_sd_result_item_id"
  end

  create_table "sd_network_meta_analysis_results", charset: "utf8", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "sd_result_item_id"
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_network_meta_analysis_results_on_pos"
    t.index ["sd_result_item_id"], name: "index_sd_network_meta_analysis_results_on_sd_result_item_id"
  end

  create_table "sd_other_items", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_meta_datum_id"
    t.text "name"
    t.text "url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_other_items_on_pos"
    t.index ["sd_meta_datum_id"], name: "index_sd_other_items_on_sd_meta_datum_id"
  end

  create_table "sd_outcomes", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "sd_outcomeable_id"
    t.string "sd_outcomeable_type"
    t.index ["name"], name: "index_sd_outcomes_on_name"
    t.index ["sd_outcomeable_id", "sd_outcomeable_type"], name: "index_sd_outcomes_on_sd_outcomeable_id_and_sd_outcomeable_type"
    t.index ["sd_outcomeable_type", "sd_outcomeable_id", "name"], name: "index_sd_outcomes_on_type_id_name", unique: true
  end

  create_table "sd_pairwise_meta_analytic_results", charset: "utf8", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "sd_result_item_id"
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_pairwise_meta_analytic_results_on_pos"
    t.index ["sd_result_item_id"], name: "index_sd_pairwise_meta_analytic_results_on_sd_result_item_id"
  end

  create_table "sd_picods", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_meta_datum_id"
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "population"
    t.text "interventions"
    t.text "comparators"
    t.text "outcomes"
    t.text "study_designs"
    t.text "settings"
    t.bigint "data_analysis_level_id"
    t.text "timing"
    t.text "other_elements"
    t.integer "pos", default: 999999
    t.index ["data_analysis_level_id"], name: "index_sd_picods_on_data_analysis_level_id"
    t.index ["pos"], name: "index_sd_picods_on_pos"
    t.index ["sd_meta_datum_id"], name: "index_sd_picods_on_sd_meta_datum_id"
  end

  create_table "sd_picods_sd_picods_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_picod_id"
    t.integer "sd_picods_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["sd_picod_id"], name: "index_sdspt_sd_picod"
    t.index ["sd_picods_type_id"], name: "index_sdspt_sd_picod_type"
  end

  create_table "sd_picods_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "sd_prisma_flows", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_meta_datum_id"
    t.text "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_prisma_flows_on_pos"
    t.index ["sd_meta_datum_id"], name: "index_sd_prisma_flows_on_sd_meta_datum_id"
  end

  create_table "sd_project_leads", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_meta_datum_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["sd_meta_datum_id"], name: "index_sd_project_leads_on_sd_meta_datum_id"
    t.index ["user_id"], name: "index_sd_project_leads_on_user_id"
  end

  create_table "sd_result_items", charset: "utf8", force: :cascade do |t|
    t.bigint "sd_key_question_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "sd_meta_datum_id"
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_result_items_on_pos"
    t.index ["sd_key_question_id"], name: "index_sd_result_items_on_sd_key_question_id"
    t.index ["sd_meta_datum_id"], name: "index_sd_result_items_on_sd_meta_datum_id"
  end

  create_table "sd_search_databases", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "sd_search_strategies", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_meta_datum_id"
    t.integer "sd_search_database_id"
    t.string "date_of_search"
    t.text "search_limits"
    t.text "search_terms"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_search_strategies_on_pos"
    t.index ["sd_meta_datum_id"], name: "index_sd_search_strategies_on_sd_meta_datum_id"
    t.index ["sd_search_database_id"], name: "index_sd_search_strategies_on_sd_search_database_id"
  end

  create_table "sd_summary_of_evidences", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "sd_meta_datum_id"
    t.integer "sd_key_question_id"
    t.text "name"
    t.string "soe_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "pos", default: 999999
    t.index ["pos"], name: "index_sd_summary_of_evidences_on_pos"
    t.index ["sd_key_question_id"], name: "index_sd_summary_of_evidences_on_sd_key_question_id"
    t.index ["sd_meta_datum_id"], name: "index_sd_summary_of_evidences_on_sd_meta_datum_id"
  end

  create_table "searchjoy_searches", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "search_type"
    t.string "query"
    t.string "normalized_query"
    t.integer "results_count"
    t.datetime "created_at", precision: nil
    t.string "convertable_type"
    t.integer "convertable_id"
    t.datetime "converted_at", precision: nil
    t.index ["convertable_type", "convertable_id"], name: "index_searchjoy_searches_on_convertable_type_and_convertable_id"
    t.index ["created_at"], name: "index_searchjoy_searches_on_created_at"
    t.index ["search_type", "created_at"], name: "index_searchjoy_searches_on_search_type_and_created_at"
    t.index ["search_type", "normalized_query", "created_at"], name: "index_searchjoy_searches_on_search_type_query"
    t.index ["user_id"], name: "index_searchjoy_searches_on_user_id"
  end

  create_table "sections", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.boolean "default", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["default"], name: "index_sections_on_default"
    t.index ["name"], name: "index_sections_on_name", unique: true
  end

  create_table "sf_abstract_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "value"
    t.string "followup"
    t.string "equality"
    t.bigint "sf_cell_id"
    t.bigint "abstract_screening_result_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abstract_screening_result_id"], name: "index_sf_abstract_records_on_abstract_screening_result_id"
    t.index ["sf_cell_id"], name: "index_sf_abstract_records_on_sf_cell_id"
  end

  create_table "sf_cells", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "sf_row_id"
    t.bigint "sf_column_id"
    t.string "cell_type", null: false
    t.integer "min", default: 0, null: false
    t.integer "max", default: 255, null: false
    t.boolean "with_equality", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sf_column_id"], name: "index_sf_cells_on_sf_column_id"
    t.index ["sf_row_id", "sf_column_id"], name: "index_sf_cells_on_sf_row_id_and_sf_column_id", unique: true
    t.index ["sf_row_id"], name: "index_sf_cells_on_sf_row_id"
  end

  create_table "sf_columns", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "sf_question_id"
    t.integer "pos", default: 999999
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sf_question_id"], name: "index_sf_columns_on_sf_question_id"
  end

  create_table "sf_fulltext_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "value"
    t.string "followup"
    t.string "equality"
    t.bigint "sf_cell_id"
    t.bigint "fulltext_screening_result_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fulltext_screening_result_id"], name: "index_sf_fulltext_records_on_fulltext_screening_result_id"
    t.index ["sf_cell_id"], name: "index_sf_fulltext_records_on_sf_cell_id"
  end

  create_table "sf_options", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "sf_cell_id"
    t.string "name", null: false
    t.boolean "with_followup", default: false, null: false
    t.integer "pos", default: 999999
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "sf_cell_id"], name: "index_sf_options_on_name_and_sf_cell_id", unique: true
    t.index ["sf_cell_id"], name: "index_sf_options_on_sf_cell_id"
  end

  create_table "sf_questions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "screening_form_id"
    t.string "name"
    t.text "description"
    t.integer "pos", default: 999999
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["screening_form_id"], name: "index_sf_questions_on_screening_form_id"
  end

  create_table "sf_rows", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "sf_question_id"
    t.integer "pos", default: 999999
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sf_question_id"], name: "index_sf_rows_on_sf_question_id"
  end

  create_table "statuses", charset: "utf8", force: :cascade do |t|
    t.string "name"
  end

  create_table "statusings", charset: "utf8", force: :cascade do |t|
    t.string "statusable_type"
    t.bigint "statusable_id"
    t.bigint "status_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["status_id"], name: "index_statusings_on_status_id"
    t.index ["statusable_type", "statusable_id", "status_id"], name: "index_statusings_on_type_id_status_id_uniq", unique: true
  end

  create_table "suggestions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "suggestable_type"
    t.integer "suggestable_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["suggestable_type", "suggestable_id", "user_id"], name: "index_suggestions_on_type_id_user_id_uniq", unique: true
    t.index ["user_id"], name: "index_suggestions_on_user_id"
  end

  create_table "taggings", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "projects_users_role_id"
    t.index ["projects_users_role_id"], name: "index_taggings_on_projects_users_role_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "tags", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name", collation: "utf8mb4_bin"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "team_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "teams", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "team_type_id"
    t.integer "project_id"
    t.boolean "enabled"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["project_id"], name: "index_teams_on_project_id"
    t.index ["team_type_id"], name: "index_teams_on_team_type_id"
  end

  create_table "term_groups", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
  end

  create_table "term_groups_colors", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "term_group_id"
    t.integer "color_id"
    t.index ["color_id"], name: "index_term_groups_colors_on_color_id"
    t.index ["term_group_id"], name: "index_term_groups_colors_on_term_group_id"
  end

  create_table "terms", id: :integer, charset: "utf8mb4", collation: "utf8mb4_bin", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", collation: "utf8_general_ci"
  end

  create_table "timepoint_names", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "unit", default: "", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "isValidUCUM", default: false
    t.boolean "isValidUCUMTested", default: false
  end

  create_table "tps_arms_rssms", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "timepoint_id"
    t.integer "extractions_extraction_forms_projects_sections_type1_id"
    t.integer "result_statistic_sections_measure_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["extractions_extraction_forms_projects_sections_type1_id"], name: "index_tps_arms_rssms_on_eefpst_id"
    t.index ["result_statistic_sections_measure_id"], name: "index_tps_arms_rssms_on_rssm_id"
    t.index ["timepoint_id"], name: "index_tps_arms_rssms_on_timepoint_id"
  end

  create_table "tps_comparisons_rssms", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "timepoint_id"
    t.integer "comparison_id"
    t.integer "result_statistic_sections_measure_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["comparison_id"], name: "index_tps_comparisons_rssms_on_comparison_id"
    t.index ["result_statistic_sections_measure_id"], name: "index_tps_comparisons_rssms_on_rssm_id"
    t.index ["timepoint_id"], name: "index_tps_comparisons_rssms_on_timepoint_id"
  end

  create_table "training_data_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "category"
    t.integer "count"
    t.bigint "ml_model_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ml_model_id"], name: "index_training_data_infos_on_ml_model_id"
  end

  create_table "type1_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "type1s", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name", "description"], name: "index_type1s_on_name_and_description", length: { description: 255 }
  end

  create_table "user_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "user_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "users", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.integer "user_type_id"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.integer "expires_at"
    t.boolean "expires"
    t.string "refresh_token"
    t.string "api_key"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["user_type_id"], name: "index_users_on_user_type_id"
  end

  create_table "wacs_bacs_rssms", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "wac_id"
    t.integer "bac_id"
    t.integer "result_statistic_sections_measure_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bac_id"], name: "index_wacs_bacs_rssms_on_bac_id"
    t.index ["result_statistic_sections_measure_id"], name: "index_wacs_bacs_rssms_on_result_statistic_sections_measure_id"
    t.index ["wac_id"], name: "index_wacs_bacs_rssms_on_wac_id"
  end

  create_table "word_groups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "color"
    t.bigint "abstract_screening_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "case_sensitive", default: false
  end

  create_table "word_weights", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "abstract_screening_id"
    t.integer "weight", limit: 1, null: false
    t.string "word", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "word_group_id"
    t.index ["abstract_screening_id"], name: "ww_on_as"
    t.index ["user_id", "abstract_screening_id", "word"], name: "u_as_w", unique: true
    t.index ["user_id"], name: "ww_on_u"
    t.index ["word_group_id"], name: "index_word_weights_on_word_group_id"
  end

  add_foreign_key "abstrackr_settings", "profiles"
  add_foreign_key "actions", "action_types"
  add_foreign_key "actions", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "approvals", "users"
  add_foreign_key "citations", "citation_types"
  add_foreign_key "citations_projects", "citations"
  add_foreign_key "citations_projects", "consensus_types"
  add_foreign_key "citations_projects", "projects"
  add_foreign_key "colorings", "color_choices"
  add_foreign_key "comparate_groups", "comparisons"
  add_foreign_key "comparates", "comparable_elements"
  add_foreign_key "comparates", "comparate_groups"
  add_foreign_key "comparisons_arms_rssms", "comparisons"
  add_foreign_key "comparisons_arms_rssms", "extractions_extraction_forms_projects_sections_type1s"
  add_foreign_key "comparisons_arms_rssms", "result_statistic_sections_measures"
  add_foreign_key "comparisons_measures", "comparisons"
  add_foreign_key "comparisons_measures", "measures"
  add_foreign_key "comparisons_result_statistic_sections", "comparisons"
  add_foreign_key "comparisons_result_statistic_sections", "result_statistic_sections"
  add_foreign_key "degrees_profiles", "degrees"
  add_foreign_key "degrees_profiles", "profiles"
  add_foreign_key "dispatches", "users"
  add_foreign_key "eefps_qrcfs", "extractions_extraction_forms_projects_sections"
  add_foreign_key "eefps_qrcfs", "extractions_extraction_forms_projects_sections_type1s"
  add_foreign_key "eefps_qrcfs", "question_row_column_fields"
  add_foreign_key "eefpsqrcf_qrcqrcos", "eefps_qrcfs"
  add_foreign_key "eefpsqrcf_qrcqrcos", "question_row_columns_question_row_column_options"
  add_foreign_key "exported_files", "file_types"
  add_foreign_key "exported_files", "projects"
  add_foreign_key "exported_files", "users"
  add_foreign_key "exported_items", "export_types"
  add_foreign_key "external_service_providers_projects_users", "external_service_providers"
  add_foreign_key "external_service_providers_projects_users", "projects"
  add_foreign_key "external_service_providers_projects_users", "users"
  add_foreign_key "extraction_forms_projects", "extraction_forms"
  add_foreign_key "extraction_forms_projects", "extraction_forms_project_types"
  add_foreign_key "extraction_forms_projects", "projects"
  add_foreign_key "extraction_forms_projects_section_options", "extraction_forms_projects_sections"
  add_foreign_key "extraction_forms_projects_sections", "extraction_forms_projects"
  add_foreign_key "extraction_forms_projects_sections", "extraction_forms_projects_section_types"
  add_foreign_key "extraction_forms_projects_sections", "extraction_forms_projects_sections"
  add_foreign_key "extraction_forms_projects_sections", "sections"
  add_foreign_key "extraction_forms_projects_sections_type1s", "extraction_forms_projects_sections"
  add_foreign_key "extraction_forms_projects_sections_type1s", "type1_types"
  add_foreign_key "extraction_forms_projects_sections_type1s", "type1s"
  add_foreign_key "extraction_forms_projects_sections_type1s_timepoint_names", "extraction_forms_projects_sections_type1s"
  add_foreign_key "extraction_forms_projects_sections_type1s_timepoint_names", "timepoint_names"
  add_foreign_key "extractions", "citations_projects"
  add_foreign_key "extractions", "projects"
  add_foreign_key "extractions", "projects_users_roles"
  add_foreign_key "extractions", "users"
  add_foreign_key "extractions_extraction_forms_projects_sections", "extraction_forms_projects_sections"
  add_foreign_key "extractions_extraction_forms_projects_sections", "extractions"
  add_foreign_key "extractions_extraction_forms_projects_sections", "extractions_extraction_forms_projects_sections"
  add_foreign_key "extractions_extraction_forms_projects_sections_type1_row_columns", "extractions_extraction_forms_projects_sections_type1_rows"
  add_foreign_key "extractions_extraction_forms_projects_sections_type1_row_columns", "timepoint_names"
  add_foreign_key "extractions_extraction_forms_projects_sections_type1_rows", "extractions_extraction_forms_projects_sections_type1s"
  add_foreign_key "extractions_extraction_forms_projects_sections_type1_rows", "population_names"
  add_foreign_key "extractions_extraction_forms_projects_sections_type1s", "extractions_extraction_forms_projects_sections"
  add_foreign_key "extractions_extraction_forms_projects_sections_type1s", "type1_types"
  add_foreign_key "extractions_extraction_forms_projects_sections_type1s", "type1s"
  add_foreign_key "followup_fields", "followup_fields"
  add_foreign_key "funding_sources_sd_meta_data", "funding_sources"
  add_foreign_key "funding_sources_sd_meta_data", "sd_meta_data"
  add_foreign_key "imported_files", "file_types"
  add_foreign_key "imported_files", "sections"
  add_foreign_key "invitations", "roles"
  add_foreign_key "journals", "citations"
  add_foreign_key "key_questions_projects", "key_questions"
  add_foreign_key "key_questions_projects", "projects"
  add_foreign_key "key_questions_projects_questions", "key_questions_projects"
  add_foreign_key "key_questions_projects_questions", "questions"
  add_foreign_key "message_types", "frequencies"
  add_foreign_key "messages", "message_types"
  add_foreign_key "ml_predictions", "citations_projects"
  add_foreign_key "ml_predictions", "ml_models"
  add_foreign_key "model_performances", "ml_models"
  add_foreign_key "notes", "projects_users_roles"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "pending_invitations", "invitations"
  add_foreign_key "pending_invitations", "users"
  add_foreign_key "predictions", "citations_projects"
  add_foreign_key "priorities", "citations_projects"
  add_foreign_key "profiles", "organizations"
  add_foreign_key "profiles", "users"
  add_foreign_key "projects_users", "projects"
  add_foreign_key "projects_users", "users"
  add_foreign_key "projects_users_roles", "projects_users"
  add_foreign_key "projects_users_roles", "roles"
  add_foreign_key "projects_users_roles_teams", "projects_users_roles"
  add_foreign_key "projects_users_roles_teams", "teams"
  add_foreign_key "projects_users_term_groups_colors", "projects_users"
  add_foreign_key "projects_users_term_groups_colors", "term_groups_colors"
  add_foreign_key "projects_users_term_groups_colors_terms", "projects_users_term_groups_colors"
  add_foreign_key "projects_users_term_groups_colors_terms", "terms"
  add_foreign_key "publishings", "users"
  add_foreign_key "quality_dimension_questions", "quality_dimension_sections"
  add_foreign_key "quality_dimension_questions_quality_dimension_options", "quality_dimension_options"
  add_foreign_key "quality_dimension_questions_quality_dimension_options", "quality_dimension_questions"
  add_foreign_key "question_row_column_fields", "question_row_column_fields"
  add_foreign_key "question_row_column_fields", "question_row_columns"
  add_foreign_key "question_row_columns", "question_row_column_types"
  add_foreign_key "question_row_columns", "question_rows"
  add_foreign_key "question_row_columns_question_row_column_options", "question_row_column_options"
  add_foreign_key "question_row_columns_question_row_column_options", "question_row_columns"
  add_foreign_key "question_rows", "questions"
  add_foreign_key "questions", "extraction_forms_projects_sections"
  add_foreign_key "result_statistic_section_types_measures", "measures"
  add_foreign_key "result_statistic_section_types_measures", "result_statistic_section_types"
  add_foreign_key "result_statistic_section_types_measures", "result_statistic_section_types_measures"
  add_foreign_key "result_statistic_section_types_measures", "type1_types"
  add_foreign_key "result_statistic_sections", "extractions_extraction_forms_projects_sections_type1_rows", column: "population_id"
  add_foreign_key "result_statistic_sections", "result_statistic_section_types"
  add_foreign_key "result_statistic_sections_measures", "measures"
  add_foreign_key "result_statistic_sections_measures", "result_statistic_sections"
  add_foreign_key "result_statistic_sections_measures", "result_statistic_sections_measures"
  add_foreign_key "result_statistic_sections_measures_comparisons", "comparisons"
  add_foreign_key "result_statistic_sections_measures_comparisons", "result_statistic_sections"
  add_foreign_key "screening_options", "label_types"
  add_foreign_key "screening_options", "projects"
  add_foreign_key "screening_options", "screening_option_types"
  add_foreign_key "sd_analytic_frameworks", "sd_meta_data"
  add_foreign_key "sd_grey_literature_searches", "sd_meta_data"
  add_foreign_key "sd_journal_article_urls", "sd_meta_data"
  add_foreign_key "sd_key_questions", "key_questions"
  add_foreign_key "sd_key_questions", "sd_key_questions"
  add_foreign_key "sd_key_questions", "sd_meta_data"
  add_foreign_key "sd_key_questions_projects", "key_questions_projects"
  add_foreign_key "sd_key_questions_projects", "sd_key_questions"
  add_foreign_key "sd_key_questions_sd_picods", "sd_key_questions"
  add_foreign_key "sd_key_questions_sd_picods", "sd_picods"
  add_foreign_key "sd_meta_data", "review_types"
  add_foreign_key "sd_other_items", "sd_meta_data"
  add_foreign_key "sd_picods", "data_analysis_levels"
  add_foreign_key "sd_picods", "sd_meta_data"
  add_foreign_key "sd_picods_sd_picods_types", "sd_picods"
  add_foreign_key "sd_picods_sd_picods_types", "sd_picods_types"
  add_foreign_key "sd_prisma_flows", "sd_meta_data"
  add_foreign_key "sd_project_leads", "sd_meta_data"
  add_foreign_key "sd_project_leads", "users"
  add_foreign_key "sd_search_strategies", "sd_meta_data"
  add_foreign_key "sd_search_strategies", "sd_search_databases"
  add_foreign_key "sd_summary_of_evidences", "sd_key_questions"
  add_foreign_key "sd_summary_of_evidences", "sd_meta_data"
  add_foreign_key "statusings", "statuses"
  add_foreign_key "suggestions", "users"
  add_foreign_key "taggings", "projects_users_roles"
  add_foreign_key "taggings", "tags"
  add_foreign_key "teams", "projects"
  add_foreign_key "teams", "team_types"
  add_foreign_key "term_groups_colors", "colors"
  add_foreign_key "term_groups_colors", "term_groups"
  add_foreign_key "tps_arms_rssms", "extractions_extraction_forms_projects_sections_type1s"
  add_foreign_key "tps_arms_rssms", "result_statistic_sections_measures"
  add_foreign_key "tps_comparisons_rssms", "comparisons"
  add_foreign_key "tps_comparisons_rssms", "result_statistic_sections_measures"
  add_foreign_key "training_data_infos", "ml_models"
  add_foreign_key "users", "user_types"
  add_foreign_key "wacs_bacs_rssms", "result_statistic_sections_measures"
  add_foreign_key "word_weights", "word_groups"
end
