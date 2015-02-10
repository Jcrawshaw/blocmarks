class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create

    @user = User.find_by_email(params[:sender])
    @topic = Topic.find_by_subject(params[:subject])
    @url = params["body-plain"]


    @bookmark= Bookmark.create(url: @url)
    

    head 200
  end

end