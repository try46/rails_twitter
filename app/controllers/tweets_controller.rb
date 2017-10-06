class TweetsController < ApplicationController
	def search
		client = Twitter::REST::Client.new do |config|
			config.consumer_key         = Rails.application.secrets.twitter_consumer_key
			config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
		end
		@tweets=[]
		since_id=nil
	if params[:keyword].present?
		tweets = client.search(params[:keyword], count: 10, result_type: "recent", exclude: "retweets", since_id: since_id)
		tweets.take(1000).each do |tw|
			tweets=Tweet.new(tw.full_text)
			@tweets << tweets
		end
	end

		respond_to do |format|
			format.html
			format.json {render json: @tweet}
			format.csv {render csv:@tweet}
		end
	end
end
