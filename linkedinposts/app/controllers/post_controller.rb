require 'oauth'
class PostController < ApplicationController
  def auth
      api_key = '0j5m1xz9fzcf'
      api_secret = 'NPOg4f33Z6szybLU'

       configuration = { :site => 'https://api.linkedin.com',
                          :authorize_path => '/uas/oauth/authenticate',
                          :request_token_path => '/uas/oauth/requestToken',
                          :access_token_path => '/uas/oauth/accessToken' }

       consumer = OAuth::Consumer.new(api_key, api_secret, configuration)

       request_token = consumer.get_request_token( { :oauth_callback => 'http://localhost:3000/lipost' } )
       session[:request_token] = request_token
       @url = request_token.authorize_url
       respond_to do |format|
          format.html
       end       
end
  def makepost
       verifier = params[:oauth_verifier]
       puts verifier
       request_token = session[:request_token]
       @access_token = request_token.get_access_token(:oauth_verifier => verifier)
       session[:access_token] = @access_token
       respond_to do |format|
          format.html 
       end
  end
  def dopost
       api_key = '0j5m1xz9fzcf'
       api_secret = 'NPOg4f33Z6szybLU'

       @access_token = session[:access_token] 
       @posttitle = params[:posttitle]
       @postsummary = params[:postsummary]
       response = @access_token.post('http://api.linkedin.com/v1/groups/4588653/posts', "<post><title>#{@posttitle}</title><summary>#{@postsummary}</summary></post>", {'Content-Type' => 'application/xml'})
       puts '-' * 50
       puts response.body
       puts '-' * 50
       respond_to do |format|
          format.html
       end

  end
end
