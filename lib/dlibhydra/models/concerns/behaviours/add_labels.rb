module Dlibhydra
  module AddLabels
    extend ActiveSupport::Concern
    include Dlibhydra::SkosLabels,
            Dlibhydra::RdfsLabel,
            Dlibhydra::DcTitle

    included do
      before_save :map_labels
    end

    def map_labels
      if self.preflabel.class == String
        if self.title.nil? # if there's a preflabel, keep it
          self.title = [self.preflabel]
        else
          self.title << self.preflabel
        end
      elsif self.preflabel.nil? and self.title[0].class == String
        self.preflabel = self.title[0]
      # if both preflabel and title are nil, validator will throw an error
      end
      self.rdfs_label = self.preflabel
    end
  end
end
