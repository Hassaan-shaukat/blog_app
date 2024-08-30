class LikesController < ApplicationController
  def create
    @likeable = find_likeable
    @likeable.likes.create(user: current_user)
  end

  private

  def find_likeable
    params[:likeable_type].constantize.find(params[:likeable_id])
  end
end
