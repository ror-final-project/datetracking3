class SurveysController < ApplicationController
  def index
		@user = User.find(params[:experience_id])
	end
		

	def show
		@survey = Survey.find(params[:id])
	end

	def new
		@survey = Survey.new
		@experience = Experience.find(params[:experience_id])
		
	end

	def create
		@survey = Survey.new(survey_params)
		@survey.experience_id = params[:experience_id]
		@survey.user = current_user
		if @survey.save
			flash[:notice] = "Your questionnaire has been saved."
			redirect_to experience_path(@survey.experience)
		else
			flash[:alert] = "Your questionnaire was unable to be saved."
			redirect_to experience_path(@survey.experience)
		end
	end

	def survey_params
		params.require(:survey).permit(:answer, :answer_id)
	end

	## do not want to give others ability to edit/delete orig survey
	#def edit
	#	@survey = Survey.find(params[:id])

	#end

	#def update
	#	@survey = Survey.find(params[:id])
	#	if @survey && @survey.update_attributes(params[:survey])
	#		flash[:notice] = "You questionnaire has been updated!"
	#	else
	#		flash[:alert] = "There was an issue updating your questionnaire."
	#	end
	#	redirect_to user_survey_path(@survey.user, @survey)
	#end

	#def destroy
	#	@survey = Survey.find(params[:id])
	#	if @survey.destroy
	#		flash[:notice] = "You questionnaire has been deleted!"
	#		redirect_to user_survey_path(@survey.user)
	#	else
	#		flash[:alert] = "There was an issue deleting your questonnaire."
	#		redirect_to :back
	#	end
	#end
end
