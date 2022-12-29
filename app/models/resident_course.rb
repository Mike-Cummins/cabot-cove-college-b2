class ResidentCourse < ApplicationRecord
  belongs_to :course
  belongs_to :resident
end
