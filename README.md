# Rake Plugin for Ruby Test

The Rake plugin for running Ruby Test based test frameworks.

## Instruction

### Install

#### RubyGems

    $ gem install rubytest-rake

#### Bundler

Using Bundler ass the Gemfile:

    gem 'rubytest-rake'

Then on the command line: 

    $ bundle install

## Usage

In your Rakefile add:

```ruby
    require 'rubytest-rake'

    Test::Rake::TestTask.new do |run|
      require 'lemon'  # your framework

      run.tests << 'test/test_*.rb'
    end
```

## Copyrights

(BSD-2-Clause)

Copyright (c) 2012 Rubyworks

See LICENSE.txt for details.

