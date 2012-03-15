require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + '/../lib/file_sandbox')

class FileSandboxTest < Test::Unit::TestCase
  include FileSandbox
  
  def test_we_are_in_the_sandbox
    dir = Dir.pwd
    in_sandbox do |sandbox|
      assert_equal sandbox.root, Dir.pwd
    end
    assert_equal dir, Dir.pwd
  end

  def test_sandbox_cleans_up_file
    in_sandbox do |sandbox|
      name = sandbox.root + "/a.txt"

      File.open(name, "w") {|f| f << "something"}

      assert File.exist?(name)
    end
    assert !File.exist?(name)
  end

  def test_file_exist
    in_sandbox do |sandbox|
      assert !sandbox['a.txt'].exists?
      File.open(sandbox.root + "/a.txt", "w") {|f| f << "something"}
      assert sandbox['a.txt'].exist?
    end
  end

  def test_create_file
    in_sandbox do |sandbox|
      assert !sandbox['a.txt'].exists?

      sandbox.new :file => 'a.txt'
      assert sandbox['a.txt'].exist?
      
      sandbox.new :file => 'b', :with_contents => 'some'
      assert_equal 'some', sandbox['b'].contents
      
      sandbox.new :file => 'c', :with_contents => 'thing'
      assert_equal 'thing', sandbox['c'].contents
      
      assert_raises("unexpected keys 'contents'") {
        sandbox.new :file => 'd', :contents => 'crap'
      }
    end
  end
  
  def test_create_file_with_file_dot_contents_equal_syntax
    in_sandbox do |sandbox|
      sandbox['a/b/c'].contents = 'crap'
      assert_equal 'crap', sandbox['a/b/c'].contents
      
      sandbox['foo.bin'].binary_contents = '123\n456'
      assert_equal '123\n456', sandbox['foo.bin'].contents
    end
  end
  
  def test_remove_file
    in_sandbox do |sandbox|
      sandbox.new :file => 'foo'
      sandbox.remove :file => 'foo'
      
      assert !sandbox['foo'].exists?
    end
  end

  def test_create_directory
    in_sandbox do |sandbox|
      sandbox.new :directory => 'foo/bar'
      
      assert File.directory?(sandbox.root + "/foo")
      assert File.directory?(sandbox.root + "/foo/bar")
    end
  end
  
  def test_new_file_returns_file
    in_sandbox do |sandbox|
      assert_equal SandboxFile, sandbox.new(:file => 'foo').class
      assert_equal SandboxFile, sandbox.new(:file => 'foo2', :with_content => 'crap').class
      assert_equal SandboxFile, sandbox.new(:directory => 'foo3').class
    end
  end 
  
  private
  
  def assert_raises(string)
    begin
      yield
    rescue
      assert_equal string, $!.message, "wrong exception thrown"
      return
    end
    fail "expected exception '#{string}'"
  end
end

