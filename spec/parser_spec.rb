require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Parser" do
  before(:each) do
    @parser = Ejs::Parser.new
  end
  
  it "should create object with template function" do
    result = @parser.parse("")
    result.should_not be_nil
    
    output_array = result.compile("TemplateName", true)
    
    output_array[0].should equal_ignoring_spaces <<-EOF
    TemplateName.template = function(options) {
      var p = [];
        with(options) {
    EOF
    
    output_array[1].should equal_ignoring_spaces <<-EOF
      }
      return out.join('');
    }
    EOF
  end
  
  it "should convert static html to strings in javascript template" do
    result = @parser.parse("<p>Static output</p>")
    result.should_not be_nil
    
    output_array = result.compile("TemplateName", true)
    output_array[1].should equal_ignoring_spaces("p.push('<p>Static output</p>');")
  end
  
  it "should inline code" do
    result = @parser.parse("<% console.log('test') %>")
    result.should_not be_nil
    
    output_array = result.compile("TemplateName", true)
    output_array[1].should equal_ignoring_spaces("console.log('test')")
  end
  
  it "should output javascript value" do
    result = @parser.parse("<%= this.name %>")
    result.should_not be_nil
    
    output_array = result.compile("TemplateName", true)
    output_array[1].should equal_ignoring_spaces("p.push(this.name);")
  end
  
  it "should ignore comments" do
    result = @parser.parse("<%# This is a comment %>")
    result.should_not be_nil
    
    output_array = result.compile("TemplateName", true)
    output_array[1].should equal_ignoring_spaces("/* This is a comment */")
  end
  
  it "should parse large example with newlines" do
    result = @parser.parse <<-EOF
    <ul>
      <%# Loop through each city %>
      <% $.each(cities, function() { %>
      <li><%= this.name %></li>
      <% }) %>
    </ul>
    EOF
    result.should_not be_nil
    
    output = result.compile("TemplateName")
    
    output.should equal_ignoring_spaces <<-EOF
      TemplateName.template = function(options) {
        var p = [];
        with(options) {
          p.push('<ul>');
          /* Loop through each city */
          p.push('');
          $.each(cities, function() {
            p.push('<li>');
            p.push(this.name);
            p.push('</li>');
          })
          p.push('</ul>');
        }
        return out.join('');
      }
    EOF
  end
  
  it "should escape left and right delimeters inside of tag content" do
    result = @parser.parse("<% console.log('Example: <%% puts 'test' %%>') %>")
    result.should_not be_nil, @parser.failure_reason
    
    output_array = result.compile("TemplateName", true)
    output_array[1].should equal_ignoring_spaces("console.log('Example: <% puts 'test' %>')")
  end
  
  it "should escape left and right delimeters outside of tag content" do
    result = @parser.parse("<%% this is a test %%>")
    result.should_not be_nil, @parser.failure_reason
    
    output_array = result.compile("TemplateName", true)
    output_array[1].should equal_ignoring_spaces("p.push('<% this is a test %>');")
  end
  
  it "should escape static content in output javascript"
  it "should html escape output by default"
  # out.push("<ul>\n  \n  ");
  
  it "should add namespaces"
  # or = or || {};
  # or.ui = or.ui || {};
end
