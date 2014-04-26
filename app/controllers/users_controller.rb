class UsersController < ApplicationController
  
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Thanks for joining Here's the thing..."
      redirect_to "/"
    else
      flash[:alert] = "There was a problem creating your account. Please try again."
      redirect_to :back
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user && @user.update_attributes(params[:user])
      flash[:notice] = "Changes made - good to go!"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Uh Oh - there was an issue with with your updates" 
      redirect_to :back
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user && @user.destroy
      flash[:notice] = "Your user has been deleted."
    else
      flash[:alert] = "There was an issue deleting that user..."
    end
    redirect_to "/users"
  end

  def show
    @user = User.find(params[:id])

    #respond_to do |format|
       # format.html # show.html.erb
        #format.xml { render :xml => @user }
    #end
  end

private
def user_params
  params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation, :avatar)
end

end
