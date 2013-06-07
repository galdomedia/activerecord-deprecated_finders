require 'helper'

describe 'scope' do
  before do
    @klass = Class.new(ActiveRecord::Base)
  end

  it 'raise exception with a finder hash' do
    lambda{
      @klass.scope :foo, conditions: :foo
    }.must_raise ArgumentError
  end

  it 'supports a finder hash inside a callable' do
    @klass.scope :foo, ->(v) { { conditions: v } }
    assert_deprecated { @klass.foo(:bar) }.where_values.must_equal [:bar]
  end
end
