require "bundler/gem_tasks"
Dir["tasks/**/*.task"].each { |task| load task }

task :default => :spec
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec