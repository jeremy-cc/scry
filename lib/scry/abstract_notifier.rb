=begin
  Basic parent class for all subsequent notifiers.  A notifier is a small module which knows how to format an incoming message appropriately for its endpoint.
=end
module Scry
  class BaseNotifier
    attr_reader :config

    def initialize(config)
      @config = config
    end
  end
end