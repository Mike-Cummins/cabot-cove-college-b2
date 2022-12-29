require 'rails_helper'

RSpec.describe 'Residents Show' do
  describe 'As a user when I visit /residents/:id' do
    before :each do
      @tim = Resident.create!(name: 'Tim', age: 34, occupation: 'Writer')
      @bob = Resident.create!(name: 'Bob', age: 45, occupation: 'Baker')
      @crime = Course.create!(name: 'Crime Scene 101')
      @survival = Course.create!(name: 'Wilderness Survival')
      @painting = Course.create!(name: 'Paint by Numbers')
      @resident_course_1 = ResidentCourse.create!(resident_id: @tim.id, course_id: @survival.id)
      @resident_course_2 = ResidentCourse.create!(resident_id: @tim.id, course_id: @crime.id)
      @resident_course_3 = ResidentCourse.create!(resident_id: @bob.id, course_id: @painting.id)
    end

    it 'shows the name of the resident and a list of their courses' do
      visit "/residents/#{@tim.id}"

      expect(page).to have_content(@tim.name)
      expect(page).to_not have_content(@bob.name)

      within "#courses" do
        expect(page).to have_content(@crime.name)
        expect(page).to have_content(@survival.name)
        expect(page).to_not have_content(@painting.name)
      end
    end
  end
end