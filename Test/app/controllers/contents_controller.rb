class ContentsController < ApplicationController
  def index
    @mentions = Hash.new(0)
    @images = Hash.new('')
    if signed_in?
      Twitter.mentions(count: 200).each do |tweet| 
        @mentions[tweet.user.screen_name] += 1 
        @images[tweet.user.screen_name] = tweet.user.profile_image_url_https  #ハッシュ[ユーザーネーム]にアイコン画像のurlを代入
      end
    end
  end
end
