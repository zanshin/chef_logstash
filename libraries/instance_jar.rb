require 'date'
require 'net/http'
require 'uri'
require 'chef/resources'
require File.expand_path('../helpers', __FILE__)

class Logstash
  class Instance
    class Jar

      include Helpers::Logstash

      def initialize(new_resource, run_context=nil)
        @new_resource = new_resource
        @run_context = run_context
      end

      def install
        fetch_logstash_jar unless jar_was_modified_since?
      end

      def uninstall
        remove_logstash_jar
      end

      private

      def jar_path
        logstash_jar_with_path(@new_resource.dst_dir, @new_resource.version)
      end

      def jar_was_modified_since?
        if ::File.exists?(jar_path)
          uri = URI.parse(@new_resource.url)
          file_mtime = ::Date.parse(::File.mtime(jar_path).to_s)

          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true if uri.scheme == 'https'
          headers = { 'If-Modified-Since' => file_mtime.httpdate }
          response = http.get(uri.request_uri, headers)

          response == '304' ? false : true
        end
      end

      def fetch_logstash_jar
        r = Chef::Resource::RemoteFile.new("logstash_#{ @new_resource.version }", @run_context)
        r.path     jar_path
        r.checksum @new_resource.checksum
        r.source   @new_resource.url
        r.owner    'root'
        r.group    'root'
        r.mode     00644
        r.run_action(:create)
      end

      def remove_logstash_jar
        f = Chef::Resource::File.new(jar_path, @run_context)
        f.run_action(:delete)
      end

    end
  end
end