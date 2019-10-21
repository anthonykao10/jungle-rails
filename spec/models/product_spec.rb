require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      category = Category.find_or_create_by! name: 'Apparel'
      product = category.products.create({
        name:  'test product',
        quantity: 1,
        price: 1000
      })
      expect(product).to be_valid
    end

    it "is not valid without a name" do
      category = Category.find_or_create_by! name: 'Apparel'
      product = category.products.create({
        name:  nil,
        quantity: 1,
        price: 1000
      })
      expect(product).to_not be_valid
    end

    it "is not valid without a price" do
      category = Category.find_or_create_by! name: 'Apparel'
      product = category.products.create({
        name:  'test product',
        quantity: 1,
        price: nil
      })
      expect(product).to_not be_valid
    end
    
    it "is not valid without a quantity" do
      category = Category.find_or_create_by! name: 'Apparel'
      product = category.products.create({
        name:  'test product',
        quantity: nil,
        price: 1000
      })
      expect(product).to_not be_valid
    end

    it "is not valid without a category" do
      product = Product.create({
        name:  'test product',
        quantity: 1,
        price: 1000,
        category_id: nil
      })
      expect(product).to_not be_valid
    end

    it "expect 'Name can\'t be blank' error is found in .errors.full_messages array" do
      category = Category.find_or_create_by! name: 'Apparel'
      product = category.products.create({
        name:  nil,
        quantity: 1,
        price: 1000
      })
      expect(product.errors.full_messages).to include("Name can't be blank")
      puts "***************************"
      puts product.inspect
      puts product.errors.full_messages
      puts "***************************"
    end
  end
end
