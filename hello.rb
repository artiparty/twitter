# Run gem install twitter 
# Here is the the API for the Tweet object http://rdoc.info/gems/twitter/Twitter/Tweet
# I've made a simple loop for you, where I print the date, # of retweets and the text


# This means import "twitter" module (the one you installed with gem install twitter) into your current code.
# This makes Twitter:: available.
require 'twitter'

# Here you configure the client to be able to connect to twitter API.
# For real life applications this is secret and can't be publically shared via github. 
# Be careful, security is always imortant on the internet.
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "AkX5RLKTkBp0hDWtEZEqZkS0m"
  config.consumer_secret     = "qmoo0JUQgxbdHzTqe2YBR0F1lUFrlGKWT13KVxajalKo48sOIa"
  config.access_token        = "16377464-ldAolHmVkFwWV3EdF6DtF1QOPeEKv5VUqbvumxZbw"
  config.access_token_secret = "EmAH38KDXrn8DomQgrMgclvIkjsijhG6K78POkvucu24u" 
end

####
#### ART: Skip the following 2 functions. I'll mini comment them, but don't try to understand them for now.
####

# This defines a new function that is user in the next function defintion. Don't dig into it.
def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield(max_id)
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
end

# This adds a new method call to the client variable that was created previously.
def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {:count => 200, :include_rts => true}
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
  end
end

####
#### ART: This is what is interesting for you:

# We make an API call to get all tweets for user "tezzataz"
# The returned result is attached to a name "tweets" you could call it any name you watned "MyCoolResult" would work as well. But don't do it. as code should be elegent to the reader.
tweets = client.get_all_tweets("tezzataz")

# After we got results into tweets, we instruct our code to iterate over the tweets (which is an array containing many TWeet objects)
for tweet in tweets
	# for each tweet, we do the following:
	# Extract created_at which is the date at which this tweet was stored into Twitter
	# Extract retweet_count which is how many people retweeted it
	# Extract text which is what the user wrote in his tweet.
	# print the constructed sting to the user using puts
	puts "#{tweet.created_at} #{tweet.retweet_count } #{tweet.text}"
end


