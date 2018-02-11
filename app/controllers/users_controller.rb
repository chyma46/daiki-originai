class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.order('created_at DESC').page(params[:page])

    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def soccer
    @user = User.find(params[:id])
    @reviews = @user.reviews.where(sport: "海外サッカー").order('created_at DESC').page(params[:page])
  end
  
  def mlb
    @user = User.find(params[:id])
    @reviews = @user.reviews.where(sport: "MLB").order('created_at DESC').page(params[:page])
  end
  
  def others
    @user = User.find(params[:id])
    @reviews = @user.reviews.where.not(sport: "海外サッカー").where.not(sport: "MLB").order('created_at DESC').page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
