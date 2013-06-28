class ContentsController < ApplicationController
  def index
    @mentions = Hash.new(0)
    @profile = Hash.new('')
    @images = Hash.new('')
    if signed_in?
      setdata
      end
    end

  def setdata #setMentionsメソッドの定義
    @mentions = Hash.new(0) #ハッシュ(添字が数字じゃなくてもよい配列)を作成
    Twitter.mentions(count: 200).each do |tweet| #リプライのリストを一つづつとりループを行う
      @mentions[tweet.user.screen_name] += 1  #ハッシュ[ユーザーネーム]をインクリメント
      @profile[tweet.user.screen_name] = tweet.user.description
      @images[tweet.user.screen_name] = tweet.user.profile_image_url_https  #ハッシュ[ユーザーネーム]にアイコン画像のurlを代入
    end
  end
end
