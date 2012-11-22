# Load the rails application
require File.expand_path('../application', __FILE__)

env_file = File.join(Rails.root, 'config', 'env.rb')
load(env_file) if File.exists?(env_file)

# Initialize the rails application
DealProwler::Application.initialize!
