require 'rubygems'
require 'test/unit'
require File.dirname(__FILE__) + '/template_handler_test_mocks'
require File.dirname(__FILE__) + '/../lib/hl7_rails'
#require File.dirname(__FILE__) + '/../init'


#TODO: ruby1.9: pull same testing scheme from Raw once we're on 1.9
class BaseTemplateHandlerTest < Test::Unit::TestCase
  include TemplateHandlerTestMocks
  
  def setup
    @view = ActionView.new
    @handler = HL7Rails::TemplateHandlers::Base.new(@view)
    @controller = @view.controller
  end

  def test_headers_disposition_inline_and_filename
    @controller.hl7_rails :filename=>'xxx.hl7', :inline=>true
#    @handler.hl7_rails_options
    @handler.set_disposition
    assert_equal 'inline;filename=xxx.hl7', @view.headers['Content-Disposition']
  end

  def test_headers_disposition_attachment_and_filename
    @controller.hl7_rails :filename=>'xxx.hl7', :inline=>false
#    @handler.hl7_rails_options
    @handler.set_disposition
    assert_equal 'attachment;filename=xxx.hl7', @view.headers['Content-Disposition']
  end

  def test_headers_disposition_default
#    @handler.hl7_rails_options
    @handler.set_disposition
    assert_equal 'inline', @view.headers['Content-Disposition']
  end

end

