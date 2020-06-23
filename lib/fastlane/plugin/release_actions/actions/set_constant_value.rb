module Fastlane
  module Actions
    class SetConstantValueAction < Action
      def self.run(params)
        file = params[:file]
        constant = params[:constant]
        value = params[:value]
        
        file_contents = File.read(file)

        CONSTANT_VERSION = /(?<=#{constant})(\s*=\s*["'].*)/
  
        if !file_contents.match(CONSTANT_VERSION)
          UI.error("#{constant} not present or doesn't have an explicit value in #{file}")
          return
        end

        new_value = " = '#{value}'"
        
        file_contents = file_contents.gsub(CONSTANT_VERSION, new_value)

        File.open(file, "w") { |file| file.puts file_contents }
        UI.success("Successfully modified #{constant} to value #{value} in #{file}")
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'This action will modify the value of the passed in constant'
      end

      def self.available_options
        [
            FastlaneCore::ConfigItem.new(
                key: :file,
                env_name: 'FILE_PATH',
                description: 'The path of the file you wish to modify',
                optional: false,
                type: String
            ),
            FastlaneCore::ConfigItem.new(
                key: :constant,
                env_name: 'CONSTANT_NAME',
                description: 'The constant you wish to modify',
                optional: false,
                type: String
            ),
            FastlaneCore::ConfigItem.new(
                key: :value,
                env_name: 'CONSTANT_VALUE',
                description: 'The new value to assign to the constant',
                optional: false,
                type: String
            )
        ]
      end

      def self.authors
        ['John Pignata', 'Ivan Artemiev']
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end