class Printer
  def print_header(header)
    puts(header)
  end
  def print_body(body)
    puts(body)
  end
  def print_footer(footer)
    puts(footer)
  end
end
class AsciiPrinter < Printer
end
class AsciiDraftPrinter < AsciiPrinter
  def print_header(header)
  end
  def print_footer(header)
  end
end
class PostScriptPrinter < Printer
end
class PostScriptDraftPrinter < PostScriptPrinter
  def print_header(header)
  end
  def print_footer(header)
  end
end


class Report
  def header()
    "header"
  end
  def body()
    "body"
  end
  def footer()
    "footer"
  end
  def get_printer(type)
    throw "Abstract: Please Overload"
  end
  def print_report(type)
    printer = get_printer(type)
    printer.print_header(header)
    printer.print_body(body)
    printer.print_footer(footer)
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

puts("Draft")
d = DraftReport.new()
d.print_report("ascii")
d.print_report("postscript")
puts("Basic")
b = BasicReport.new()
b.print_report("ascii")
b.print_report("postscript")
