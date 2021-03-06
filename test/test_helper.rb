ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

end

class ActionController::TestCase
  include Devise::TestHelpers

  def sign_in(user)
    warden.instance_variable_set('@users', { user: user })
  end

  def sign_out
    warden.instance_variable_set('@users', {})
  end
end

class ActionDispatch::IntegrationTest
  def sign_in(user, options = {})
    password = options[:password] || "password"
    post_via_redirect user_session_path, user: { email: user.email, password: password }
  end

  def sign_out
    # Does this work?
    # delete destroy_user_session_path
  end
end
