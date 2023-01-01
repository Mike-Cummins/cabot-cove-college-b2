require 'rails_helper'

RSpec.describe Resident, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :occupation}
  end

  describe 'relationships' do
    it {should have_many :resident_courses}
    it {should have_many(:courses).through(:resident_courses)}
  end

  it 'calculates the average age of all residents rounded to tenth' do
    @tim = Resident.create!(name: 'Tim', age: 34, occupation: 'Writer')
    @mat = Resident.create!(name: 'Mat', age: 24, occupation: 'Student')
    @bob = Resident.create!(name: 'Bob', age: 45, occupation: 'Baker')

    expect(Resident.average_age).to eq(34.3) 

    @bill = Resident.create!(name: 'Tim', age: 17, occupation: 'Student')

    expect(Resident.average_age).to eq(30) 
  end
end
