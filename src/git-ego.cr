require "option_parser"
require "yaml"
require "./config"


# git-ego switches out local git-config settings
module GitEgo
  class GitEgo
    @@VERSION = "0.0.2"

    getter config

    def initialize
      @config = Config.new
      @egos = Ego.read_file @config.ego_file
    end


    # Main method.
    def run : NoReturn
      OptionParser.new { |parser|
        parser.banner = <<-BANNER
        usage: git ego <name> [-f <file>]
               git ego -l [-f <file>]
        BANNER

        parser.on("-f <file>", "Use given ego file") do |arg|
          @config.ego_file = File.expand_path arg
        end

        parser.on("-l", "List known egos") do
          @config.workflow = Workflow::List
        end

        parser.unknown_args do |args|
          @config.target = args[0] unless args.empty?
        end
      }.parse

      @egos = YAML.parse(File.read(@config.ego_file)).as_h

      case @config.workflow
      when Workflow::Change then change
      when Workflow::List   then list
      end

      exit 0
    end

    # Change Git settings to those of a targeted ego.
    def change
      abort "Ego not specified" if @config.target.nil?
      abort "Ego #{@config.target} not found" unless @egos.has_key? @config.target

      scope = "--local" # TODO: Maybe handle other scopes?
      props = @egos[@config.target].as_h

      props.each do |prop, val|
        Process.new "git", ["config", scope, prop.as_s, val.as_s]
      end
    end


    # List the egos provided in the Ego file.
    #
    # TODO: Indicate the currently-applicable ego
    def list
      @egos.each_key do |ego|
        puts ego
      end
    end
  end


  GitEgo.new.run
end
