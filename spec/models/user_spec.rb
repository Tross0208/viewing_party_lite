require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:party_users)}
    it { should have_many(:parties).through(:party_users)}
  end

  describe 'validations' do
    it {should validate_presence_of(:username)}
    it {should validate_uniqueness_of(:username)}
    it {should validate_presence_of(:password)}
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    subject { User.new(name: "Sherman")}
    it { should validate_uniqueness_of(:email) }



  end

end
