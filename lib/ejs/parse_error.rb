module Ejs
  class ParseError < StandardError
    attr_reader :failure_reason, :failure_line, :failure_column
    def initialize(failure_reason, failure_line, failure_column)
      @failure_reason = failure_reason
      @failure_line = failure_line
      @failure_column = failure_column
      super(@failure_reason)
    end
  end
end
