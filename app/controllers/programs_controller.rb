class ProgramsController < ApplicationController
  
  respond_to :html, :xml, :json
  
  def index
    @programs = Program.all
    respond_with @programs
  end

  def show
    @program = Program.find(params[:id])
    respond_with @program
  end
  
  def new
    @program = Program.new
    respond_with @program
  end

  def create
    @program = Program.new(params[:program])
    if @program.save
      flash[:success] = "New program saved successfully."
    else
      flash[:alert] = "Could not save the new program."
    end
    respond_with @program, :location => programs_path
  end

  def edit
    @program = Program.find(params[:id])
    respond_with(@program)
  end

  def update
    @program = Program.find(params[:id])
    if @program.update_attributes(params[:program])
      flash[:success] = "Updated the program successfully."
    else
      flash[:alert] = "Could not update the program."
    end
    respond_with @program
  end

  def destroy
    @program = Program.find(params[:id])
    @program.destroy
    flash[:notice] = "Deleted the program from the database."
    respond_with @program
  end

end
