# encoding: utf-8
require 'tweetstream'
require 'Twitter'
require 'pp'


class Acount

  def initialize(consumer_key,consumer_secret,oauth_token,oauth_token_secret)
    #ログイン
    Twitter.configure do |config|
      config.consumer_key = consumer_key 
      config.consumer_secret = consumer_secret
      config.oauth_token = oauth_token
      config.oauth_token_secret = oauth_token_secret
    end

    TweetStream.configure do |config|
      config.consumer_key = consumer_key 
      config.consumer_secret = consumer_secret
      config.oauth_token = oauth_token
      config.oauth_token_secret = oauth_token_secret
      config.auth_method        = :oauth
    end

    #インスタンスフィールド
    @USER_NAME = Twitter.user().screen_name
    @MATCH_NAME = Regexp.new("#{@USER_NAME} .*")
    @client = TweetStream::Client.new
  end

  def userStream()
    setMentions
    @client.userstream do |status|
      addMentions(status)
    end
  end

  def setMentions()
    @hash = Hash.new(0)
    Twitter.mentions.each do |tweet| 
      @hash[tweet.user.screen_name] += 1 
    end
    p @hash
  end


  def addMentions(status)
    if @MATCH_NAME =~ status.text
      puts "#{status.user.screen_name}:#{status.text}"
      setMentions
    end
  end

  private :addMentions,:setMentions
end

# main
COSUMER_KEY = gets.chomp
CONSUMER_SECRET = gets.chomp
OAUTH_TOKEN = gets.chomp
OAUTH_TOKEN_SECRET = gets.chomp


acount = Acount.new(COSUMER_KEY,CONSUMER_SECRET,OAUTH_TOKEN,OAUTH_TOKEN_SECRET)
acount.userStream