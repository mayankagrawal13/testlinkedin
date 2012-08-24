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
#Replace {group id} in the url below with the actual numeric group id e.g. 4588653
response = @access_token.post('http://api.linkedin.com/v1/groups/{group id}/posts', '<post><title>Post Title</title><summary>my summary</summary></post>', {'Content-Type' => 'application/xml'})
#puts response.body
