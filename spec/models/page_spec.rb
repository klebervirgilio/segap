require 'spec_helper'

describe Page do
  let!(:page) { FactoryGirl.create(:valid_page, title: 'one two three', content: 'one two three') }

  it { should allow_mass_assignment_of(:title)}
  it { should allow_mass_assignment_of(:content)}
  it { should allow_mass_assignment_of(:published_on)}
  it { should validate_presence_of(:title)}
  it { should validate_uniqueness_of(:title)}
  it { should validate_presence_of(:content)}
  it { should have_db_index(:title).unique(true) }

  describe "#total_for_words" do
    it "should returns the total of words" do
      page.total_words.should eq(6)
    end
  end
end