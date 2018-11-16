# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  password_digest :string           not null
#  email           :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.create(:user) }
  
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:session_token) }
  end
  
  describe "User::find_by_credentials" do
    it "should return user if given correct credentials" do
      expect(User.find_by_credentials(user.email, user.password)).to eq(user)
    end
    
    it "should return nil if given incorrect credentials" do
      expect(User.find_by_credentials(user.email, "123675")).to eq(nil)
    end
  end

end
