require "./Account.rb"
COSUMER_KEY = gets.chomp
CONSUMER_SECRET = gets.chomp
OAUTH_TOKEN = gets.chomp
OAUTH_TOKEN_SECRET = gets.chomp


acount = Account.new(COSUMER_KEY,CONSUMER_SECRET,OAUTH_TOKEN,OAUTH_TOKEN_SECRET)
acount.userStream
