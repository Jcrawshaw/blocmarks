class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])

    @bookmark = Bookmark.new
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(params.require(:bookmark).permit(:url))
    if @bookmark.save
      flash[:notice] = "Bookmark was saved!"
      redirect_to @topic
    else
      flash[:error] = "Error creating the bookmark. Please try again."
      render :new
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update_attributes(params.require(:bookmark).permit(:url))
      redirect_to @bookmark
    else
      flash[:error] = "Error saving bookmark. Please try again."
      render :edit
    end
  end
end
