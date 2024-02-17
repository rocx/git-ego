require "yaml"
require "./config"

# TODO: Write documentation for `GitEgo`
module GitEgo
  VERSION = "0.0.1"

  config = Config.new

  config.target = ARGV[0]?

  egos = YAML.parse(File.read(config.ego_file)).as_h

  unless config.target.nil?
    props = egos[config.target].as_h
    props.each do |prop, val|
      Process.new("git", ["config", "--local", prop.as_s, val.as_s])
    end
  else
    abort "Usage: git ego <name>"
  end
end
