$LOAD_PATH.unshift File.dirname(__FILE__) + "/../lib"
require 'rubygems'
require 'spec'
require 'file_sandbox_behavior'

describe File do
  include FileSandbox
  
  it 'should read the contents of a file' do
    sandbox.new :file => 'b/a.txt', :with_contents => 'some stuff'
    
    sandbox['/b/a.txt'].contents.should == 'some stuff'
    File.read(sandbox.root + "/b/a.txt").should == 'some stuff'
  end
end
