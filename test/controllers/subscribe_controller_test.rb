require 'test_helper'

class SubscribeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get subscribe_new_url
    assert_response :success
  end

end
