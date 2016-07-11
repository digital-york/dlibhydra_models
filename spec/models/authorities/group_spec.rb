require 'spec_helper'
require 'active_fedora'
require 'hydra/works'
require 'action_view'

describe Dlibhydra::Group do

  let(:group) { FactoryGirl.build(:group) }
  let(:scheme) { FactoryGirl.build(:concept_scheme)  }

  it_behaves_like "borthwick_note"
  it_behaves_like "foaf_name"
  it_behaves_like "generic_authority_terms"
  it_behaves_like "generic_qualifier"
  it_behaves_like "hub_dates"
  it_behaves_like "mads_related_authority"
  it_behaves_like "same_as"
  it_behaves_like "skos_labels"


  it 'is a group' do
    expect(group.group?).to be_truthy
  end

  # test metadata properties
  describe 'metadata' do
    specify { group.type.should include('https://schema.org/Organization') }
    specify { group.type.should include('http://vocab.getty.edu/ontology#GroupConcept') }
    specify { group.type.should include('http://purl.org/vra/Organization') }
    specify { group.group_type.should eq(['group type']) }
  end

  before {
    group.concept_scheme = scheme
  }
  # test related objects
  describe 'related objects' do
    it 'is related to the parent scheme' do
      expect(group.concept_scheme).to be_a(Dlibhydra::ConceptScheme)
    end

  end

  # test predicates sent to fedora
  describe 'predicates' do
    specify { group.resource.dump(:ttl).should include('http://dlib.york.ac.uk/ontologies/generic#groupType') }
  end

end
