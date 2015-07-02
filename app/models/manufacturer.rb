class Manufacturer < ActiveRecord::Base
  has_many :cars

  validates :name, presence: true, uniqueness: true
  validates :country, presence: true
end
