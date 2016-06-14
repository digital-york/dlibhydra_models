module Dlibhydra
  class Dip < ActiveFedora::Base
    include Hydra::Works::WorkBehavior,
            Dlibhydra::SkosLabels,
            Dlibhydra::AddRdfsLabel,
            Dlibhydra::AddDcTitle,
            Dlibhydra::ValidateLabel,
            Dlibhydra::AssignId

    has_and_belongs_to_many :has_aip, class_name: 'Dlibhydra::Aip', predicate: ::RDF::SKOS.narrower, inverse_of: :has_dip

    type << Dlibhydra::Vocab::OaisArchivematica.DisseminationInformtionPackage

    # new term
    property :data_status, predicate: Dlibhydra::Vocab::OaisArchivematica.dataStatus, multiple: false do |index|
      index.as :stored_searchable
    end

    property :dip_uuid, predicate: Dlibhydra::Vocab::OaisArchivematica.dipUuid, multiple: false do |index|
      index.as :stored_searchable
    end

    # new term
    # from Archivematica
    property :dip_location, predicate: Dlibhydra::Vocab::OaisArchivematica.dipLocation, multiple: false do |index|
      index.as :stored_searchable
    end

    property :first_requestor, predicate: ::RDF::URI.new('http://example.com/firstRequestor'), multiple: false do |index|
      index.as :stored_searchable
    end

    def dip?
      true
    end
    def aip?
      false
    end
  end
end