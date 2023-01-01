class CoursesController < ApplicationController

  def index
    @courses = Course.sort_alpha
  end

end