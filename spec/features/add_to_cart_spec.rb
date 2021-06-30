require 'rails_helper'

RSpec.feature "Visitor can add product to cart", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'Visitor can add a product to cart from home page' do 
    
    visit root_path

    first('.btn-primary').click

    expect(page).to have_content('My Cart (1)')

    save_screenshot 'add_to_cart.png'
  end
end