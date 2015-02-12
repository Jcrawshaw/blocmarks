class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    logger.info "IncomingController#create: sender: #{params[:sender]}"
    logger.info "IncomingController#create: subject: #{params[:subject]}"
    logger.info "IncomingController#create: body: #{params['body-plain']}"

    @user = User.find_by_email(params[:sender])
     if @user.nil? 
       @user = User.create(email: params[:sender], password: params[:subject])
     end
    @topic = Topic.find_by_title(params[:subject])
       unless @topic 
          @topic = Topic.create(title: params[:subject], user_id: @user_id )
          @topic = Topic.new(params.require(:topic).permit(:title))
          @topic.save
        end
    @url = params["body-plain"].split("\n").first
    # todo: be smarter about finding the url

    #@bookmark= Bookmark.new(url: @url)
    @bookmark.user = @user
    @bookmark= @topic.bookmarks.build(url: @url)
    @bookmark.save
    

    head 200
  end

end