require File.expand_path('../resource_logstash_config', __FILE__)

class Chef
  class Resource
    class LogstashOutputZabbix < Chef::Resource::LogstashConfig

      def exclude_tags(arg=nil)
        set_or_return(:exclude_tags, arg, :kind_of => [Array])
      end

      def fields(arg=nil)
        set_or_return(:fields, arg, :kind_of => [Array])
      end

      def tags(arg=nil)
        set_or_return(:tags, arg, :kind_of => [Array])
      end

      def port(arg=nil)
        set_or_return(:port, arg, :kind_of => [Fixnum])
      end

      def zabbix_sender(arg=nil)
        set_or_return(:zabbix_sender, arg, :kind_of => [String])
      end

      def type(arg=nil)
        set_or_return(:type, arg, :kind_of => [String])
      end

      def host(arg=nil)
        set_or_return(:host, arg, :kind_of => [String])
      end

    end
  end
end
