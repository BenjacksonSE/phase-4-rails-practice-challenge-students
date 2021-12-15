class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :responce_invalid_params

  def index
    students = Student.all
    render json: students
  end

  def show
    student = find_student
    render json: student
    end

  def create
    student = Student.create!(student_params)
    render json: student, status: :created
  end

  def destroy
    student = find_student
    student.destroy
    head :no_content, status: :gone
  end

  def update 
    student = find_student
    student.update(student_params)
    render json: student, status: :accepted
  end

  private

  def find_student
    student = Student.find(params[:id])
  end

  def student_params
    params.permit(:name, :major, :age, :instructor_id)
  end

  def responce_not_found
    render json: {error: "Student not found"}, status: :not_found
  end

  def responce_invalid_params
    render json: {error: "Invalid Params"}, status: :unprocessable_entity 
  end
end
