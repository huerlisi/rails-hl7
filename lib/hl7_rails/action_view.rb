module HL7Rails
  module ActionView

  private
    def _hl7_rails_compile_setup(dsl_setup = false)
      compile_support = HL7Rails::TemplateHandler::CompileSupport.new(controller)
      @hl7_rails_options = compile_support.options
    end

  end
end

