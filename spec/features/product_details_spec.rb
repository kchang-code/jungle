require 'rails_helper'


RSpec.feature "Visitor navigates from home page to product page", type: :feature, js: true do
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


  scenario 'Visitor navigates to product page and clicks a product' do

    visit root_path

    click_link('Details', match: :first)

    sleep 1

    expect(page).to have_css '.product-detail'
 
    save_screenshot 'products_details_page.png'
  end
end