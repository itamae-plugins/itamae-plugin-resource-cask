# Itamae::Plugin::Resource::Cask

[Itamae](https://github.com/ryotarai/itamae) resource plugin to manage homebrew cask packages.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-resource-cask'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-resource-cask

## Usage

```ruby
require "itamae/plugin/resource/cask"

# brew cask install google-chrome
cask "google-chrome"

# brew cask alfred link
cask "link" do
  action :alfred
end
```

## Contributing

1. Fork it ( https://github.com/k0kubun/itamae-plugin-resource-cask/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
