module Scry
  module Hipchat
    class Message
      attr_reader :notifier, :text, :notify, :colour, :format

      def initialize(notifier, message_text)
        @text = message_text
        @notifier = notifier

        set_colour(:none)
        @notify = false
        @format = 'text'
      end

      def to_hash
        {
            'color'=>colour,
            'message'=>text,
            'notify'=>notify,
            'message_format'=>format
        }
      end

      def set_colour(sym)
        @colour = notifier.colour_map[sym] || 'gray'
      end

      def to_json
        to_hash.to_json
      end
    end

    class InfoMessage < Message
      def initialize(notifier, message_text)
        super(notifier, message_text)
        set_colour(:info)
      end
    end

    class WarningMessage < Message
      def initialize(notifier, message_text)
        super(notifier, message_text)
        @notify=true
        set_colour(:warning)
      end
    end

    class ErrorMessage < Message
      def initialize(notifier, message_text)
        super(notifier, message_text)
        @notify=true
        set_colour(:error)
      end
    end
  end
end