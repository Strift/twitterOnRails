class TweetsController < ApplicationController

	def index
		@tweets = Tweet.all
	end

	def show
		@tweet = Tweet.find(params[:id])
	end

	def new
		@tweet = Tweet.new
	end

	def edit
		@tweet = Tweet.find(params[:id])
	end

	def create
		@tweet = Tweet.new(tweet_params)
		HardWorker.perform_async(@tweet)
		#@tweet.html_content = Maruku.new(@tweet.content).to_html
		if @tweet.save
			redirect_to @tweet
		else
			render 'new'
		end
	end

	def update
		@tweet = Tweet.find(params[:id])
		HardWorker.perform_async(@tweet)
		#@tweet.html_content = Maruku.new(@tweet.content).to_html
		if @tweet.update(tweet_params)
			redirect_to @tweet
		else
			render 'edit'
		end
	end

	def destroy
		@tweet = Tweet.find(params[:id])
		@tweet.destroy

		redirect_to tweets_path
	end

	private
		def tweet_params
			params.require(:tweet).permit(:author, :content)
		end

end
