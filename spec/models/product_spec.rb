require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should not save if there is no name present" do
      @name = "TEST"
      @price = 10
      @quantity = 25
      @category = Category.new(name: @name)

      @product = Product.new(name: nil, price: @price, quantity: @quantity, category: @category)

      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not save if there is no price present" do
      @name = "TEST"
      @price = 10
      @quantity = 25
      @category = Category.new(name: @name)
      @product = Product.new(name: @name, price: nil, quantity: @quantity, category: @category)

      @product.save

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should not save if there is no quantity present" do
      @name = "TEST"
      @price = 10
      @quantity = 25
      @category = Category.new(name: @name)
      @product = Product.new(name: @name, price: @price, quantity: nil, category: @category)

      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not save if there is no category present" do
      @name = "TEST"
      @price = 10
      @quantity = 25
      @category = Category.new(name: @name)
      @product = Product.new(name: nil, price: @price, quantity: @quantity, category: nil)

      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

    it "should save successfully if all required fields are present" do
      @name = "TEST"
      @price = 10
      @quantity = 25
      @category = Category.new(name: @name)
      @product = Product.new(name: @name, price: @price, quantity: @quantity, category: @category)

      @product.save

      expect(@product.id).to be_present
    end
  end
end
