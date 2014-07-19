# Run gem install twitter 
# Here is the the API for the Tweet object http://rdoc.info/gems/twitter/Twitter/Tweet
# I've made a simple loop for you, where I print the date, # of retweets and the text

require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "AkX5RLKTkBp0hDWtEZEqZkS0m"
  config.consumer_secret     = "qmoo0JUQgxbdHzTqe2YBR0F1lUFrlGKWT13KVxajalKo48sOIa"
  config.access_token        = "16377464-ldAolHmVkFwWV3EdF6DtF1QOPeEKv5VUqbvumxZbw"
  config.access_token_secret = "EmAH38KDXrn8DomQgrMgclvIkjsijhG6K78POkvucu24u" 
end

def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield(max_id)
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
end

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {:count => 200, :include_rts => true}
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
  end
end

tweets = client.get_all_tweets("tezzataz")
for tweet in tweets
	puts "#{tweet.created_at} #{tweet.retweet_count } #{tweet.text}"
end


