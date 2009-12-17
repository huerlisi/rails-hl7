module HL7Rails
  module TemplateHandlers
    class Base < ::ActionView::TemplateHandler
      include ::ActionView::TemplateHandlers::Compilable
      
      def compile(template)
        "_hl7_rails_compile_setup;" +
        "hl7 = HL7::Message.new;" +
        "#{template.source}\n" +
        "hl7.to_s;"
      end
    end
  end
end


