# frozen_string_literal: true

require 'singleton'
require 'slop'

# Service to parse options from command line
class ArgParser
  include Singleton

  def initialize
    @opts = Slop.parse(help: true, ignore_case: true) do |o|
      o.array '-e', '--except', 'Keys to exclude', delimiter: ','
      o.string '-f', '--file', 'JSON file path', required: true
      o.string '-t', '--table', 'Database Table', required: true
      o.string '-u', '--uri', 'SQL connection URI', required: true
      o.boolean '-j', '--json', 'Create JSON file from SQL table', required: false
      o.on '-h', '--help', 'Displays this message' do
        puts o
        exit
      end
    end
  end

  attr_reader :opts
end
