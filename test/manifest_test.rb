require 'test_helper'

class Stimulus::Manifest::Test < ActiveSupport::TestCase
  test "generate manifest with multiple file types" do
    manifest = Stimulus::Manifest.generate_from(file_fixture('controllers'))

    refute_includes manifest, '/* eslint-disable */'
    assert_includes manifest, '// This file is auto-generated by ./bin/rails stimulus:manifest:update'
    assert_includes manifest, '// Run that command whenever you add a new controller or create them with'
    assert_includes manifest, '// ./bin/rails generate stimulus controllerName'

    # JavaScript controller
    assert_includes manifest, 'import HelloController from "./hello_controller"'
    assert_includes manifest, 'application.register("hello", HelloController)'

    # CoffeeScript controller
    assert_includes manifest, 'import CoffeeController from "./coffee_controller"'
    assert_includes manifest, 'application.register("coffee", CoffeeController)'

    # TypeScript controller
    assert_includes manifest, 'import TypeScriptController from "./type_script_controller"'
    assert_includes manifest, 'application.register("type-script", TypeScriptController)'
  end

  class Stimulus::Manifest::Test::Configuration < ActiveSupport::TestCase
    setup do
      StimulusRails.configure do |config|
        config.disable_eslint = true
      end
    end

    teardown do
      StimulusRails.configuration = nil
    end

    test "disable_eslint" do
      assert StimulusRails.configuration.disable_eslint
      manifest = Stimulus::Manifest.generate_from(file_fixture('controllers'))
      assert_includes manifest, '/* eslint-disable */'
    end
  end
end
