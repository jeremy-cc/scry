module Scry
  module Hipchat
    class Notifier < Scry::BaseNotifier

      def colour_map
        config[:colours]
      end

      def post_to_endpoint(message)
        http = Net::HTTP.new(config[:host])
        post = Net::HTTP::Post.new("/v2/room/#{config[:room_id]}/message?auth_token=#{config[:api_key]}")
        post.add_field('Content-Type', 'application/json')
        post.body=message.to_json

        response = http.request(post)

        raise Exception.new(response.inspect) unless response.is_a?(Net::HTTPNoContent)# 204 # hipchat returns HTTP 204 on successful message post
      end

      def notify(message)
        post_to_endpoint(Scry::Hipchat::Message.new(self, message))
      end

      def info(message)

        post_to_endpoint(Scry::Hipchat::InfoMessage.new(self, message))
      end

      def warning(message)
        post_to_endpoint(Scry::Hipchat::WarningMessage.new(self, message))
      end

      def error(message, exception=nil)
        msg = message
        msg = "#{message} - #{exception.message}" if exception && exception.is_a?(Exception)

        post_to_endpoint(Scry::Hipchat::ErrorMessage.new(self, msg))
      end

    end
  end
end