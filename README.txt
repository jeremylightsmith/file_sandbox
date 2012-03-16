= Project: File Sandbox v0.4

== Description

File sandbox creates a space for your tests to safely hit the file system. It also makes it easier for them to do so.  By cleaning up after them.

== Usage

in rspec :

  require 'file_sandbox_behavior'

  describe File do
    include FileSandbox

    it 'should read the contents of a file' do
      sandbox.new :file => 'b/a.txt', :with_contents => 'some stuff'

      sandbox['/b/a.txt'].contents.should == 'some stuff'
      File.read(sandbox.root + "/b/a.txt").should == 'some stuff'
    end
  end

in test unit :

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


== Contact

Author::     Jeremy Stell-Smith
Email::      jeremystellsmith@gmail.com
License::    LGPL License

== Home Page

http://onemanswalk.com
