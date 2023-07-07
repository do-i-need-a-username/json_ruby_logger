# frozen_string_literal: true
require 'logger'
require 'json'
require 'time'

require_relative "json_ruby_logger/version"

module JsonRubyLogger
  class Error < StandardError; end
  # Your code goes here...

  # This is the magical bit that gets mixed into your classes
  def logger
    # caller_locations returns an array of Thread::Backtrace::Location
    @logger ||= JsonRubyLogger.logger(self.class.name, caller_locations.first)
  end

  # Global, memoized, lazy initialised instance of a logger
  def self.logger(calling_class, caller_info)
    logger = Logger.new(STDOUT)

    logger.formatter = proc do |severity, datetime, progname, msg|
      date_format = datetime.iso8601
      JSON.dump(
        date: date_format,
        file_name: caller_info.path.split('/').last,
        calling_class: calling_class,
        function_name: caller_info.label.split(' ').last,
        lineno: caller_info.lineno,
        severity: severity,
        pid: Process.pid,
        message: msg
      ) + "\n"
    end

    logger.level = ENV.fetch('LOG_LEVEL', 'INFO').upcase
    logger
  end
end
