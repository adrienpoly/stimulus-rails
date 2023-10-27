module StimulusRails
  class Configuration
    attr_accessor :disable_eslint, :paths, :output_path

    def initialize
      @disable_eslint = false
      @paths = ["app/javascript/controllers"]
      @output_path = "app/javascript/controllers"
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= StimulusRails::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

require "stimulus/version"
require "stimulus/engine"
require 'stimulus/manifest'

