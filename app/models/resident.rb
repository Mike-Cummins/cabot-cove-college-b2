class Resident < ApplicationRecord
  has_many :resident_courses
  has_many :courses, through: :resident_courses
  validates_presence_of :name, :age, :occupation

  def self.average_age
    average(:age).round(1)
  end

  def self.sort_alpha
    order(:name)
  end
end
