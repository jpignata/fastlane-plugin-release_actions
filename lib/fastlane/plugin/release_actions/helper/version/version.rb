require 'helper/version/acceptor'

class Version
  include Comparable

  attr_reader :segments, :prerelease, :build

  def initialize(version)
    unless Acceptor.new(version).valid?
      raise ArgumentError.new("Invalid version: #{version}")
    end

    parts = version.split(/[-\+]/)

    @segments = parts[0].split('.').map(&:to_i)
    @prerelease = parts[1] if version.include?('-')
    @build = parts[-1] if version.include?('+')

    @segments.push(0) until @segments.size == 3
  end

  def bump_major
    bump(0)
  end

  def bump_minor
    bump(1)
  end

  def bump_patch
    bump(2)
  end

  def bump_prerelease
    if !prerelease?
      raise ArgumentError.new('No prerelease present to bump')
    elsif !prerelease[-1].between?("0", "9")
      raise ArgumentError.new('prerelease does not end with an integer')
    end

    integer = @prerelease.slice(/\d+$/)
    next_prerelease = @prerelease.delete_suffix(integer) + integer.next

    new(segments, next_prerelease)
  end

  def prerelease?
    !prerelease.nil?
  end

  def to_s
    version
  end

  def inspect
    "#<Version: '#{version}'>"
  end

  def ==(other)
    version == other.version
  end

  def <=>(other)
    if segments != other.segments
      return segments <=> other.segments
    end

    if prerelease.nil? && other.prerelease.nil?
      return 0
    elsif prerelease.nil? && !other.prerelease.nil?
      return 1
    elsif !prerelease.nil? && other.prerelease.nil?
      return -1
    end

    mine = prerelease.split('.')
    theirs = other.prerelease.split('.')

    [prerelease, other.prerelease].map(&:size).max.times do |i|
      next if mine[i] == theirs[i]

      if mine[i].nil?
        return -1
      elsif theirs[i].nil?
        return 1
      elsif numeric?(mine[i]) && numeric?(theirs[i])
        return mine[i].to_i <=> theirs[i].to_i
      else
        return mine[i] <=> theirs[i]
      end
    end

    return 0
  end

  protected

  attr_writer :segments, :prerelease, :build

  def version
    version = segments.join('.')
    version = [version, prerelease].compact.join('-')

    [version, build].compact.join('+')
  end

  private

  def bump(segment)
    next_segments = segments.dup.tap do |segments|
      segments[segment] += 1
    end
    
    return new(next_segments, prerelease)
  end

  def new(segments, prerelease)
    self.class.allocate.tap do |version|
      version.segments = segments
      version.prerelease = prerelease
    end
  end

  def numeric?(character)
    true if Float(character)
  rescue ArgumentError, TypeError
    false
  end
end