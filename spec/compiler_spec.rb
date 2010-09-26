require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Compiler" do
  # before(:each) do
  #   @compiler = Ejs::Compiler.new
  # end
  # 
  # it "should create object with template function" do
  #   output = @compiler.compile("TemplateName", "")
  #   
  #   output_array = output.split("\n")
  #   output_array[0].should == "TemplateName.template = function(options) {"
  #   output_array[1].should == "var p = [];"
  #   output_array[2].should == "with(options) {"
  #   
  #   output_array[-3].should == "}"
  #   output_array[-2].should == "return out.join('');"    
  #   output_array[-1].should == "}"
  # end
  # 
  # it "should convert static html to strings in javascript template" do
  #   output = @compiler.compile("TemplateName", "<p>Static output</p>")
  #   
  #   output_array = output.split("\n")
  # 
  #   output_array[3].should == "out.push('<p>Static output</p>');"
  # end
  # 
  # it "test" do
  #   parser = Ejs::Parser.new
  #   parsed = parser.parse("<b>test</b><% test %><%= more%> code")
  #   
  #   if parsed == nil
  #     puts parser.failure_reason
  #   else
  #     parsed.elements.each do |element|
  #       puts "Element value: #{element.text_value}"
  #       puts "Element type: #{element.content_type}"
  #       puts element.terminal?
  #     end
  #   end
  # end
end
