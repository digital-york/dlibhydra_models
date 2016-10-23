require 'spec_helper'
require 'active_fedora'
require 'hydra/works'
require 'action_view'

describe Dlibhydra::Dataset do
  let(:dataset) { FactoryGirl.build(:dataset) }
  let(:package) { FactoryGirl.build_stubbed(:package) }
  let(:generic_work) { FactoryGirl.build(:generic_work) }
  let(:readme_file) { FactoryGirl.build_stubbed(:readme_file) }

  it 'is a dataset' do
    expect(dataset.dataset?).to be_truthy
  end

  # Concerns
  # it_behaves_like "add_datacite_mandatory"
  it_behaves_like 'pure'
  it_behaves_like 'for_indexing'
  it_behaves_like 'simple_versions'
  it_behaves_like 'doi'
  it_behaves_like 'dc_access_rights'
  it_behaves_like 'dc_publisher'
  it_behaves_like 'dc_available'
  it_behaves_like 'dc_creator'

  describe '#metadata' do
    specify { dataset.type.should include('http://www.w3.org/ns/dcat#Dataset') }
    specify { dataset.embargo_release_date.should eq(2016 - 12 - 12) }
    specify { dataset.retention_policy.should eq('10 years from last access') }
    specify { dataset.restriction_note.should eq(['restriction note']) }
  end

  describe '#predicates' do
    specify { dataset.resource.dump(:ttl).should include('http://dlib.york.ac.uk/ontologies/generic#embargoReleaseDate') }
    specify { dataset.resource.dump(:ttl).should include('http://dlib.york.ac.uk/ontologies/generic#retentionPolicy') }
    specify { dataset.resource.dump(:ttl).should include('http://dlib.york.ac.uk/ontologies/generic#restrictionNote') }
  end

  describe '#related objects' do
    before(:each) do
      dataset.members << package
    end
    it 'has a member' do
      expect(dataset.members.size).to eq(1)
    end
    it 'has an aip' do
      expect(dataset.aips.size).to eq(1)
    end
    it 'has a dip' do
      expect(dataset.dips.size).to eq(1)
    end
  end

  describe '#custom indexer' do
    it 'adds access_rights_tesi to the solr index ' do
      expect(dataset.to_solr).to include('access_rights_tesi')
    end
  end
end
