require 'fastlane/action'

module Fastlane
  module Actions
    class WriteChangelogAction < Action
      def self.run(params)
        changelog = params[:changelog]
        path = params[:path]

        Changelog::Writer.new(changelog, path).write
      end

      def self.description
        'Adds the latest release to the changelog.'
      end

      def self.authors
        ['John Pignata', 'Ivan Artemiev']
      end

      def self.available_options
        []
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
