class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    logger.info "IncomingController#create: params: #{params.inspect}"

    @user = User.find_by_email(params[:sender])
    # todo: if @user.nil? then create a new user
    @topic = Topic.find_by_title(params[:subject])
    # todo: unless @topic, create the topic
    @url = params["body-plain"]


    @bookmark= Bookmark.build(url: @url)
    @bookmark.save
    

    head 200
  end

end