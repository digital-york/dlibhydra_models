module Dlibhydra
  module DcIdentifier
    extend ActiveSupport::Concern

    included do
      property :identifier, predicate: ::RDF::Vocab::DC.identifier, multiple: false do |index|
        index.as :stored_searchable, :sortable
      end
    end
  end
end
