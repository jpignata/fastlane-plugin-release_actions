$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../../lib/fastlane/plugin/release_actions', __FILE__))

require 'simplecov'

# SimpleCov.minimum_coverage 95
SimpleCov.start

# This module is only used to check the environment is currently a testing env
module SpecHelper
end

require 'fastlane' # to import the Action super class
require 'fastlane/plugin/release_actions' # import the actual plugin

Fastlane.load_actions # load other actions (in case your plugin calls other actions or shared values)

def new_commit(type)
  Commit.new.tap do |commit|
    commit.type = type
  end
end

def new_commits(commits)
  Commits.new.tap do |_commits|
    commits.each { |commit| _commits.push(commit) }
  end
end