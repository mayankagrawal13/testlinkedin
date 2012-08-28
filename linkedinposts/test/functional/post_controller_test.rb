require 'test_helper'

class PostControllerTest < ActionController::TestCase
  test "should get makepost" do
    get :makepost
    assert_response :success
  end

end
