require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

  # SETUP
  before :each do
    
    User.create(email: 'test@gmail.com', name: 'test', password: 'password', password_confirmation: 'password')

    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do

    visit root_path

    # Go to Login page
    click_on('login')
    expect(page).to have_css 'form[action="/login"]'

    # Login
    fill_in 'email', with: 'test@gmail.com'
    fill_in 'password', with: 'password'
    click_on 'Submit'

    expect(page).to have_content 'My Cart (0)'
    # save_screenshot

    first('.product').click_button('Add')

    expect(page).to have_content 'My Cart (1)'
    # save_screenshot
  end
  
end
