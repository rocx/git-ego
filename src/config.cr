module GitEgo
  enum Workflow
    Change # Change configurations representing an ego
    List   # List all known egos
  end

  class Config
    property ego_file : String
    property target   : String?
    property workflow : Workflow

    def initialize
      # List of egos
      @ego_file = default_ego_file

      # Ego to switch to
      @target = nil

      # The intended command
      @workflow = Workflow::Change
    end

    private def default_ego_file : String
      raise "HOME not defined" if !ENV.has_key? "HOME"
      return "#{ENV["HOME"]}/.config/git-ego/egos.yml"
    end
  end
end
