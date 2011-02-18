class CoursesController < ApplicationController
  respond_to :html, :xml, :json
  load_and_authorize_resource
  
  def index
    @school_new_eagle = Course.school(2011).all
    
    @summer_ea_1 = Course.older.camp(2011).during("Session 1").order("programs.language ASC").all
    @summer_ea_2 = Course.older.camp(2011).during("Session 2").order("programs.language ASC").all
    
    @summer_haverford_1 = Course.younger.camp(2011).during("Session 1").order("programs.language ASC").all
    @summer_haverford_2 = Course.younger.camp(2011).during("Session 2").order("programs.language ASC").all
    respond_with @winter_new_eagle, @summer_ea_1, @summer_ea_2, @summer_haverford_1, @summer_haverford_2
  end

  def show
    respond_with @course
  end

  def new
    @course = Course.new
    respond_with @course
  end

  def edit
    respond_with @course
  end

  def create
    @course = Course.new(params[:course])
    if @course.save
      flash[:success] = "New course saved successfully."
    else
      flash[:alert] = "Could not save the new course."
    end
    respond_with @course, :location => courses_path
  end

  def update
    if @course.update_attributes(params[:course])
      flash[:success] = "Updated the course successfully."
    else
      flash[:alert] = "Could not update the course."
    end
    respond_with @course
  end

  def destroy
    @course.destroy
    flash[:notice] = "Deleted the course successfully."
    respond_with @course
  end
end
