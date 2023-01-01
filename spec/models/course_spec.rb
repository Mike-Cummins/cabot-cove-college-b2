require 'rails_helper'

RSpec.describe Course, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :resident_courses}
    it {should have_many(:residents).through(:resident_courses)}
  end

  it 'counts the number of residents enrolled in each course' do 
    @tim = Resident.create!(name: 'Tim', age: 34, occupation: 'Writer')
    @mat = Resident.create!(name: 'Mat', age: 24, occupation: 'Student')
    @bob = Resident.create!(name: 'Bob', age: 45, occupation: 'Baker')
    @crime = Course.create!(name: 'Crime Scene 101')
    @survival = Course.create!(name: 'Wilderness Survival')
    @painting = Course.create!(name: 'Paint by Numbers')
    @resident_course_1 = ResidentCourse.create!(resident_id: @tim.id, course_id: @survival.id)
    @resident_course_2 = ResidentCourse.create!(resident_id: @tim.id, course_id: @crime.id)
    @resident_course_3 = ResidentCourse.create!(resident_id: @bob.id, course_id: @painting.id)
    @resident_course_4 = ResidentCourse.create!(resident_id: @bob.id, course_id: @crime.id)
    @resident_course_5 = ResidentCourse.create!(resident_id: @mat.id, course_id: @crime.id)
    @resident_course_6 = ResidentCourse.create!(resident_id: @mat.id, course_id: @survival.id)

    expect(@crime.enrollment_count).to eq(3)
    expect(@survival.enrollment_count).to eq(2)
    expect(@painting.enrollment_count).to eq(1)
  end

  it 'sorts courses alphabetically by name' do
    @crime = Course.create!(name: 'Crime Scene 101')
    @survival = Course.create!(name: 'Wilderness Survival')
    @painting = Course.create!(name: 'Paint by Numbers')

    expect(Course.sort_alpha).to eq([@crime, @painting, @survival])
  end
end
