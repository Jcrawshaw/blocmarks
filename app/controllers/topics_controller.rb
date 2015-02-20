class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new
    @topic = current_user.topics.build(params.require(:topic).permit(:title))

    authorize @topic
    if @topic.save
      flash[:notice] = "New Topic was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic."
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    logger.debug @bookmarks.inspect
     #@bookmark = Bookmark.find(params[:bookmark_id]) 
    @bookmarks = @topic.bookmarks
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.update_attributes(params.require(:topic).permit(:title))
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "There was an error updating the topic. Try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    name = @topic.title

    authorize @topic
    if @topic.destroy
      flash[:notice] = "\"#{name}\" was deleted."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic"
      render :show
    end
  end

end