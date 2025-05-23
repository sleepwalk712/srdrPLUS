# == Schema Information
#
# Table name: result_statistic_sections
#
#  id                               :integer          not null, primary key
#  result_statistic_section_type_id :integer
#  population_id                    :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#

class ResultStatisticSection < ApplicationRecord
  attr_accessor :comparison_type, :is_amoeba_copy

  scope :standard_type_rsss, -> { where(result_statistic_section_type_id: [1, 2, 3, 4]) }
  scope :diagnostic_test_type_rsss, -> { where(result_statistic_section_type_id: [5, 6, 7, 8]) }

  amoeba do
  end

  after_create :create_default_measures

  belongs_to :result_statistic_section_type,
             inverse_of: :result_statistic_sections
  belongs_to :population, class_name: 'ExtractionsExtractionFormsProjectsSectionsType1Row',
                          inverse_of: :result_statistic_sections

  has_many :result_statistic_sections_measures,
           lambda {
             joins(:measure).order('measures.id ASC')
           }, dependent: :destroy, inverse_of: :result_statistic_section
  has_many :measures, through: :result_statistic_sections_measures, dependent: :destroy

  has_many :comparisons_result_statistic_sections, dependent: :destroy, inverse_of: :result_statistic_section
  has_many :comparisons,          through: :comparisons_result_statistic_sections, dependent: :destroy
  has_many :comparate_groups,     through: :comparisons,                           dependent: :destroy
  has_many :comparates,           through: :comparate_groups,                      dependent: :destroy
  has_many :comparable_elements,  through: :comparates,                            dependent: :destroy
  has_many :comparables,          through: :comparable_elements,                   dependent: :destroy,
                                  source_type: 'ComparableElement'
  has_many :comparisons_measures, through: :comparables,                           dependent: :destroy,
                                  source: :comparates

  accepts_nested_attributes_for :comparisons_result_statistic_sections, allow_destroy: true
  accepts_nested_attributes_for :comparisons,                           allow_destroy: false
  accepts_nested_attributes_for :comparate_groups,                      allow_destroy: false
  accepts_nested_attributes_for :comparates,                            allow_destroy: false
  accepts_nested_attributes_for :comparable_elements,                   allow_destroy: false
  # accepts_nested_attributes_for :comparables,                           allow_destroy: false  #!!! Do we need this?
  accepts_nested_attributes_for :comparisons_measures,                  allow_destroy: false
  accepts_nested_attributes_for :result_statistic_sections_measures
  accepts_nested_attributes_for :measures

  delegate :extraction,                                    to: :population
  delegate :extractions_extraction_forms_projects_section, to: :population
  delegate :project, to: :extraction

  def measures_attributes=(hash)
    # Not calling super(hash)/super because we don't have a use case for updating measures through measures_attributes
    hash.values.each do |value|
      measure = Measure.find_or_create_by(name: value[:name])
      measures << measure if measures.exclude?(measure)
    end
  end

  def timepoints
    population.extractions_extraction_forms_projects_sections_type1_row_columns
  end

  def related_measures
    Measure
      .joins(result_statistic_sections: { population: { extractions_extraction_forms_projects_sections_type1: { extractions_extraction_forms_projects_section: :extraction } } })
      .where(extractions_extraction_forms_projects_sections: { extraction_id: extraction.id })
      .where(result_statistic_sections: { result_statistic_section_type_id: })
      .where(result_statistic_sections: {
               population: {
                 extractions_extraction_forms_projects_sections_type1s: {
                   type1_type_id: population.extractions_extraction_forms_projects_sections_type1.type1_type
                 }
               }
             }).order(id: :asc)
  end

  def related_result_statistic_sections
    self.class
        .joins(population: { extractions_extraction_forms_projects_sections_type1: { extractions_extraction_forms_projects_section: :extraction } })
        .where(population: { extractions_extraction_forms_projects_sections_type1: { extractions_extraction_forms_projects_sections: { extraction_id: extraction.id } } })
        .where(result_statistic_section_type_id:)
        .where(population: {
                 extractions_extraction_forms_projects_sections_type1s: {
                   type1_type_id: population.extractions_extraction_forms_projects_sections_type1.type1_type
                 }
               }).order(id: :asc)
  end

  # Making the assumption that the result section is always last.
  def eefps_result
    population
      .extractions_extraction_forms_projects_sections_type1
      .extractions_extraction_forms_projects_section
      .extraction_forms_projects_section
      .extraction_forms_project
      .extraction_forms_projects_sections.last
  end

  private

  def create_default_measures
    # Measure.result_statistic_section_type_defaults(self.result_statistic_section_type.id).each do |m|
    #  self.result_statistic_sections_measures.create(measure: m)
    #  #!!!: This might work now. Previously ResultStatisticSection was child of ExtractionsExtractionFormsProjectsSectionsType1RowColumn
    #  #     instead of ExtractionsExtractionFormsProjectsSectionsType1Row.
    #  #measures << m
    # end

    ResultStatisticSectionTypesMeasure.where(
      result_statistic_section_type:,
      type1_type: population.extractions_extraction_forms_projects_sections_type1.type1_type,
      default: true
    ).each do |rsstm|
      result_statistic_sections_measures.create(measure: rsstm.measure)
    end
  end
end
