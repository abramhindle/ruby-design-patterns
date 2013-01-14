class CommandFactory
  def initialize(context)
    @context = context
  end
  def create_command(name)
    if (name == "Paste")
      return PasteCommand.new(@context)
    else if (name == "Cut")
      return CutCommand.new(@context)
    else
      throw ("Could Not Construct "+name)
    end
  end
end
class PasteCommand
  def initialize(context)
  end
end
class CutCommand
  def initialize(context)
  end
end
