$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'ejs-rcompiler'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|

end

Spec::Matchers.define :equal_ignoring_spaces do |expected|
  match do |actual|
    clean_spaces(actual) == clean_spaces(expected)
  end
  
  def clean_spaces(text)
    text = "" if text.nil?
    text.
      gsub(/\s+/, " ").
      strip.
      gsub(/' /, "'").
      gsub(/ '/, "'")
  end
end