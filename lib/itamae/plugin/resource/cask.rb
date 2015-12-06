require "itamae/resource/base"

module Itamae
  module Plugin
    module Resource
      class Cask < Itamae::Resource::Base
        BREW_CASK = 'brew-cask'

        define_attribute :action, default: :install
        define_attribute :target, type: String, default_name: true
        define_attribute :options, type: String, default: "--appdir=/Applications"

        def set_current_attributes
          super
          ensure_brew_cask_availability

          result = run_command("#{BREW_CASK} list | grep '#{attributes.target}$'", error: false)
          current.exist = result.exit_status == 0
        end

        def action_install(options)
          unless current.exist
            run_command([BREW_CASK, "install", attributes.target])
          end
        end

        def action_alfred(options)
          run_command([BREW_CASK, "alfred", attributes.target])
        end

        private

        def ensure_brew_cask_availability
          if run_command("#{BREW_CASK} > /dev/null", error: false).exit_status != 0
            raise "`brew cask` command is not available. Please install brew cask."
          end
        end
      end
    end
  end
end
