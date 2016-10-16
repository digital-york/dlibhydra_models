module Dlibhydra
  # main file
  module MainFile
    extend ActiveSupport::Concern

    included do
      # Use for the the link to the main file,
      # ie. the deposited thesis PDF and not any associated files
      # Although multiple links *could* be added, add only one.
      has_and_belongs_to_many :mainFile,
                              class_name: 'Dlibhydra::FileSet', 
                              predicate: Dlibhydra::Vocab::Generic.hasMainFile
      # An alternative approach is a dedicated FileSet.
      # Currently Curation Concerns only allow a single FileSet.
      # filters_association :members, as: :main, condition: :main?
      
      # Ensure the main flle FileSet is added to the members
      before_save :add_member
    end
    
    # Add the FileSet to the members if it has not been added.
    def add_member
      unless self.mainFile
        unless self.members and self.members.include? self.mainFile.first
          self.members << self.mainFile.first
        end
      end
    end
  end
end