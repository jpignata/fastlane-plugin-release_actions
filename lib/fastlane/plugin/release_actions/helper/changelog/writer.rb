module Changelog
  class Writer
    def initialize(document, file)
      @file = file
      @lines = File.open(file).readlines
      @lines.insert(2, document.nodes).flatten
    end

    def write
      File.open(file, 'w') do |f|
        f.print(lines.join)
      end
    end

    private

    attr_reader :lines, :file
  end
end
