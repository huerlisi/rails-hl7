module HL7Rails
  module ActionController

    DEFAULT_HL7_RAILS_OPTIONS = {:inline=>true}
      
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def hl7_rails(options)
        hl7_options, hl7_rails_options = breakdown_options options
        write_inheritable_hash(:hl7, hl7_options)
        write_inheritable_hash(:hl7_rails, DEFAULT_HL7_RAILS_OPTIONS.dup.merge(hl7_rails_options))
      end
    
    private
      def breakdown_options(options)
        hl7_rails_options = options.dup
        hl7_options = (hl7_rails_options.delete(:hl7) || {}).dup
        [hl7_options, hl7_rails_options]
      end
    end

    def hl7_rails(options)
      @hl7_rails_options ||= {}
      @hl7_rails_options.merge! options
    end


  private
    def compute_hl7_rails_options
      @hl7_rails_options ||= DEFAULT_HL7_RAILS_OPTIONS.dup
      @hl7_rails_options[:hl7] ||= {}
      @hl7_rails_options[:hl7].merge!(self.class.read_inheritable_attribute(:hl7) || {}) {|k,o,n| o}
      @hl7_rails_options.merge!(self.class.read_inheritable_attribute(:hl7_rails) || {}) {|k,o,n| o}
      @hl7_rails_options
    end
  end
end
