require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Parser" do
  before(:each) do
    @parser = Ejs::Parser.new
  end
  
  it "should parse static content" do
    parsed = parse("<p>Static output</p>")
    parsed.size.should == 1
    parsed[0].node_type.should == 'static_content'
    parsed[0].text_value.should == '<p>Static output</p>'
  end
  
  it "should parse scriplet" do
    parsed = parse("<% console.log('test') %>")
    parsed.size.should == 1
    parsed[0].node_type.should == 'scriplet'
    parsed[0].text_value.should == " console.log('test') "
  end
  
  it "should parse expression" do
    parsed = parse("<%= this.name %>")
    parsed.size.should == 1
    parsed[0].node_type.should == 'expression'
    parsed[0].text_value.should == " this.name "
  end
  
  it "should parse comment" do
    parsed = parse("<%# This is a comment %>")
    parsed.size.should == 1
    parsed[0].node_type.should == 'comment'
    parsed[0].text_value.should == " This is a comment "
  end
  
  it "should escape left and right delimter in script content" do
    parsed = parse("<% console.log('Example: <%% puts 'test' %%>') %>")
    parsed.size.should == 1
    parsed[0].node_type.should == 'scriplet'
    parsed[0].text_value.should == " console.log('Example: <% puts 'test' %>') "
  end
  
  it "should escape elft and right delimeter in staic content" do
    parsed = parse("<%% this is a test %%>")
    parsed.size.should == 1
    parsed[0].node_type.should == 'static_content'
    parsed[0].text_value.should == "<% this is a test %>"
  end
  
  private
  
  def parse(ejs_conent)
    result = @parser.parse(ejs_conent)
    result.should_not be_nil
    result.elements
  end
end
