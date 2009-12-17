require 'action_controller'
require 'action_view'

require 'ruby-hl7'

require 'hl7_rails/action_controller'
require 'hl7_rails/action_view'

require 'hl7_rails/template_handler/compile_support'

require 'hl7_rails/template_handlers/base'

# for now applying to all Controllers
# however, could reduce footprint by letting user mixin (i.e. include) only into controllers that need it
# but does it really matter performance wise to include in a controller that doesn't need it?  doubtful-- depends how much of a hit the before_filter is i guess.. 
#

class ActionController::Base
  include HL7Rails::ActionController
end

class ActionView::Base
  include HL7Rails::ActionView
end



