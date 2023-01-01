require 'rails_helper'

RSpec.describe 'Courses Index' do
  describe 'As a user when I visit /courses' do
    before :each do
      @tim = Resident.create!(name: 'Tim', age: 34, occupation: 'Writer')
      @bob = Resident.create!(name: 'Bob', age: 45, occupation: 'Baker')
      @crime = Course.create!(name: 'Crime Scene 101')
      @survival = Course.create!(name: 'Wilderness Survival')
      @painting = Course.create!(name: 'Paint by Numbers')
      @resident_course_1 = ResidentCourse.create!(resident_id: @tim.id, course_id: @survival.id)
      @resident_course_2 = ResidentCourse.create!(resident_id: @tim.id, course_id: @crime.id)
      @resident_course_3 = ResidentCourse.create!(resident_id: @bob.id, course_id: @painting.id)
      @resident_course_4 = ResidentCourse.create!(resident_id: @bob.id, course_id: @crime.id)
    end

    it 'shows all courses and the number of residents in each one' do
      visit "/courses"

      expect(page).to have_content(@crime.name)
      expect(page).to have_content(@survival.name)
      expect(page).to have_content(@painting.name)

      within "#course_#{@crime.id}" do 
        expect(page).to have_content("Residents Enrolled: 2")
      end

      within "#course_#{@survival.id}" do
        expect(page).to have_content("Residents Enrolled: 1")
      end
    end

    it 'displays courses in alphabetcal order' do
      visit '/courses'

      expect(@crime.name).to appear_before(@painting.name)
      expect(@painting.name).to appear_before(@survival.name)
    end
  end
end