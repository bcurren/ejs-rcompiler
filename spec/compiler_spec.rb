require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'tempfile'
require 'fileutils'

describe "Compiler" do
  before(:each) do
    @compiler = Ejs::Compiler.new
  end
  
  it "should js_source_from_string function header and footer" do
    compiled = @compiler.js_source_from_string("TemplateName", "", true)
    
    compiled[0].should == "window.TemplateName = window.TemplateName || {};"
    compiled[1].should == "TemplateName.render = function(options) {"
    compiled[2].should == "  var p = [];"
    compiled[3].should == "  with(options) {"
    
    compiled[-3].should == "  }"
    compiled[-2].should == "  return p.join('');"
    compiled[-1].should == "}"
  end
  
  it "should add namespace declaration" do
    compiled = @compiler.js_source_from_string("my.namespace.MyClass", "", true)
    compiled[0].should == "window.my = window.my || {};"
    compiled[1].should == "window.my.namespace = window.my.namespace || {};"
    compiled[2].should == "window.my.namespace.MyClass = window.my.namespace.MyClass || {};"
    compiled[3].should == "my.namespace.MyClass.render = function(options) {"
  end
  
  it "should js_source_from_string static content" do
    compiled = @compiler.js_source_from_string("TemplateName", "<p>Static output</p>", true)
    compiled[4].should == "    p.push('<p>Static output</p>');"
  end
  
  it "should escape static content" do
    compiled = @compiler.js_source_from_string("TemplateName", "\"\'\n\t", true)
    compiled[4].should == "    p.push('\\\"\\\'\\n\\t');"
  end
  
  it "should js_source_from_string scriplet" do
    compiled = @compiler.js_source_from_string("TemplateName", "<% console.log('test') %>", true)
    compiled[4].should == "    console.log('test')"
  end
  
  it "should js_source_from_string expression" do
    compiled = @compiler.js_source_from_string("TemplateName", "<%= this.name %>", true)
    compiled[4].should == "    p.push(this.name);"
  end
  
  it "should js_source_from_string comments" do
    compiled = @compiler.js_source_from_string("TemplateName", "<%# This is a comment %>", true)
    compiled[4].should == "    /* This is a comment */"
  end
  
  it "should raise exception when syntax is invalid" do
    lambda{ @compiler.js_source_from_string("Name", "<%= this.name %> %>") }.should raise_error(::Ejs::ParseError)
  end
  
  it "should compile a source file to a target file" do
    fixtures = "#{File.dirname(__FILE__)}/fixtures"
    target_file = "/tmp/Cities.js"
    expected_target_file = "#{fixtures}/Cities.js"
    
    FileUtils.rm(target_file) if File.exist?(target_file)
    
    @compiler.compile("#{fixtures}/Cities.ejs", "or.ui", target_file)
    File.open(target_file).read.should == File.open(expected_target_file).read
  end
end
