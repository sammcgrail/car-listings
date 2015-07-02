require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :car do
    association :manufacturer, factory: :manufacturer
    sequence(:name) { |n| "Focus #{n}" }
    description "Test description text for Ford car from USA."
    color "red"
    year 2012
    mileage 100
  end

  factory :manufacturer do
    sequence(:name) { |n| "Ford #{n}" }
    country "USA"
  end

end
