require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    context "User fields" do
      it "must have passwords" do
        user = User.new(first_name: "Bilbo", last_name: "Baggins", email: "Bilbo@baggins", password: nil, password_confirmation: nil)
        user.save()
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwords must match" do
        user = User.new(first_name: "Bilbo", last_name: "Baggins", email: "Bilbo@baggins", password: '12345', password_confirmation: '12345')
        user.save()
        expect(user.password).to eq(user.password_confirmation)
      end

      it "must have a unique email" do
        user = User.new(first_name: "Bilbo", last_name: "Baggins", email: "Bilbo@baggins.com", password: '12345', password_confirmation: '12345')
        user.save()
        
        user2 = User.new(first_name: "Bilbo", last_name: "Baggins", email: "Bilbo@baggins.com", password: '12345', password_confirmation: '12345')
        expect { user2.save }.to raise_error(ActiveRecord::RecordNotUnique)
      end

      it "must have an email, first_name, and last_name " do
        user = User.new(first_name: nil, last_name: nil, email: nil, password: '12345', password_confirmation: '12345')
        user.save()
      end

      it "passwords must have a min length of 5" do

        user = User.new(first_name: "Bilbo", last_name: "Baggins", email: "Bilbo@baggins.com", password: "1234", password_confirmation: "1234")
        
        user.save()
        expect(user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
        end
    end
  end

  describe '.authenticate_with_credientials' do
    it "should return a new user" do
      user = User.new(first_name: "Jimmy", last_name: "Nuetron", email: "jimmy@Nuet.com", password: "12345", password_confirmation: "12345")    
      
      user.save()

      authed = User.authenticate_with_credientials("Jimmy@Nuet.com", "12345")
  
      expect(authed).to be_a User
    end

    it "should authenticate a user if they add trailing whitespace" do
      user = User.new(first_name: "Jimmy", last_name: "Nuetron", email: "jimmy@Nuet.com", password: "12345", password_confirmation: "12345")    
      
      user.save()

      authed = User.authenticate_with_credientials("  Jimmy@Nuet.com  ", "12345")
  
      expect(authed).to be_a User
    end

    it "should account for uppercase in an email" do
      user = User.new(first_name: "Jimmy", last_name: "Nuetron", email: "jimmy@Nuet.com", password: "12345", password_confirmation: "12345")    
      
      user.save()

      authed = User.authenticate_with_credientials("  JImMy@Nuet.com  ", "12345")
  
      expect(authed).to be_a User
    end
  end
end
