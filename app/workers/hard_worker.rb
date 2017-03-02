class HardWorker
  include Sidekiq::Worker

  def perform(tweet)
    tweet.html_content = Maruku.new(tweet.content).to_html
  end
end
