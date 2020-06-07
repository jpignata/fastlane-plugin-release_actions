module Changelog
  # Writer is intended to build on an existing CHANGELOG.md file. It opens a file
  # and inserts new release details start at the third line. The intention is to
  # insert the next release under the header, and directly above the previous release.
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
