class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :responce_invalid_params

  def index
    instructors = Instructor.all
    render json: instructors
  end

  def show
    instructor = find_instructor
    render json: instructor
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  end

  def destroy
    instructor = find_instructor
    instructor.destroy
    head :no_content, status: :gone
  end

  def update 
    instructor = find_instructor
    instructor.update(instructor_params)
    render json: instructor, status: :accepted
  end

  private

  def find_instructor
    instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.permit(:name)
  end

  def not_found_response
    render json: { error: "Instructor not found" }, status: :not_found
  end

  def responce_invalid_params
    render json: {error: "Invalid Params"}, status: :unprocessable_entity 
  end


end
