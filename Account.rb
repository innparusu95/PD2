# -*- coding: utf-8 -*-
require 'tweetstream' #ユーザーストリーム処理を行うライブラリ
require 'Twitter' #twitterAPI

class Account
  def initialize consumer_key,consumer_secret,oauth_token,oauth_token_secret
    #ログイン
    Twitter.configure do |config| #Twitterのログイン処理
      config.consumer_key = consumer_key 
      config.consumer_secret = consumer_secret
      config.oauth_token = oauth_token
      config.oauth_token_secret = oauth_token_secret
    end

    TweetStream.configure do |config| #tweetstreamのログイン処理
      config.consumer_key = consumer_key 
      config.consumer_secret = consumer_secret
      config.oauth_token = oauth_token
      config.oauth_token_secret = oauth_token_secret
      config.auth_method        = :oauth
    end

    #インスタンスフィールド
    @USER_NAME = Twitter.user().screen_name
    @MATCH_NAME = Regexp.new("@#{@USER_NAME} .*")
    @client = TweetStream::Client.new
  end

  def userStream #ユーザーストリームの処理
    setMentions #setMentionsメソッドの呼び出し
    @client.userstream do |status| #ユーザーストリームのループ(TLが更新されるたびに変数statusにツイート情報を記憶)
      addMentions(status) #addMentionsメソッドを引数statusで呼び出す
    end
  end

  def addMentions status #addMentionsメソッドの定義
    if @MATCH_NAME =~ status.text #定数MATCH_NAME(@ユーザー名)にツイート内容がマッチしたら
      puts "#{status.user.screen_name}:#{status.text}" #ツイートしたユーザー名とツイート内容を出力
      setMentions #setMentionsメソッドを呼び出す
    end
  end

  def setMentions #setMentionsメソッドの定義
    @hash = Hash.new(0) #ハッシュ(添字が数字じゃなくてもよい配列)を作成
    Twitter.mentions(count: 200).each do |tweet| #リプライのリストを一つづつとりループを行う
      @hash[tweet.user.screen_name] += 1  #ハッシュ[ユーザーネーム]をインクリメント
    end
    p @hash.sort{|a,b| b[1]<=>a[1]} #ハッシュの内容を出力
  end

  private :addMentions,:setMentions
end
