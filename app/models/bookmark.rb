require 'embedly'

class Bookmark < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :likes, dependent: :destroy


  def thumbnail
    @thumbnail ||= begin
      obj = Bookmark.embedly.oembed url: url
      obj.first.thumbnail_url
    end
    @thumbnail || default_thumbnail
  end

  def default_thumbnail
    "http://images.apple.com/home/images/og.jpg?201502111511"
  end

  def self.embedly
    # memoize
    @embedly ||= Embedly::API.new user_agent:  'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)', key: 'a8fe13a0b26447ee9df8758e5a2259a9'
  end

end
