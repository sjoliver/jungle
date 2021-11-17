require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "The cart count updates from 0 to 1" do
    # ACT
    visit root_path
    sleep(5)
    click_button 'Add'
    
    # DEBUG
    sleep(5)
    # save_screenshot
    # puts page.html

    # VERIFY
    expect(page).to have_text 'My Cart (1)'
  end
  
  end
  