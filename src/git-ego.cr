require "yaml"

# TODO: Write documentation for `GitEgo`
module GitEgo
  VERSION = "0.0.1"

  struct Configuration
    property ego_file = "#{ENV["HOME"]}/.config/git-ego/egos.yml"
    property target : String? = nil
  end

  CONFIG = Configuration.new

  CONFIG.target = ARGV[0]?

  EGOS = YAML.parse(File.read(CONFIG.ego_file)).as_h

  unless CONFIG.target.nil?
    props = EGOS[CONFIG.target].as_h
    props.each do |prop, val|
      Process.new("git", ["config", "--local", prop.as_s, val.as_s])
    end
  else
    STDERR.puts "Usage: git ego <name>"
    exit 1
  end
end
