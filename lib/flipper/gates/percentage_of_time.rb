module Flipper
  module Gates
    class PercentageOfTime < Gate
      # Internal: The name of the gate. Used for instrumentation, etc.
      def name
        :percentage_of_time
      end

      # Internal: Name converted to value safe for adapter.
      def key
        :percentage_of_time
      end

      def data_type
        :integer
      end

      def description(value)
        if enabled?(value)
          "#{value}% of the time"
        else
          'disabled'
        end
      end

      def enabled?(value)
        Typecast.to_integer(value) > 0
      end

      # Internal: Checks if the gate is open for a thing.
      #
      # Returns true if gate open for thing, false if not.
      def open?(thing, value, options = {})
        percentage = Typecast.to_integer(value)
        rand < (percentage / 100.0)
      end

      def protects?(thing)
        thing.is_a?(Flipper::Types::PercentageOfTime)
      end
    end
  end
end