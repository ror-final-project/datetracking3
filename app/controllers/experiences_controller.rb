class ExperiencesController < ApplicationController
  def index
    @experiences = Experience.all
  end

  def show
    @experience = Experience.find(params[:id])
  end

  def new
    @experience = Experience.new
  end

  def create
    @experience = Experience.new(experience_params)
    @experience.user = current_user
    if @experience.save
      flash[:notice] = "Your date has been saved."
      redirect_to experiences_path(@experience)
    else
      flash[:alert] = "Your date was unable to be saved."
      redirect_to :back
    end
  end

  def edit
    @experience = Experience.find(params[:id])

  end

  def update
    @experience = Experience.find(params[:id])
    if @experience && @experience.update_attributes(experience_params)
      flash[:notice] = "You experience has been updated!"
    else
      flash[:alert] = "There was an issue updating your experience."
    end
    redirect_to experience_path(@experience)
  end

  def destroy
    @experience = Experience.find(params[:id])
    if @experience.destroy
      flash[:notice] = "You date has been updated!"
      redirect_to user_experience_path(@experience.user)
    else
      flash[:alert] = "There was an issue updating your date."
      redirect_to :back
    end
  end

  private

  def experience_params
    params.require(:experience).permit(:date, :location, :description)
  end
end
