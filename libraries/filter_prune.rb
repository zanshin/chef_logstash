require File.expand_path('../resource_logstash_config', __FILE__)

class Chef
  class Resource
    class LogstashFilterPrune < Chef::Resource::LogstashConfig

      def remove_tag(arg=nil)
        set_or_return(:remove_tag, arg, :kind_of => [Array])
      end

      def add_tag(arg=nil)
        set_or_return(:add_tag, arg, :kind_of => [Array])
      end

      def blacklist_names(arg=nil)
        set_or_return(:blacklist_names, arg, :kind_of => [Array])
      end

      def tags(arg=nil)
        set_or_return(:tags, arg, :kind_of => [Array])
      end

      def exclude_tags(arg=nil)
        set_or_return(:exclude_tags, arg, :kind_of => [Array])
      end

      def whitelist_names(arg=nil)
        set_or_return(:whitelist_names, arg, :kind_of => [Array])
      end

      def interpolate(arg=nil)
        set_or_return(:interpolate, arg, :kind_of => [TrueClass, FalseClass])
      end

      def add_field(arg=nil)
        set_or_return(:add_field, arg, :kind_of => [Hash])
      end

      def whitelist_values(arg=nil)
        set_or_return(:whitelist_values, arg, :kind_of => [Hash])
      end

      def blacklist_values(arg=nil)
        set_or_return(:blacklist_values, arg, :kind_of => [Hash])
      end

      def type(arg=nil)
        set_or_return(:type, arg, :kind_of => [String])
      end

    end
  end
end
