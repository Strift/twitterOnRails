class CommentsController < ApplicationController

	before_action :authenticate_user!

	def create
		@tweet = Tweet.find(params[:tweet_id])
		@comment = @tweet.comments.create(comment_params)
		@comment.html_content = Maruku.new(@comment.content).to_html
		@comment.save
		redirect_to tweet_path(@tweet)
	end

	def destroy
		@tweet = Tweet.find(params[:tweet_id])
		@comment = @tweet.comments.find(params[:id])
		@comment.destroy
		redirect_to tweet_path(@tweet)
	end

	private
		def comment_params
			params.require(:comment).permit(:commenter, :content)
		end
end
