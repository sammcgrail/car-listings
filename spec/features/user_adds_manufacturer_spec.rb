require 'rails_helper'

feature 'user adds a car manufacturer', %{
  As a car salesperson
  I want to record a car manufacturer
  So that I can keep track of the types of cars found in the lot

} do
  # Acceptance Criteria:
  #
  # [ ]  I must specify a manufacturer name and country.
  # [ ]  If I do not specify the required information, I am presented with errors.
  # [ ]  If I specify the required information, the manufacturer is recorded and I am redirected to the index of manufacturers
  
  scenario 'create a valid car manufacturer' do
    visit new_manufacturer_path

    fill_in "Name", with: "Ford"
    fill_in "Country", with: "USA"
    click_on "Create Manufacturer"

    expect(page).to have_content("success")
    expect(page).to have_content("Ford")
    expect(page).to have_content("USA")
  end

  scenario 'user did not fill in required fields' do
    visit new_manufacturer_path

    fill_in "Name", with: "Ford"
    click_on "Create Manufacturer"

    expect(page).to have_content("can't be blank")
  end

  scenario 'user tries to enter a duplicate' do
    FactoryGirl.create(:manufacturer, name: "Ford")
    visit new_manufacturer_path

    fill_in "Name", with: "Ford"
    fill_in "Country", with: "test country"
    click_on "Create Manufacturer"

    expect(page).to have_content("has already been taken")
  end

end
