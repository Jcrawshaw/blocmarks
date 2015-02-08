class BookmarksController < ApplicationController
  def show
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(params.require(:bookmark).permit(:url))
    authorize @bookmark
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
    authorize @bookmark
    if @bookmark.update_attributes(params.require(:bookmark).permit(:url))
      redirect_to @bookmark
    else
      flash[:error] = "Error saving bookmark. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.find(params[:id])
    authorize @bookmark

    if @bookmark.destroy
      flash[:notice] = "Bookmark was removed."
    else
      flash[:error]  = "Bookmark couldn't be deleted. Try again."
    end
    redirect_to @topic
  end

end
