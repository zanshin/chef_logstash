require 'chef/provider'
require File.expand_path('../helpers', __FILE__)

dir = File.dirname(File.absolute_path(__FILE__))
::Dir.glob(dir + 'instance_*') { |f| require f }

class Chef
  class Provider
    class LogstashInstance < Chef::Provider

      def initialize(new_resource, run_context=nil)
        super
      end

      def whyrun_supported?
        false
      end

      def load_current_resource
      end

      def action_create
        instance(new_resource.install_type, 'install')
        instance(new_resource.service_type, 'create')

        new_resource.updated_by_last_action(true)
      end

      def action_destroy
        instance(new_resource.install_type, 'disable')
        instance(new_resource.service_type, 'uninstall')

        new_resource.updated_by_last_action(true)
      end

      def action_enable
        instance(new_resource.service_type, 'enable')

        new_resource.updated_by_last_action(true)
      end

      private

      def create_user
        g = Chef::Resource::Group.new(new_resource.group, run_context)
        g.run_action(:create)
      end

      def create_group
        u = Chef::Resource::User.new(new_resource.user, run_context)
        u.gid new_resource.group
        u.run_action(:create)
      end

      def instance(type, action)
        i = instance_sub_class(type).new
        i.send(action)
      end

      def instance_sub_class(type)
        klass = "Logstash::Instance::#{ type.capitalize }"

        klass.split('::').reduce(Object) {|kls, t| kls.const_get(t) }
      end

    end
  end
end