class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @review = current_user.reviews.build  # form_for 用
      @reviews = current_user.reviews.order('created_at DESC').page(params[:page])
    end
  end
  
  def create
  end
end