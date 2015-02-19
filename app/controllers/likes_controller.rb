class LikesController < ApplicationController

def new
  @bookmark = Bookmark.find(params[:bookmark_id])
  @like = Like.new
end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @topic = Topic.find(params[:topic_id])
    @like = current_user.likes.build(bookmark: @bookmark)

    if @like.save
      flash[:notice] = "Bookmark was Liked!"
      redirect_to topic_bookmark_path(@topic, @bookmark)
    else
      flash[:error] = "Unable to Like Bookmark"
      redirect_to topic_bookmark_path(@topic, @bookmark)
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @topic = Topic.find(params[:topic_id])
    @like = current_user.likes.find(params[:id])

    if @like.destroy
      flash[:notice] = "Bookmark was Un-liked."
      redirect_to topic_bookmark_path(@topic, @bookmark)
    else
      flash[:error] = "Error Un-liking bookmark."
      redirect_to topic_bookmark_path(@topic, @bookmark)
    end
  end

end
