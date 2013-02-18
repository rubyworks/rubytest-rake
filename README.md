# Rake for Ruby Test

[Homepage](http://rubyworks.github.com/rubytest-rake) /
[User Guide](http://wiki.github.com/rubyworks/rubytest-rake) /
[Development](http://github.com/rubyworks/rubytest-rake) /
[Issues](http://github.com/rubyworks/rubytest-rake/issues)

[![Build Status](https://secure.travis-ci.org/rubyworks/rubytest-rake.png)](http://travis-ci.org/rubyworks/rubytest-rake)
[![Gem Version](https://badge.fury.io/rb/rubytest-rake.png)](http://badge.fury.io/rb/rubytest-rake)


This gem provides a plug-in for running Ruby Test based test framework
tests via Rake.

Note that this implmentation does not shell-out, so tests are run from the 
same process as Rake. While it probably makes no difference, if you need a
more prestine test environment in which Rake is not present, then use
a different approach to running tests, such as writing a custom runner
and shelling out to it.


## Installation

#### RubyGems

    $ gem install rubytest-rake

#### Bundler

Using Bundler add to your Gemfile:

    gem 'rubytest'
    gem 'rubytest-rake'

Then on the command line: 

    $ bundle install


## Instruction

In your Rakefile add:

    require 'rubytest-rake'

    Test::Rake::TestTask.new do |run|
      run.load_path 'lib'
      run.test_files << 'test/test_*.rb'
    end

The Rake task constructor supports the same interface as `Test.configure`.


## Contributing

If you use Rake and Ruby Test, please consider helping to make the Rake
plugin better!


## Copyrights

(BSD-2-Clause)

Copyright (c) 2012 Rubyworks

See LICENSE.txt for details.

