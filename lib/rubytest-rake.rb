require 'rubytest'
require 'rake/tasklib'

module Test

  ##
  # Rake subspace.
  #
  module Rake

    ##
    # Define a test rake task.
    #
    # The `TEST` environment variable can be used to select tests
    # when using this task. Note, this is just a more convenient
    # way than using `RUBYTEST_FILES`.
    #
    class TestTask < ::Rake::TaskLib

      # Glob patterns are used by default to select test scripts.
      DEFAULT_TESTS = [
        'test/**/case_*.rb',
        'test/**/*_case.rb',
        'test/**/test_*.rb',
        'test/**/*_test.rb'
      ]

      # Test run configuration.
      #
      # @return [Config]
      attr :config

      # Initialize new Rake::TestTask instance.
      #
      def initialize(name='test', desc='run tests', &block)
        @name = name || 'test'
        @desc = desc

        @config = Test::Config.new

        @config.files << default_tests if @config.files.empty?
        @config.loadpath << 'lib' if @config.loadpath.empty?

        block.call(@config)

        define_task
      end

      # Define rake task for testing.
      #
      # @return nothing
      def define_task
        desc @desc
        task @name do
          config.mode == 'shell' ? run_shell : run
        end
      end

      # Run tests, via fork is possible, otherwise straight out.
      #
      # @return nothing
      def run
        if Process.respond_to?(:fork)
          fork {
            runner  = Test::Runner.new(config)
            success = runner.run
            exit -1 unless success
          }
          Process.wait
        else
          runner  = Test::Runner.new(config)
          success = runner.run
          exit -1 unless success
        end
      end

      # Run test via shell. (Not Currently Used)
      #
      # Note, the problem with this approach is that before and after 
      # procedures cannot be passed along. In it's current form it
      # also requires that `rubytest-cli` be installed.
      #
      # @return nothing
      def shell_run
        success = ruby('rubytest', *config.to_shellwords)
        exit -1 unless success
      end

      ## Resolve test globs.
      ##
      ## @todo Implementation probably can be simplified.
      ## @return [Array<String>] List of test files.
      #def test_files
      #  files = tests
      #  files = files.map{ |f| Dir[f] }.flatten
      #  files = files.map{ |f| File.directory?(f) ? Dir[File.join(f, '**/*.rb')] : f }
      #  files = files.flatten.uniq
      #  files = files.map{ |f| File.expand_path(f) }
      #  files
      #end

      # Default test globs. For extra convenience will look for list in
      # `ENV['TEST']` first.
      #
      # @return [Array<String>]
      def default_tests
        if ENV['TEST']
          ENV['TEST'].split(/[:;]/)
        else
          DEFAULT_TESTS
        end
      end

    end

  end

end
