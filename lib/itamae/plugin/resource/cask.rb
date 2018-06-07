require "itamae/resource/base"

module Itamae
  module Plugin
    module Resource
      class Cask < Itamae::Resource::Base
        define_attribute :action, default: :install
        define_attribute :target, type: String, default_name: true
        define_attribute :options, type: [String, Array], default: "--appdir=/Applications"

        def set_current_attributes
          super

          result = run_command("#{brew_cask_list} | grep '#{attributes.target}$'", error: false)
          current.exist = result.exit_status == 0
        end

        def action_install(options)
          unless current.exist
            run_command(["brew", "cask", "install", *Array(attributes.options), attributes.target])
          end
        end

        def action_alfred(options)
          run_command(["brew", "cask", "alfred", *Array(attributes.options), attributes.target])
        end

        private

        # Optimized `brew cask list`
        def brew_cask_list
          "ls -1 $(brew --prefix)/Caskroom"
        end
      end
    end
  end
end
