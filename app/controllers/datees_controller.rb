class DateesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  def index
    @user = User.find(params[:user_id])
  end

  def show
    redirect_to user_path(params[:id])
  end

  def new
    @relationship1 = Relationship.new
    @relationship2 = Relationship.new
  end

  def create
    @user = User.find(current_user)
    @datee = User.find(params[:datee_id])
    params[:relationship1] = {:user_id => @user.id, :datee_id => @datee.id, :status => 'requested'}
    params[:relationship2] = {:user_id => @datee.id, :datee_id => @user.id, :status => 'pending'}
    @relationship1 = Relationship.create(params[:relationship1])
    @relationship2 = Relationship.create(params[:relationship2])
    if @relationship1.save && @relationship2.save
      redirect_to user_datee_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(current_user)
    @datee = User.find(params[:id])
    params[:relationship1] = {:user_id => @user.id, :datee_id => @datee.id, :status => 'accepted'}
    params[:relationship2] = {:user_id => @datee.id, :datee_id => @user.id, :status => 'accepted'}
    @relationship1 = Relationship.find_by_user_id_and_datee_id(@user.id, @datee.id)
    @relationship2 = Relationship.find_by_user_id_and_datee_id(@datee.id, @user.id)
    if @relationship1.update_attributes(params[:relationship1]) && @relationship2.update_attributes(params[:relationship2])
      flash[:notice] = 'Date sucessfully accepted!'
      redirect_to user_datees_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end
  def destroy
    @user = User.find(params[:user_id])
    @datee = User.find(params[:id])
    @relationship1 = @user.relationships.find_by_datee_id(params[:id]).destroy
    @relationship2 = @datee.relationships.find_by_user_id(params[:id]).destroy
    redirect_to user_datees_path(:user_id => current_user)
  end
end
