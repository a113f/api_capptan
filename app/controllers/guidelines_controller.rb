class GuidelinesController < ApplicationController
  before_action :set_guideline, only: [:update, :destroy, :disable, :activate]
  before_action :authenticate_user

  def active
    guidelines = current_user.guidelines.where(inactive: false)
    render json: guidelines, status: :ok
  end

  def activate
    if @guideline.update_attributes(inactive: false)
      render json: @guideline, status: :ok
    else
      render json: {
        error: @guideline.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def inactive
    guidelines = current_user.guidelines.where(inactive: true)
    render json: guidelines, status: :ok
  end

  def disable
    if @guideline.update_attributes(inactive: true)
      render json: @guideline, status: :ok
    else
      render json: {
        error: @guideline.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def create
    guideline = Guideline.new( guideline_params )
    guideline.user = current_user

    if guideline.save
      render json: guideline, status: :created
    else
      render json: {
        error: guideline.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @guideline.update_attributes(guideline_params)
      render json: @guideline, status: :ok
    else
      render json: {
        error: @guideline.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if @guideline.destroy
      render json: { message: "Deleted was succesfully" }, status: :no_content
    else
      render json: { message: "Don't Deleted" }, status: :unprocessable_entity
    end
  end

  private
  def guideline_params
    params.require( :guideline ).permit( :title, :description, :detail )
  end

  def set_guideline
    @guideline = Guideline.find(params[:id])
  end
end
