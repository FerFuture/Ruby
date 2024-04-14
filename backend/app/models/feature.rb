class Feature < ActiveRecord::Base
  validates :feature_id, uniqueness: true
  validates :magnitude, numericality: { greater_than_or_equal_to: -10.0, less_than_or_equal_to: 10.0 }
  validates :place, presence: true
  validates :time, presence: true
  validates :url, presence: true
  validates :tsunami, inclusion: { in: [true, false] }
  validates :mag_type, presence: true
  validates :title, presence: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }
  validates :latitude, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }

  self.per_page = 10
  has_many :comments, dependent: :destroy
end
