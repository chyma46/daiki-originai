class ReviewController < ApplicationController
  before_action :require_user_logged_in

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to root_url
    else
      @reviews = current_user.reviews.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @review.destroy
    flash[:success] = 'レビューを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end
end
