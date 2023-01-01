class ResidentsController < ApplicationController
  
  def index
    @residents = Resident.sort_alpha
  end

  def show
    @resident = Resident.find(params[:id])
  end
end