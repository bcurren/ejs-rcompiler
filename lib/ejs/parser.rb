require 'treetop'
require File.expand_path("#{File.dirname(__FILE__)}/grammar")

module Ejs
  class Parser < Treetop::Runtime::CompiledParser
    include ::Ejs::Grammar
  end
end
