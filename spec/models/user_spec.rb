require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do 
    context 'Passwords' do
      it "should not save if password is blank" do
        @user = User.new(name: "Sophie", email: "sophie@hotchick.com", password: "", password_confirmation: "123")
        @user.save
        expect(@user.id).not_to be_present
      end

      it "should not save if password_confirmation is blank" do
        @user = User.new(name: "Sophie", email: "sophie@hotchick.com", password: "123", password_confirmation: "")
        @user.save
        expect(@user.id).not_to be_present
      end

      it "should not save if the password and password_confirmation fields do not match" do 
        @user = User.new(name: "Sophie", email: "sophie@hotchick.com", password: "123", password_confirmation: "124")
        @user.save
        expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
      end

      it "should not save if password is less than 3 characters long" do 
        @user = User.new(name: "Sophie", email: "sophie@hotchick.com", password: "12", password_confirmation: "12")
        @user.save
        expect(@user.id).not_to be_present
      end
    end

    context 'Name & Email' do 
      it "should not save if the email already exists in the database" do 
        @user1 = User.new(name: "Sophie", email: "sophie@hotchick.com", password: "123", password_confirmation: "123")
        @user2 = User.new(name: "Sophie", email: "sophie@hotchick.com", password: "123", password_confirmation: "123")
        @user1.save
        @user2.save
        expect(@user2.id).not_to be_present
      end

      it "should not save if the email is not present" do 
        @user = User.new(name: "Sophie", email: "", password: "123", password_confirmation: "123")
        @user.save
        expect(@user.id).not_to be_present
      end
    end
  end

  describe '.authenticate_with_credentials' do 
    it "should return a valid user given valid email and password" do
      @email = 'sophie@hotchick.com'
      @password = '123'
      @user = User.create(name: "Sophie", email: @email, password: @password, password_confirmation: "123")
      user = User.authenticate_with_credentials(@email, @password)
      expect(user).to be_present
    end

    it "should return a valid user when blank space is added before/after a valid email" do
      @email = '   sophie@hotchick.com'
      @password = '123'
      @user = User.create(name: "Sophie", email: 'sophie@hotchick.com', password: @password, password_confirmation: "123")
      user = User.authenticate_with_credentials(@email, @password)
      expect(user).to be_present
    end

    it "should return a valid user when user types in the wrong case for a valid email" do
      @email = 'SOPHie@hotchick.com'
      @password = '123'
      @user = User.create(name: "Sophie", email: 'sophie@hotchick.com', password: @password, password_confirmation: "123")
      user = User.authenticate_with_credentials(@email, @password)
      expect(user).to be_present
    end

    it "should return nil when the email is not found" do
      @email = 'sophie@hotchick.com'
      @password = '123'
      @user = User.create(name: "Sophie", email: @email, password: @password, password_confirmation: "123")
      user = User.authenticate_with_credentials('frankie@cutedog.com', @password)
      expect(user).to be_nil
    end

    it "should return nil when the password is incorrect" do
      @email = 'sophie@hotchick.com'
      @password = '123'
      @user = User.create(name: "Sophie", email: @email, password: @password, password_confirmation: "123")
      user = User.authenticate_with_credentials(@email, '321')
      expect(user).to be_nil
    end
  end
end
