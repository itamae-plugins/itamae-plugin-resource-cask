module MItamae
  module Plugin
    module ResourceExecutor
      class Cask < MItamae::ResourceExecutor::Base
        def apply
          ensure_brew_cask_availability

          if !current.exist && desired.exist
            run_command(["brew", "cask", "install", *Array(desired.options), desired.target])
          end

          if desired.alfred_linked
            run_command(["brew", "cask", "alfred", *Array(desired.options), desired.target])
          end
        end

        private

        def set_current_attributes(current, action)
          case action
          when :install
            result = run_command("#{brew_cask_list} | grep '#{attributes.target}$'", error: false)
            current.exist = (result.exit_status == 0)
          end
        end

        def set_desired_attributes(desired, action)
          case action
          when :install
            desired.exist = true
          when :alfred
            desired.alfred_linked = true
          end
        end

        # Optimized `brew cask list`
        def brew_cask_list
          "ls -1 /opt/homebrew-cask/Caskroom/"
        end

        def ensure_brew_cask_availability
          if run_command("test -d $(brew --prefix)/Library/Taps/caskroom/homebrew-cask", error: false).exit_status != 0
            raise "`brew cask` command is not available. Please install brew cask."
          end
        end
      end
    end
  end
end
