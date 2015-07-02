require 'rails_helper'
require 'pry'

feature 'user adds a car', %{
  As a car salesperson
  I want to record a newly acquired car
  So that I can list it in my lot
} do

  # Acceptance Criteria:
  #
  # [ ] I must specify the manufacturer, color, year, and mileage of the car. (assoc btwn car and existing manuf)
  # [ ] Only years from 1920 and above can be specified.
  # [ ] I can optionally specify a description of the car.
  # [ ] If I enter all of the required information in the required formats, the car is recorded and I am presented with a notification of success
  # [ ] If I do not specify all of the required information in the required formats, the car is not recorded and I am presented with errors.
  # [ ] Upon successfully creating a car, I am redirected back to the index of cars.

  let!(:manufacturer) { FactoryGirl.create(:manufacturer, name: 'Ford') }

  scenario 'user creates a valid car' do
    visit new_car_path
    select manufacturer.name, from: 'car[manufacturer_id]'
    fill_in "Color", with: "Blue"
    fill_in "Year", with: "1997"
    fill_in "Mileage", with: "101"
    fill_in "Description", with: "test desc"

    click_button "Create Car"

    expect(page).to have_content("success")
    expect(page).to have_content("Blue")
    expect(page).to have_content("1997")
    expect(page).to have_content("101")
  end

  scenario 'user did not fill in required fields' do
    visit new_car_path
    fill_in "Color", with: "Blue"
    fill_in "Year", with: "1997"

    click_on "Create Car"

    expect(page). to have_content("can't be blank")
  end

  scenario 'user did not enter an integer for mileage' do
    visit new_car_path
    fill_in "Mileage", with: "test of string for mileage"
    fill_in "Color", with: "Blue"
    fill_in "Year", with: "1997"

    click_on "Create Car"

    expect(page). to have_content("is not a number")
  end

  scenario 'user is presented with error when submitting pre 1920s car' do
    visit new_car_path
    select(manufacturer.name, :from => 'car[manufacturer_id]')
    fill_in "Color", with: "Blue"
    fill_in "Year", with: "1890"
    fill_in "Mileage", with: "99999"

    click_on "Create Car"

    expect(page).to have_content("Year must be greater than 1920")
  end

end
