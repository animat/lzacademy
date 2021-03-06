class LocationsController < ApplicationController
  respond_to :html, :xml, :json
  load_and_authorize_resource
  
  def index
    @locations = Location.all
    respond_with @locations
  end

  def show
    respond_with @location
  end

  def new
    @location = Location.new
    respond_with @location
  end

  def edit
    respond_with @location
  end

  def create
    @location = Location.new(params[:location])
    if @location.save
      flash[:success] = "New location saved successfully."
    else
      flash[:alert] = "Could not save the new location."
    end
    respond_with @location, :location => locations_path
  end

  def update
    if @location.update_attributes(params[:location])
      flash[:success] = "Updated the location successfully."
    else
      flash[:alert] = "Could not update the location."
    end
    respond_with @location
  end

  def destroy
    @location.destroy
    flash[:notice] = "Deleted the location successfully."
    respond_with @location
  end
end
