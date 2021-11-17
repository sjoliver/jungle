require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "They see the product details" do
    # ACT
    visit root_path
    sleep(5)
    page.find('.pull-right').click

    # DEBUG
    sleep(5)
    # save_screenshot

    # VERIFY
    expect(page).to have_css 'article.product-detail'
  end

end
