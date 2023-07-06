# frozen_string_literal: true
require 'json_ruby_logger'

RSpec.describe JsonRubyLogger do
  describe '#logger' do
    it 'returns a logger instance' do
      expect(JsonRubyLogger.logger('TestClass', caller_locations.first)).to be_a(Logger)
    end
  end

  describe '.logger' do
    let(:caller_locations) { [double(path: '/path/to/file.rb', lineno: 10, label: 'block (2 levels) in <top (required)>')] }

    it 'returns a logger instance' do
      expect(JsonRubyLogger.logger('TestClass', caller_locations.first)).to be_a(Logger)
    end

    it 'logs messages in JSON format' do
      logger = JsonRubyLogger.logger('TestClass', caller_locations.first)
      output = StringIO.new
      logger.instance_variable_set(:@logdev, Logger::LogDevice.new(output))

      logger.info('Test message')

      json_output = JSON.parse(output.string)
      expect(json_output['file_name']).to eq('file.rb')
      expect(json_output['lineno']).to eq(10)
      expect(json_output['function_name']).to eq('(required)>')
    end
  end
end
