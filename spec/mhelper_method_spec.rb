# frozen_string_literal: true

RSpec.describe MhelperMethod do
  describe "VERSION" do
    it "has a version number" do
      expect(MhelperMethod::VERSION).to eq "0.1.0"
    end
  end

  describe "_mhelper_methods" do
    # Always initialize _mhelper_methods
    before { ActionController::Base._mhelper_methods = [] }

    context "helper_method in module" do
      let(:controller) do
        m1 = Module.new do
          def m1
            "m1"
          end
          helper_method :m1
        end

        Class.new(ActionController::Base) do
          include m1
        end
      end

      it "module helper methods shoud be set" do
        expect(controller._mhelper_methods).to eq %i[m1]
      end
    end

    context "helper_method in module in module" do
      let(:controller) do
        m1 = Module.new do
          def m1
            "m1"
          end
          helper_method :m1
        end

        m2 = Module.new do
          include m1
          def m2
            "m2"
          end
          helper_method :m2
        end

        Class.new(ActionController::Base) do
          include m2
        end
      end

      it "module helper methods shoud be set" do
        expect(controller._mhelper_methods).to eq %i[m1 m2]
      end
    end
  end
end
