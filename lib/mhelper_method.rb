# frozen_string_literal: true

require_relative "mhelper_method/version"

class Module
  def helper_method(*methods)
    methods.flatten!
    ActionController::Base._mhelper_methods += methods
  end
end

ActiveSupport.on_load(:action_controller_base) do
  class_attribute :__mhelper_methods, default: []
  before_action do
    _mhelper_methods.each do |method|
      self.class.helper_method method
    end
  end
end
