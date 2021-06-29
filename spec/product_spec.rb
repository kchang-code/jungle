require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do 
      @category = Category.new(name: "Mens clothing")
      @category.save();
    end

  it 'creates a new product' do
    @product = Product.new(
      name: "Shoes", 
      price: 500, 
      quantity: 20, 
      category: @category
    )
    @product.save()

    expect(@product).to be @product
  end
    
    context "given a name" do
      it 'if valid returns true' do
        @product = Product.new(
          name: nil,
          price: 500, 
          quantity: 20, 
          category: @category
        )
        @product.save()

        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    context "given a price" do
      it 'if valid returns true' do
        @product = Product.new(
          name: "Shoes", 
          price: nil, 
          quantity: 20, 
          category: @category
        )
        @product.save()

        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end

    context "given a quantity" do
      it 'if valid returns true' do
        @product = Product.new(
          name: "Shoes", 
          price: 500, 
          quantity: nil, 
          category: @category
        )
        @product.save()
      
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    context "given a category" do
      it 'if valid returns true' do
        @product = Product.new(
          name: "Shoes", 
          price: 500, 
          quantity: 20, 
          category: nil
        )
        @product.save()
      
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end
  end

  end
end

