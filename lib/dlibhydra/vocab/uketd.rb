require 'rdf'
module Dlibhydra
  module Vocab
    class Uketd < RDF::Vocabulary('http://dlib.york.ac.uk/ontologies/uketd#')

        # TODO publish whole thing
        # Property definitions
        property :advisor,
                 comment: %(TODO.).freeze,
                 label: 'Advisory'.freeze,
                 'rdfs:isDefinedBy' => %(http://naca.central.cranfield.ac.uk/ethos-oai/terms/).freeze,
                 type: 'rdf:Property'.freeze
        property :department,
                 comment: %(TODO.).freeze,
                 label: 'Department'.freeze,
                 'rdfs:isDefinedBy' => %(http://naca.central.cranfield.ac.uk/ethos-oai/terms/).freeze,
                 type: 'rdf:Property'.freeze
        property :qualification_level,
                 comment: %(TODO.).freeze,
                 label: 'Qualification Level'.freeze,
                 'rdfs:isDefinedBy' => %(http://naca.central.cranfield.ac.uk/ethos-oai/terms/).freeze,
                 type: 'rdf:Property'.freeze

        # Extra definitions
        term :"",
             comment: %(TODO).freeze,
             'dc:modified' => %(TODO).freeze, # TODO date
             'dc:publisher' => %(http://dlib.york.ac.uk/).freeze,
             'dc:title' => %(TODO).freeze,
             label: 'Generic'.freeze,
             'owl:versionInfo' => %(TODO).freeze # TODO version
    end
  end
end