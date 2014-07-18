
client = Twitter::REST::Client.new do |config|
 config.consumer_key        = "AkX5RLKTkBp0hDWtEZEqZkS0m"
  config.consumer_secret     = "qmoo0JUQgxbdHzTqe2YBR0F1lUFrlGKWT13KVxajalKo48sOIa"
  config.access_token        = "16377464-ldAolHmVkFwWV3EdF6DtF1QOPeEKv5VUqbvumxZbw"
  config.access_token_secret = "EmAH38KDXrn8DomQgrMgclvIkjsijhG6K78POkvucu24u" 


 end



def client.get_all_tweets(user)
    options = {:count => 3, :include_rts => true}
      user_timeline(user, options)
  end


  @tweet_news = client.get_all_tweets("tezzataz")

topics = ["coffee", "tea"]
client.filter(:track => topics.join(",")) do |object|
  puts object.text if object.is_a?(Twitter::Tweet)
end
