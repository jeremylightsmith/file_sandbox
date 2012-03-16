require 'rake/clean'
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'hoe'

$LOAD_PATH.unshift File.dirname(__FILE__) + "/lib"
require 'file_sandbox'

desc "Default Task"
task :default => [:clean, :test]

desc "Run all tests"
task :test => [:unit, :spec]

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./examples/*.rb"
end

Rake::TestTask.new(:unit) do |t|
  t.test_files = FileList['test/**/*test.rb']
  t.verbose = false
end

Hoe.new('file_sandbox', FileSandbox::VERSION) do |p|
  p.rubyforge_name = 'filesandbox'
  p.summary = p.description = p.paragraphs_of('README.txt', 2).first
  p.url = p.paragraphs_of('README.txt', -1).first.strip
  p.author = 'Jeremy Stell-Smith'
  p.email = 'jeremystellsmith@gmail.com'
  p.changes = p.paragraphs_of('CHANGES.txt', 0..1).join("\n\n")
end
