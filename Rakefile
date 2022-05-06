# frozen_string_literal: true

require_relative './lib/json_to_sql/log'
require 'net/http'
require 'json'
require 'fileutils'
require 'logger'
require 'date'
require 'rubygems'

GEM_NAME = 'json_to_sql'
GEM_VERSION = Gem::Specification.load("#{GEM_NAME}.gemspec").version

task default: :build

task :build do
  system "gem build #{GEM_NAME}.gemspec"
end

task install: :build do
  system "gem install #{GEM_NAME}-#{GEM_VERSION}.gem"
end

task :uninstall do
  system "gem uninstall #{GEM_NAME} y"
end

task publish: :build do
  system "gem push #{GEM_NAME}-#{GEM_VERSION}.gem"
end

task :clean do
  system 'rm *.gem'
end

namespace :util do
  desc 'Save ./data.json from url'
  task :fetch_json, [:url] do |_t, args|
    logger = Log.new.log
    begin
      response = Net::HTTP.get(URI(args.url))
      coins = JSON.parse(response)
      File.open('data.json', 'w') do |f|
        f.write(JSON.pretty_generate(coins))
      end
      logger.info('Updated data.json')
    rescue StandardError => e
      logger.error(e)
    end
  end
end
