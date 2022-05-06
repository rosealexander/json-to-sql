# frozen_string_literal: true

require_relative 'json_to_sql/arg_parser'
require_relative 'json_to_sql/log'
require 'net/http'
require 'sequel'
require 'json'
require 'pg'
require 'async'
require 'date'

# Service to insert key: val from .json into SQL table where Column name = key
module JSONtoSQL
  PARSER = ArgParser.instance

  def fetch(path)
    if path =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]
      JSON.parse(Net::HTTP.get(URI(path)))
    else
      JSON.parse(File.read(path))
    end
  end

  def insert
    Sequel.connect(PARSER.opts[:uri]) do |db|
      db.extension :async_thread_pool
      dataset = db[PARSER.opts[:table].to_sym]
      Async do |task|
        fetch(PARSER.opts[:file]).each do |elem|
          task.async do
            key = dataset.async.insert(elem.except(*PARSER.opts[:except]))
            print "INSERTING #{key}\r"
            $stdout.flush
          end
        end
      end
    end
  end

  def save
    d = DateTime.now
    filename = "#{PARSER.opts[:table]}_#{d.strftime('%y%m%d_%H%M%S')}.json"
    File.open(filename, 'w') do |f|
      Sequel.connect(PARSER.opts[:uri]) do |db|
        dataset = db.from(PARSER.opts[:table].to_sym)
        first = true
        dataset.each do |row|
          print "WRITING #{filename}\r"
          $stdout.flush
          str = "\n  #{JSON.pretty_generate(row, object_nl: "\n  ")}"
          if first
            first = false
            f.write("[#{str}")
          else
            f.write(",#{str}")
          end
        end
      end
      f.write("\n]")
    end
  end

  def run
    PARSER.opts[:json] ? save : insert
  end
end

if __FILE__ == $PROGRAM_NAME
  include JSONtoSQL
  log = Log.new.log
  log.info('🚀 start')
  begin
    JSONtoSQL.run
  rescue StandardError => e
    log.error(e)
  ensure
    log.info('◼ exit')
  end
end
