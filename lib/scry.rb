require 'rubygems'
require 'httparty'
require 'json'
require 'tcc_router'

root_file = File.dirname(__FILE__)

files = Dir["#{root_file}/scry/**/*.rb"].reject { |l| l.end_with? "version.rb" }
files.sort.each { |m| require m }

module Scry

  def self.for(service, config)
    Scry::Base.new(config).send(service)
  end

  class Base
    attr_reader :config

    def initialize(config)
      @config = config
    end

    # Used to seamlessly integrate with individual notifiers.  Extending should be as simple as extending a new module and providing it transport.
    def method_missing(method, *args, &block)
      klass = Scry.const_get(method.to_s.capitalize)
      if klass
        klass = klass.const_get('Notifier')
        if klass
          raise unless args
          klass.new(config[method])
        else
          super
        end
      else
        super
      end
    end
  end
end

config = {
    :hipchat => {
        :host=>'https://api.hipchat.com',
        :api_key => '',
        :room_id => '',
        :colours=>{
            :info=>'green',
            :none=>'gray',
            :warning=>'yellow',
            :error=>'red'
        }
    }
}

hipchat = Scry.for(:hipchat, config)

hipchat.info 'Test message'