require 'rails_helper'

RSpec.describe 'Residents Index' do
  describe 'As a user when I visit /residents' do
    before :each do
      @tim = Resident.create!(name: 'Tim', age: 34, occupation: 'Writer')
      @bob = Resident.create!(name: 'Bob', age: 45, occupation:'Baker')
      @mat = Resident.create!(name: 'Mat', age: 22, occupation: 'Musician')
    end
    it 'shows all residents and their name, age, and occupation' do
      visit "/residents"

      within "#resident_#{@tim.id}" do
        expect(page).to have_content(@tim.name)
        expect(page).to have_content(@tim.age)
        expect(page).to have_content(@tim.occupation)
        expect(page).to_not have_content(@bob.name)
        expect(page).to_not have_content(@mat.name)
      end

      within "#resident_#{@bob.id}" do
        expect(page).to have_content(@bob.name)
        expect(page).to have_content(@bob.age)
        expect(page).to have_content(@bob.occupation)
        expect(page).to_not have_content(@tim.name)
        expect(page).to_not have_content(@mat.name)
      end      
      
      within "#resident_#{@mat.id}" do
        expect(page).to have_content(@mat.name)
        expect(page).to have_content(@mat.age)
        expect(page).to have_content(@mat.occupation)
        expect(page).to_not have_content(@tim.name)
        expect(page).to_not have_content(@bob.name)
      end      
    end

    it 'displays the average age of all residents' do
      visit '/residents'
    
      expect(page).to have_content("Average Resident Age: 33.7")
    end

    it 'displays the residents in alphabetical order' do
      visit '/residents'

      expect(@bob.name).to appear_before(@mat.name)
      expect(@mat.name).to appear_before(@tim.name)
    end
  end
end