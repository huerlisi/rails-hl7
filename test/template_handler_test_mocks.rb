require 'rubygems'
require File.dirname(__FILE__) + '/../lib/hl7_rails'

module TemplateHandlerTestMocks

  class Template
    attr_reader :source, :locals, :filename

    def initialize(source, locals={})
      @source = source
      @locals = locals
      @filename = "blah.hl7"
    end
  end


  class Response
    def initialize
      @headers = {}
    end

    def headers
      @headers
    end

    def content_type=(value)
    end
  end

  class Request
    def env
      {}
    end
  end

  class ActionController

    include HL7Rails::ActionController

    def response
      @response ||= Response.new
    end

    def request
      @request ||= Request.new
    end

    def headers
      response.headers
    end
  end
    
  class ActionView
    def controller
      @controller ||= ActionController.new
    end

    def response
      controller.response
    end

    def request
      controller.request
    end

    def headers
      controller.headers
    end

    def hl7_rails_options
      controller.get_instance_variable(:@hl7_rails_options)
    end
  end


end

