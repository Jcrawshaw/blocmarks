class TopcisController < ApplicationController

  def index
    @topics = Topic.all
  end

  def new
  end

  def show
  end

  def edit
  end


end