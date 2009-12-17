require 'rubygems'
require 'action_controller'
require 'action_controller/test_process'
require 'action_view'

require 'test/unit'
require File.dirname(__FILE__) + '/../lib/hl7_rails'


class ActionControllerTest < Test::Unit::TestCase
  class HL7RailsController < ActionController::Base
    hl7_rails :inline=>true

    def test
      hl7_rails :inline=>false
    end
  end

  def test_inheritable_options
    assert_equal({}, HL7RailsController.read_inheritable_attribute(:hl7))
    assert_equal({:inline=>true}, HL7RailsController.read_inheritable_attribute(:hl7_rails))
  end

  def test_computed_options
    controller = HL7RailsController.new
    test_process(controller)
    assert_equal({:inline=>false, :hl7=>{}}, controller.send(:compute_hl7_rails_options))
  end

  # Controller with default false inline
  class HL7RailsControllerWithFalseInline < ActionController::Base
    hl7_rails :inline=>false, :hl7=>{:test_option1 => :one}

    def test
      hl7_rails :hl7=>{:test_option2  => :two}
    end
  end

  def test_default_false_inline_should_not_be_overrided_automatically
    assert_equal({:inline=>false}, HL7RailsControllerWithFalseInline.read_inheritable_attribute(:hl7_rails))

    controller = HL7RailsControllerWithFalseInline.new
    test_process(controller)
    assert_equal({:inline=>false, :hl7=>{:test_option1 => :one, :test_option2 => :two}}, controller.send(:compute_hl7_rails_options))
  end

  # Controller without default inline
  class HL7RailsControllerWithoutInline < ActionController::Base
    hl7_rails :hl7=>{:test_option1 => :one}

    def test
      hl7_rails :hl7=>{:test_option2  => :two}
    end
  end

  def test_inline_should_be_a_true_by_default
    assert_equal({:inline=>true}, HL7RailsControllerWithoutInline.read_inheritable_attribute(:hl7_rails))

    controller = HL7RailsControllerWithoutInline.new
    test_process(controller)
    assert_equal({:inline=>true, :hl7=>{:test_option1 => :one, :test_option2 => :two}}, controller.send(:compute_hl7_rails_options))
  end
  
protected
  def test_process(controller, action = "test")
    request = ActionController::TestRequest.new
    request.action = action
    controller.process(request, ActionController::TestResponse.new)
  end

end

