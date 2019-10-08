
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'Item Index'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'Merchant Index'
      end

      expect(current_path).to eq('/merchants')
    end
  end
end
