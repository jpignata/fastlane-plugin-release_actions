require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class ReleaseActionsHelper
      # class methods that you define here become available in your action
      # as `Helper::ReleaseActionsHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the release_actions plugin helper!")
      end
    end
  end
end
