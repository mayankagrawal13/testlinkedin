require 'oauth'
require 'json'
class PostController < ApplicationController
  def auth
      api_key = '0j5m1xz9fzcf'
      api_secret = 'NPOg4f33Z6szybLU'

       configuration = { :site => 'https://api.linkedin.com',
                          :authorize_path => '/uas/oauth/authenticate',
                          :request_token_path => '/uas/oauth/requestToken?scope=rw_groups',
                          :access_token_path => '/uas/oauth/accessToken' }

       consumer = OAuth::Consumer.new(api_key, api_secret, configuration)

       request_token = consumer.get_request_token( { :oauth_callback => 'http://10.40.50.106:3000/home' } )
       session[:request_token] = request_token
       @url = request_token.authorize_url
       respond_to do |format|
          format.html
       end       
  end
  def home 
       verifier = params[:oauth_verifier]
       request_token = session[:request_token]
       @access_token = request_token.get_access_token(:oauth_verifier => verifier)
       session[:access_token] = @access_token
       redirect_to :controller => 'post', :action => 'show'
   end
   def show
       @access_token = session[:access_token]
       response = @access_token.get("http://api.linkedin.com/v1/groups/4588653/posts:(creator:(first-name,last-name,picture-url),title,summary,creation-timestamp,id)?format=json")
       @posts = JSON.parse(response.body)['values']
	
       respond_to do |format|
         format.html
       end
  end
  def new
       respond_to do |format|
          format.html 
       end
  end
  def create

       @access_token = session[:access_token] 
       @posttitle = params[:posttitle]
       @postsummary = params[:postsummary]
       response = @access_token.post('http://api.linkedin.com/v1/groups/4588653/posts', "<post><title>#{@posttitle}</title><summary>#{@postsummary}</summary></post>", {'Content-Type' => 'application/xml'})
       respond_to do |format|
          format.html
       end

  end
  def delete
       @access_token = session[:access_token]
       @id = params[:id]
       response = @access_token.delete("http://api.linked.com/v1/posts/#{@id}")
       puts '*' * 50
       puts response.body
       puts '*' * 50
       redirect_to :controller => 'post', :action => 'show'
  end
end
