module Dlibhydra
  class Dataset < ActiveFedora::Base
    include Hydra::Works::WorkBehavior,
            Dlibhydra::AddDataciteMandatory,
            Dlibhydra::AssignId,
            Dlibhydra::ForIndexing,
            Dlibhydra::DcAccessRights,
            Dlibhydra::Pure,
            Dlibhydra::Doi,
            Dlibhydra::SimpleVersions,
            Dlibhydra::GenericWorkflow

    filters_association :members, as: :readme, condition: :readme?
    filters_association :members, as: :aips, condition: :aip?
    filters_association :members, as: :dips, condition: :dip?
    filters_association :members, as: :packages, condition: :package?

    type << ::RDF::Vocab::DCAT.Dataset

    # look at how CC handles this
    # where does this come from? is it in pure? NOT IN PUREE check ws
    property :embargo_release_date, predicate: Dlibhydra::Vocab::Generic.embargoReleaseDate, multiple: false do |index|
      index.as :stored_searchable
    end
    property :retention_policy, predicate: Dlibhydra::Vocab::Generic.retentionPolicy, multiple: false do |index|
      index.as :stored_searchable
    end
    property :restriction_note, predicate: Dlibhydra::Vocab::Generic.restrictionNote, multiple: true do |index|
      index.as :stored_searchable
    end

    def dataset?
      true
    end

    # Force the type of certain indexed fields in solr
    # (inspired by http://projecthydra.github.io/training/deeper_into_hydra/#slide-63,
    #   http://projecthydra.github.io/training/deeper_into_hydra/#slide-64 and discussed at
    #   https://groups.google.com/forum/#!topic/hydra-tech/rRsBwdvh5dE)
    # This is to overcome limitations with solrizer and "index.as :stored_sortable" always defaulting 
    # to string rather than text type (solr sorting on string fields is case-sensitive, on text fields 
    # it's case-insensitive)
    class TextIndexer < ActiveFedora::IndexingService
      def generate_solr_document
        super.tap do |solr_doc|
          # add a stored text index for the 'access_rights' property in solr 
          # so that case-insensitive sorting can be done on it
          solr_doc['access_rights_tesi'] = object.access_rights
        end
      end
    end

    def self.indexer
      TextIndexer
    end
  end
end
