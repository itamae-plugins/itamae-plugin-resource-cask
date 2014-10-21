module Itamae
  module Plugin
    module Resource
      class Cask < Itamae::Resource::Base
        define_attribute :action, default: :create

        def action_create(options)
        end
      end
    end
  end
end
