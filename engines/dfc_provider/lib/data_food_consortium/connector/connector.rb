# frozen_string_literal: true

# Load the original library first:
require "datafoodconsortium/connector"

# Then our tools for monky-patching:
require_relative "importer"
require_relative "context"

module DataFoodConsortium
  module Connector
    class Connector
      def import(json_string_or_io)
        Importer.new.import(json_string_or_io)
      end
    end
  end
end
