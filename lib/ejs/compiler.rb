require File.expand_path("#{File.dirname(__FILE__)}/parser")

module Ejs
  class Compiler
    def compile(template_name, content)
      buffer = []
      template_header(buffer, template_name)
      buffer.push("out.push('#{content}');")
      template_footer(buffer)
            
      buffer.join("\n")
    end
    
    private
    
    def template_header(buffer, template_name)
      buffer.push("#{template_name}.template = function(options) {")
      buffer.push("var p = [];")
      buffer.push("with(options) {")
      
      <<-EOF
      EOF
    end
    
    def template_footer(buffer)
      buffer.push("}")
      buffer.push("return out.join('');")
      buffer.push("}")
    end
  end
end
