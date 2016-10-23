module Dlibhydra
  class ConceptScheme < ActiveFedora::Base
    include Dlibhydra::AddLabels,
            Dlibhydra::DcDescription,
            Dlibhydra::AssignId
            # Hydra::Works::WorkBehavior - not pcdm objects or hydra works

    has_many :concepts, class_name: 'Dlibhydra::Concept' #, :dependent => :destroy
    has_many :persons #, :dependent => :destroy
    has_many :places #, :dependent => :destroy
    has_many :groups #, :dependent => :destroy

    # Used for nested schemes. Will be added automatically.
    has_and_belongs_to_many :has_top_concept,
                            class_name: 'Dlibhydra::Concept',
                            predicate: ::RDF::Vocab::SKOS.hasTopConcept,
                            inverse_of: :top_concept_of
    
    type [::RDF::URI.new('http://www.w3.org/2004/02/skos/core#ConceptScheme')]

    def concept_scheme?
      true
    end
  end
end
