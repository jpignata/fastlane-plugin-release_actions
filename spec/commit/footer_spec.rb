require 'spec_helper'
require 'helper/commit/footer'

describe Footer do
  let(:footer) { Footer.new }

  it 'is enumerable' do
    footer['key1'] = 1
    footer['key2'] = 2

    expect(footer.each.to_a).to eq([['key1', 1], ['key2', 2]])
  end

  describe 'key access' do
    KEY = 'key'

    KEYS = Array.new(1 << KEY.length) do |i|
      chars = KEY.each_char.map.with_index do |char, j|
        if i & (1 << j) > 0
          char.upcase
        else
          char
        end
      end

      chars.join
    end

    it 'is case insensitive' do
      footer[KEY] = 'value'

      KEYS.each do |key|
        expect(footer[key]).to eq('value')
      end
    end
  end
end
