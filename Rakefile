require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ejs-rcompiler"
    gem.summary = %Q{Ejs to Javascript compiler written in Ruby. This allows you to define HTML heavy Javascript components in EJS and compile them down to Javascript functions for later use.}
    gem.description = %Q{Ejs to Javascript compiler.}
    gem.email = "ben@outright.com"
    gem.homepage = "http://github.com/bcurren/ejs-rcompiler"
    gem.authors = ["Ben Curren"]
    gem.add_dependency "treetop", ">= 1.4.0"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ejs-rcompiler #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

PARSER_FILE="lib/ejs/grammar.rb"
GRAMMAR_FILE="lib/ejs/grammar.treetop"

namespace :treetop do
  desc "Generate parser from treetop grammar."
  task :generate => PARSER_FILE
end

file PARSER_FILE => GRAMMAR_FILE do |t|
  require 'treetop'
  compiler = Treetop::Compiler::GrammarCompiler.new
  compiler.compile(t.prerequisites[0], t.name)
end
