require 'ruby-hl7'

Mime::Type.register "application/hl7-v2", :hl7
ActionView::Template.register_template_handler 'hl7', Hl7Rails::TemplateHandlers::Base
