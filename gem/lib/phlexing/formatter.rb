# frozen_string_literal: true

require "rufo"

module Phlexing
  class Formatter
    def self.format(code)
      Rufo::Formatter.format(code).strip
    rescue Rufo::SyntaxError
      code
    end
  end
end
