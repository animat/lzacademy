class ParentsController < ApplicationController
  respond_to :html, :xml, :json
  load_and_authorize_resource
  
  def index
    @parents = Parent.all
    respond_with @parents
  end

  def show
    @parent = Parent.includes(:students, :registrations).find(params[:id])
    respond_with @parent
  end

  def new
    @young_camp_courses = Course.camp(2013).younger.all
    @old_camp_courses = Course.camp(2013).older.all
    
    @parent = Parent.new
    @parent.students.build
    respond_with @parent
  end

  def edit
    respond_with @parent
  end

  def create
    @parent = Parent.new(params[:parent])
    if @parent.save
      r = Role.find_by_name("parent")
      RolesUsers.create(:parent_id => @parent.id, :role_id => r.id)
      flash[:success] = "Information saved successfully."
      sign_in(:parent, @parent)
      respond_with @parent, :location => parent_path(@parent)
    else
      flash[:alert] = "We could not save your information. Please check for errors below."
      respond_with @parent, :location => new_parent_path
    end
  end

  def update
    if @parent.update_attributes(params[:parent])
      flash[:success] = "Updated your information successfully."
    else
      flash[:alert] = "Sorry! We couldn't save your information."
    end
    respond_with @parent
  end

  def destroy
    @parent.destroy
    flash[:notice] = "Deleted the parent successfully."
    respond_with @parent
  end
end
