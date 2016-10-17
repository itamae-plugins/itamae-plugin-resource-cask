module Itamae
  module Plugin
    module Resource
      class Cask < Itamae::Resource::Base
        define_attribute :action, default: :install
        define_attribute :target, type: String, default_name: true
        define_attribute :options, type: [String, Array], default: "--appdir=/Applications"

        self.available_actions = [:install, :alfred]
      end
    end
  end
end
