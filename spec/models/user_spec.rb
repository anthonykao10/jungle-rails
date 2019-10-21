require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "is not saved when 'password' and 'password_confirmation' don't match" do
      user = User.new(name: 'test1', email: 'test1@gmail.com', password: 'password', password_confirmation: 'nomatch')
      expect(user.save).to be false
    end

    it "is saved if 'password' and 'password_confirmation' match" do
      user = User.create(name: 'test2', email: 'test2@gmail.com', password: 'matching', password_confirmation: 'matching')
      expect(user).to be_valid
    end

    it "doesn't save if email is already taken" do
      user1 = User.create(email: 'taken@gmail.com', name: 'taken1', password: 'password', password_confirmation: 'password')
      user2 = User.create(email: 'TAKEN@gmail.com', name: 'taken2', password: 'password', password_confirmation: 'password')
      expect(user2).to_not be_valid
    end

    it "is not valid without email" do
      user = User.create(email: nil, name: 'noEmail', password: 'password', password_confirmation: 'password')
      expect(user).to_not be_valid
    end

    it "is not valid without name" do
      user = User.create(email: 'noname@gmail.com', name: nil, password: 'password', password_confirmation: 'password')
      expect(user).to_not be_valid
    end

    it "is not valid when password is shorter than min length" do
      user = User.create(email: 'test3@gmail.com', name: 'test3', password: 'p', password_confirmation: 'p')
      expect(user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "returns nil with invalid credentials" do
      user = User.authenticate_with_credentials('invalid', 'invalid')
      expect(user).to be_nil
    end

    it "returns correct user object if credentials are valid" do
      createdUser = User.create(email: 'credentialTest@gmail.com', name: 'credentialTest', password: 'password', password_confirmation: 'password')
      expect(createdUser).to be_valid
      authUser = User.authenticate_with_credentials('credentialTest@gmail.com', 'password')
      expect(authUser).to have_attributes(:name => "credentialTest")
    end
  end

end
