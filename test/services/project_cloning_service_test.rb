require 'test_helper'

class ProjectCloningServiceTest < ActiveSupport::TestCase
  setup do
    @original_project = projects(:copy_project_original)
    @user1 = users(:one)
    @user2 = users(:two)
    @leaders = [@user1, @user2]
  end

  test 'cloning project should create the correct number of new db records' do
    # Count starting point objects.
    p_cnt = Project.all.size
    pu_cnt = ProjectsUser.all.size
    kqp_cnt = KeyQuestionsProject.all.size
    efp_cnt = ExtractionFormsProject.all.size
    cp_cnt = CitationsProject.all.size
    ex_cnt = Extraction.all.size
    pt_cnt = ProjectsTag.all.size
    pr_cnt = ProjectsReason.all.size
    mdp_cnt = MeshDescriptorsProject.all.size

    # Just a sanity check to ensure we start with known counts of the :through associations.
    assert_equal(2, @original_project.key_questions.size)
    assert_equal(4, @original_project.citations.size)
    assert_equal(2, @original_project.tags.size)
    assert_equal(3, @original_project.reasons.size)
    assert_equal(3, @original_project.mesh_descriptors.size)
    assert_equal(5, @original_project.extractions.size)
    assert_equal(4, @original_project.extraction_forms_projects.size)

    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: false,
      include_labels: false
    }
    ProjectCloningService.clone_project(@original_project, @leaders, opts)

    assert_equal(p_cnt + 1, Project.all.size)
    assert_equal(cp_cnt + CitationsProject.where(project: @original_project).size, CitationsProject.all.size)
    assert_equal(pu_cnt + 2, ProjectsUser.all.size)
    assert_equal(kqp_cnt + KeyQuestionsProject.where(project: @original_project).size, KeyQuestionsProject.all.size)
    assert_equal(pt_cnt + ProjectsTag.where(project: @original_project).size, ProjectsTag.all.size)
    assert_equal(pr_cnt + ProjectsReason.where(project: @original_project).size, ProjectsReason.all.size)
    assert_equal(mdp_cnt + MeshDescriptorsProject.where(project: @original_project).size, MeshDescriptorsProject.all.size)
    assert_equal(ex_cnt, Extraction.all.size)
    assert_equal(efp_cnt + ExtractionFormsProject.where(project: @original_project).size, ExtractionFormsProject.all.size)
  end

  test 'cloning project with extractions should create new extraction records' do
    ex_cnt = Extraction.all.size

    # Just a sanity check to ensure we start with known counts of the :through associations.
    assert_equal(5, @original_project.extractions.size)

    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    ProjectCloningService.clone_project(@original_project, @leaders, opts)

    assert_equal(ex_cnt + Extraction.where(project: @original_project).size, Extraction.all.size)
  end

  test 'cloning project should copy ExtractionFormsProjectsSection' do
    efps_cnt = ExtractionFormsProjectsSection.all.size

    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: false,
      include_labels: false
    }
    cloned_prj = ProjectCloningService.clone_project(@original_project, @leaders, opts)
    cloned_std_efp = cloned_prj
                       .extraction_forms_projects
                       .joins(:extraction_form)
                       .find_by(extraction_forms: { name: 'Standard' })
    cloned_std_efp_efps = cloned_std_efp.extraction_forms_projects_sections
    original_std_efp = @original_project
                         .extraction_forms_projects
                         .joins(:extraction_form)
                         .find_by(extraction_forms: { name: 'Standard' })
    original_std_efp_efps = original_std_efp.extraction_forms_projects_sections

    assert_equal(
      original_std_efp_efps.size,
      cloned_std_efp_efps.size
    )
    assert_equal(
      efps_cnt + original_std_efp_efps.size,
      ExtractionFormsProjectsSection.all.size
    )

    original_std_efp_efps.each do |orig_efps|
      name = orig_efps.section.name

      assert_equal(
        cloned_std_efp_efps
        .joins(:section)
        .find_by(sections: { name: })
        .extraction_forms_projects_section_option.by_type1,
        orig_efps.extraction_forms_projects_section_option.by_type1
      )
    end
  end

  test 'type1 suggestions should be copied' do
    original_efpst1_cnt = ExtractionFormsProjectsSectionsType1.all.size
    amoeba_efpst1_cnt = ExtractionFormsProjectsSectionsType1.where(
      extraction_forms_projects_section:
        @original_project
        .extraction_forms_projects
        .joins(:extraction_form)
        .where(extraction_form: { name: ExtractionForm::STANDARD })
        .first&.extraction_forms_projects_sections
    ).size

    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: false,
      include_labels: false
    }
    ProjectCloningService.clone_project(@original_project, @leaders, opts)

    assert_equal(original_efpst1_cnt + amoeba_efpst1_cnt, ExtractionFormsProjectsSectionsType1.all.size)
    refute_equal(original_efpst1_cnt, ExtractionFormsProjectsSectionsType1.all.size)
  end

  test 'destroying cloned project should delete the correct number of database records' do
    # Count starting point objects.
    p_cnt = Project.all.size
    pu_cnt = ProjectsUser.all.size
    kqp_cnt = KeyQuestionsProject.all.size
    efp_cnt = ExtractionFormsProject.all.size
    cp_cnt = CitationsProject.all.size
    ex_cnt = Extraction.all.size
    pt_cnt = ProjectsTag.all.size
    pr_cnt = ProjectsReason.all.size
    mdp_cnt = MeshDescriptorsProject.all.size

    # Just a sanity check to ensure we start with known counts of the :through associations.
    assert_equal(2, @original_project.key_questions.size)
    assert_equal(4, @original_project.citations.size)
    assert_equal(2, @original_project.tags.size)
    assert_equal(3, @original_project.reasons.size)
    assert_equal(3, @original_project.mesh_descriptors.size)
    assert_equal(5, @original_project.extractions.size)
    assert_equal(4, @original_project.extraction_forms_projects.size)

    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: false,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)
    copied_project.destroy

    assert_equal(p_cnt, Project.all.size)
    assert_equal(cp_cnt, CitationsProject.all.size)
    assert_equal(pu_cnt, ProjectsUser.all.size)
    assert_equal(kqp_cnt, KeyQuestionsProject.all.size)
    assert_equal(pt_cnt, ProjectsTag.all.size)
    assert_equal(pr_cnt, ProjectsReason.all.size)
    assert_equal(mdp_cnt, MeshDescriptorsProject.all.size)
    assert_equal(ex_cnt, Extraction.all.size)
    assert_equal(efp_cnt, ExtractionFormsProject.all.size)
  end

  test 'copied citations_projects should belong to copied project' do
    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: false,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)
    assert_equal(copied_project.citations_projects.size, 4)
    assert copied_project.citations_projects.include?(CitationsProject.unscoped.last), 'Last added CitationsProject should belong to project copy'
  end

  test "copied citations_projects should have screening_status 'asu'" do
    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: false,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)
    copied_project.reload
    assert copied_project.citations_projects.all? { |cp| cp.screening_status.eql?('asu') },
      "All added CitationsProject should have 'asu' screening_status"
  end

  test "copied citations_projects should have screening_status 'eip' if extraction exists" do
    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)
    copied_project.reload

    assert copied_project.citations_projects.all? { |cp| cp.screening_status.eql?('eip') },
      "All added CitationsProject should have 'eip' screening_status in the presence of extraction"
  end

  test "count of copied extractions should be the same as @original_project" do
    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)

    assert_equal(copied_project.extractions.size, @original_project.extractions.size)
  end

  test "copied extractions should have same status as source" do
    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)

    assert copied_project.extractions.any? { |ex| ex.status.eql?(Status.COMPLETED) }
    assert_equal(copied_project.extractions.map(&:citation), @original_project.extractions.map(&:citation))
    assert_equal(copied_project.extractions.map(&:status), @original_project.extractions.map(&:status))
  end

  test "copied eefps should have correct link to type1" do
    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)
    copied_project.extractions.each do |extraction|
      extraction.extractions_extraction_forms_projects_sections.each do |eefps|
        assert_equal(eefps.link_to_type1.project, copied_project) if eefps.link_to_type1.present?
      end
    end
  end

  test "copied eefps should have efps that belongs to copied project" do
    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)
    copied_project.extractions.each do |ex|
      ex.extractions_extraction_forms_projects_sections.each do |eefps|
        assert_equal(eefps.extraction_forms_projects_section.project, copied_project)
      end
    end
  end

  test "ensure correct parent associations for eefpsqrcf" do
    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)
    copied_project.extractions.each do |ex|
      ex.extractions_extraction_forms_projects_sections.each do |eefps|
        eefps.extractions_extraction_forms_projects_sections_question_row_column_fields.each do |eefpsqrcf|
          assert_equal(eefpsqrcf.extractions_extraction_forms_projects_sections_type1.extraction.project, copied_project)
          assert_equal(eefpsqrcf.extractions_extraction_forms_projects_section.extraction.project, copied_project)
          assert_equal(eefpsqrcf.question_row_column_field.question.project, copied_project)
        end
      end
    end

    # Check record counts.
    copied_project.extractions.each do |ex|
      original_ex = @original_project
                      .extractions
                      .select {
                        |orig_ex| orig_ex.citations_project.citation.eql?(ex.citations_project.citation) &&
                                  orig_ex.extractions_extraction_forms_projects_sections.size.eql?(ex.extractions_extraction_forms_projects_sections.size) }[0]
      ex.extractions_extraction_forms_projects_sections.each do |eefps|
        original_eefps = original_ex
                           .extractions_extraction_forms_projects_sections
                           .select { |orig_eefps| orig_eefps.extraction_forms_projects_section.section.eql?(eefps.extraction_forms_projects_section.section) }[0]
        assert_equal(eefps.extractions_extraction_forms_projects_sections_question_row_column_fields.size,
                     original_eefps.extractions_extraction_forms_projects_sections_question_row_column_fields.size)
      end
    end
  end

  test "ensure correct eefpsff counts" do
    eefpsff_before_cnt = ExtractionsExtractionFormsProjectsSectionsFollowupField.all.size

    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)

    eefpsff_after_cnt = ExtractionsExtractionFormsProjectsSectionsFollowupField.all.size

    assert_equal(eefpsff_after_cnt, eefpsff_before_cnt * 2)
  end

  test "ensure no disassociation of questions from the originals" do
    orig_questions_cnt_before = @original_project
      .extraction_forms_projects
      .select { |efp| efp.extraction_forms_project_type.eql?(ExtractionFormsProjectType.find_by(name: 'Standard')) }
      .first
      .extraction_forms_projects_sections
      .select { |efps| efps.extraction_forms_projects_section_type.eql?(ExtractionFormsProjectsSectionType.find_by(name: 'Type 2')) }
      .map { |efps| efps.questions.size }
      .sum

    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)

    orig_questions_cnt_after = @original_project
      .extraction_forms_projects
      .select { |efp| efp.extraction_forms_project_type.eql?(ExtractionFormsProjectType.find_by(name: 'Standard')) }
      .first
      .extraction_forms_projects_sections
      .select { |efps| efps.extraction_forms_projects_section_type.eql?(ExtractionFormsProjectsSectionType.find_by(name: 'Type 2')) }
      .map { |efps| efps.questions.size }
      .sum

    copied_questions_cnt_after = @original_project
      .extraction_forms_projects
      .select { |efp| efp.extraction_forms_project_type.eql?(ExtractionFormsProjectType.find_by(name: 'Standard')) }
      .first
      .extraction_forms_projects_sections
      .select { |efps| efps.extraction_forms_projects_section_type.eql?(ExtractionFormsProjectsSectionType.find_by(name: 'Type 2')) }
      .map { |efps| efps.questions.size }
      .sum

    assert_equal(orig_questions_cnt_after, orig_questions_cnt_before)
    assert_equal(copied_questions_cnt_after, orig_questions_cnt_before)
  end

  test "ensure proper ExtractionsKeyQuestionsProjectsSelection associations" do
    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)
    copied_project.extractions.map(&:extractions_key_questions_projects_selections).flatten.each do |ekqps|
      assert_equal(ekqps.key_questions_project.project, copied_project)
    end
  end

  test "ensure originals didn't lose children" do
    section_cnt_of_standard_efp = Hash.new
    question_cnt_of_efps = Hash.new

    standard_efps = @original_project
                      .extraction_forms_projects
                      .select { |efp| efp.extraction_forms_project_type.eql?(ExtractionFormsProjectType.find_by(name: "Standard")) }
    standard_efps.each do |efp|
      section_cnt_of_standard_efp[efp.id] = efp.extraction_forms_projects_sections.size
      efp.extraction_forms_projects_sections.each do |efps|
        question_cnt_of_efps[efps.id] = efps.questions.size
      end
    end

    opts = {
      include_citations: true,
      include_extraction_forms: true,
      include_extractions: true,
      include_labels: false
    }
    copied_project = ProjectCloningService.clone_project(@original_project, @leaders, opts)

    standard_efps = @original_project
                      .extraction_forms_projects
                      .select { |efp| efp.extraction_forms_project_type.eql?(ExtractionFormsProjectType.find_by(name: "Standard")) }
    standard_efps.each do |efp|
      assert_equal(efp.extraction_forms_projects_sections.size, section_cnt_of_standard_efp[efp.id])
      puts "\r\n"
      efp.extraction_forms_projects_sections.each do |efps|
        puts "Section name: #{ efps.section.name }. Number of questions: #{ efps.questions.size }"
        assert_equal(efps.questions.size, question_cnt_of_efps[efps.id])
      end
    end

    copied_standard_efps = copied_project
                             .extraction_forms_projects
                             .select { |efp| efp.extraction_forms_project_type.eql?(ExtractionFormsProjectType.find_by(name: "Standard")) }
    copied_standard_efps.each do |efp|
      puts "\r\n"
      efp.extraction_forms_projects_sections.each do |efps|
        puts "Section name: #{ efps.section.name }. Number of questions: #{ efps.questions.size }"
      end
    end

    # List of models where parent corrections were made:
    # Extraction
    # ExtractionFormsProjectsSection
    # ExtractionsKeyQuestionsProjectsSelection
  end
end
