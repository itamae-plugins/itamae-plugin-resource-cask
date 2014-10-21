require "itamae/resource/base"

module Itamae
  module Plugin
    module Resource
      class Cask < Itamae::Resource::Base
        define_attribute :action, default: :create
        define_attribute :formula, type: String, default_name: true

        def set_current_attributes
          super
          ensure_brew_cask_availability

          result = run_command("brew cask list | grep '#{attributes.formula}$'", error: false)
          current.exist = result.exit_status == 0
        end

        def action_create(options)
          unless current.exist
            run_command(["brew", "cask", "install", attributes.formula])
          end
        end

        private

        def ensure_brew_cask_availability
          if run_command("brew cask > /dev/null", error: false).exit_status != 0
            raise "`brew cask` command is not available. Please install brew cask."
          end
        end
      end
    end
  end
end
