$LOAD_PATH.unshift File.dirname(__FILE__) + "/../lib"
require 'rubygems'
require 'test/unit'
require 'file_sandbox'

class MyFileTest < Test::Unit::TestCase
  include FileSandbox

  def test_read
    in_sandbox do |sandbox|
      sandbox.new :file => 'b/a.txt', :with_contents => 'some stuff'
      
      assert_equal 'some stuff', File.read(sandbox.root + '/b/a.txt')
      assert_equal 'some stuff', sandbox['/b/a.txt'].contents
    end
  end
end
