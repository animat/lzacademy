class RegistrationsController < ApplicationController
  respond_to :html, :xml, :json
  load_and_authorize_resource
  
  def index
    @registrations = Registration.all
  end

  def new
    @young_camp_courses = Course.camp(2011).younger.all
    @old_camp_courses = Course.camp(2011).older.all
    @new_eagle_courses = Course.school(2010).younger.all
    
    @registration = Registration.new
    @registration.student_id = params[:student_id] unless params[:student_id].nil?
  end

  def create
    @courses = params[:registration][:course_id]
    if @courses.empty?
      
    else
      @regs = []
      @courses.each do |course|
        @registration = Registration.new(:student_id => params[:registration][:student_id], :course_id => course)
        @success = @registration.save
        @regs.push(@registration)
      end
      
      if @success
        flash[:success] = "Registration information saved."
        RegistrationMailer.application_received(@regs).deliver
      else
        flash[:alert] = "Could not save your registration information."
      end
      respond_with @registration, :location => after_sign_in_path_for(current_user)
    end
  end

  def show
    respond_with @registration
  end

  def edit
  end

  def update
  end

  def destroy
    RegistrationMailer.registration_canceled(@registration).deliver
    @registration.destroy
    flash[:notice] = "The registration has been cancelled."
    respond_with @registration, :location => :back
  end

end