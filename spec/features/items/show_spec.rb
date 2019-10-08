require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @review_1 = @chain.reviews.create(title: "It'll never break!", content: "Great chain!", rating: 5)
    @review_2 = @chain.reviews.create(title: "Rusts quickly", content: "Oil it frequently", rating: 3)
    visit "/items/#{@chain.id}"
  end

  it 'shows item info' do
    expect(page).to have_link(@chain.merchant.name)
    expect(page).to have_content(@chain.name)
    expect(page).to have_content(@chain.description)
    expect(page).to have_content("Price: $#{@chain.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{@chain.inventory}")
    expect(page).to have_content("Sold by: #{@bike_shop.name}")
    expect(page).to have_css("img[src*='#{@chain.image}']")
  end

  it "shows item review info" do
    within "#review-#{@review_1.id}" do
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.content)
      expect(page).to have_content("Rating: #{@review_1.rating}")
    end

    within "#review-#{@review_2.id}" do
      expect(page).to have_content(@review_2.title)
      expect(page).to have_content(@review_2.content)
      expect(page).to have_content("Rating: #{@review_2.rating}")
    end
  end

  it "shows a link to delete a review" do
    within "#review-#{@review_1.id}" do
      click_link 'Delete Review'
    end
    expect(current_path).to eq("/items/#{@chain.id}")
    expect(page).to_not have_css("#review-#{@review_1.id}")
  end
end
