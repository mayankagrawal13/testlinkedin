require 'oauth'
require 'json'

#Specify the values provided while creating an app
api_key = ''
api_secret = ''
user_token = ''
user_secret = ''

configuration = {:site=> 'https://api.linked.com'}

consumer = OAuth::Consumer.new(api_key, api_secret, configuration)

@access_token = OAuth::AccessToken.new(consumer, user_token, user_secret)
=begin
#response = @access_token.get("http://api.linkedin.com/v1/people/~?format=json")
response = @access_token.get("http://api.linkedin.com/v1/people/~/group-memberships:(group:(id,name),membership-state)?format=json")
result = JSON.parse(response.body)
puts result
=end
#response = @access_token.post('http://api.linkedin.com/v1/groups/4588653/posts?format=json', {:title => 'My Post Title', :summary => 'My Post Summary'}, {'Content-Type' => 'application/json', 'x-li-format' => 'json'})
response = @access_token.post('http://api.linkedin.com/v1/groups/4588653/posts', '<post><title>Post Title</title><summary>my summary</summary></post>', {'Content-Type' => 'application/xml'})
#puts response.body
