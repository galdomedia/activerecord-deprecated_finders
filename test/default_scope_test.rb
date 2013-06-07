require 'helper'

describe 'default scope' do
  before do
    Post.create(id: 1, title: 'foo lol')
    Post.create(id: 2, title: 'foo omg')
    Post.create(id: 3)

    @klass = Class.new(Post)
    @klass.table_name = 'posts'
  end

  after do
    Post.delete_all
  end

  it 'raise exception with a finder hash' do
    lambda{
      @klass.default_scope conditions: { id: 1 }
    }.must_raise ArgumentError
  end

  it 'works with a block that returns a hash' do
    @klass.default_scope { { conditions: { id: 1 } } }
    assert_deprecated { @klass.all.to_a }.map(&:id).must_equal [1]
  end
end
