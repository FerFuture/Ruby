require "test_helper"

class Api::Features::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_features_comments_create_url
    assert_response :success
  end
end
