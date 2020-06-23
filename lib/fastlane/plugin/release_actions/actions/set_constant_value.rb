module Fastlane
  module Actions
    class SetConstantValueAction < Action
      def self.run(params)
        file = params[:file]
        constant = params[:constant]
        value = params[:value]

        regex_constant_version = /(?<=#{constant})(\s*=\s*["'].*)/
        file_contents = File.read(file)

        unless file_contents.match(regex_constant_version)
          UI.error("#{constant} not present or doesn't have an explicit value in #{file}")
          return
        end

        new_value = " = '#{value}'"

        file_contents = file_contents.gsub(regex_constant_version, new_value)

        File.open(file, "w") { |f| f.puts(file_contents) }
        UI.success("Successfully modified #{constant} to value #{value} in #{file}")
      end

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
