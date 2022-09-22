# frozen_string_literal: true

require "erubi"

module Phlexing
  module Renderer
    class Erb
      include ActionView::Helpers::TagHelper

      def self.render(html)
        new.render(html)
      end

      def render(html)
        @articles = [OpenStruct.new(title: "Article 1"), OpenStruct.new(title: "Article 2")]
        @user = OpenStruct.new(firstname: "John", lastname: "Doe")
        @users = [@user, OpenStruct.new(firstname: "Jane", lastname: "Doe")]

        erb = eval Erubi::Engine.new(html).src # rubocop:disable Security/Eval

        begin
          HtmlPress.press(erb)
        rescue SyntaxError, StandardError => e
          e.message
        end
      end

      def method_missing(name)
        "method_call(:#{name})"
      end

      def respond_to_missing?
        true
      end
    end
  end
end
