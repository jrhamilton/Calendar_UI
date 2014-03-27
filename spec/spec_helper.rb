require 'bundler/setup'
Bundler.require(:default, :test)
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Event.all.each { |x| x.destroy }
    # Question.all.each { |x| x.destroy }
    # Survey.all.each { |x| x.destroy }
    # Taker.all.each { |x| x.destroy }
  end
end
