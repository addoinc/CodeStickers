# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  config.action_controller.session = {
    :session_key => '_ficus_session',
    :secret      => 'ebc7080e617244de1b75f8fd1a81cad2b8364d8723dda7d9b1fa6cdbe7891e802d711d2ae9a8e42c69dd83cb9989a0c6d78c65d6c85f1b35e8059fd35492d1ca'
  }
  # (create the session table with "rake db:sessions:create")
  config.action_controller.session_store = :active_record_store
  
end
