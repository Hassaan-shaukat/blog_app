require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  it { should belong_to(:user) }
  it { should have_many(:likes).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }

  it 'is valid with valid attributes' do
    expect(post).to be_valid
  end

  %i[title content].each do |attribute|
    it "is not valid without #{attribute}" do
      post.send("#{attribute}=", nil)
      expect(post).not_to be_valid
      expect(post.errors[attribute]).to include("can't be blank")
    end
  end
end