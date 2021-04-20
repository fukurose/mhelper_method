# frozen_string_literal: true

require_relative "module_helper/version"

class Module
  def helper_method(*methods)
    methods.flatten!
    ActionController::Base._module_helper_methods += methods
  end
end

ActiveSupport.on_load(:action_controller_base) do
  class_attribute :_module_helper_methods, default: []
  before_action do
    _module_helper_methods.each do |method|
      self.class.helper_method method
    end
  end
end
