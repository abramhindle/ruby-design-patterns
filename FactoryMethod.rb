class Printer
  def print_header(header)
  end
  def print_body(body)
  end
  def print_footer(footer)
  end
end
class AsciiPrinter < Printer
end
class AsciiDraftPrinter < AsciiPrinter
end
class PostScriptPrinter < Printer
end
class PostScriptDraftPrinter < PostScriptPrinter
end


class Report
  def get_printer(type)
    throw "Abstract: Please Overload"
  end
  def print_report(type)
    printer = get_printer(type)
    printer.print_header(@header)
    printer.print_body(@body)
    printer.print_footer(@footer)
  end
end
class DraftReport < Report
  def get_printer(type)
    if (type == "ascii")
      return AsciiDraftPrinter.new()
    elsif (type == "postscript")
      return PostScriptDraftPrinter.new()
    end
  end
end
class BasicReport < Report
  def get_printer(type)
    if (type == "ascii")
      return AsciiPrinter.new()
    elsif (type == "postscript")
      return PostScriptPrinter.new()
    end
  end
end
