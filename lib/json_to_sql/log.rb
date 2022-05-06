# frozen_string_literal: true

require 'logger'

# Logging service
class Log
  def initialize
    @log = create_log
  end

  attr_reader :log

  def create_log
    logger = Logger.new($stdout)
    logger.formatter = proc do |severity, datetime, progname, msg|
      "#{severity} #{datetime} #{progname}: #{msg}\n"
    end
    logger
  end
end
