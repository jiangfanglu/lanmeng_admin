class City < ActiveRecord::Base
  attr_accessible :name, :zone_id

  has_many :tournaments, foreign_key: :city_id
end
