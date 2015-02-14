class LikesController < ApplicationController

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = Like.new
    @like.user = current_user
    @like.bookmark = @bookmark
    #@like = current_user.likes.build(bookmark: @bookmark)

    if @like.save
      flash[:notice] = "Bookmark was Liked!"
      redirect_to @bookmark
    else
      flash[:error] = "Unable to Like Bookmark"
      redirect_to @bookmark
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = @bookmark.likes.find(params[:id])

    if @like.destroy
      flash[:notice] = "Bookmark was Un-liked."
      redirect_to @bookmark
    else
      flash[:error] = "Error Un-liking bookmark."
      redirect_to @bookmark
    end
  end

end
