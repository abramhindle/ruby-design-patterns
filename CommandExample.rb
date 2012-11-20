require 'singleton'

class Command
    def execute()
    end
    def unexecute()
    end
end

class Buffer
    include Singleton
    @buffer = []
    def initialize()
        @buffer = []
    end
    def insert(n, token)
        @buffer.insert( n, token )
    end
    def string()
        return @buffer.join( " " )
    end
    def remove(n)
    val = @buffer[n]
        @buffer.delete_at(n)
    return val
    end
end

class PasteCommand < Command
    def initialize(n, token)
        @n = n
        @token = token
    end
    def execute()
    Buffer.instance.insert(@n, @token)
    end
    def unexecute()
    Buffer.instance.remove(@n)
    end
end

class RemoveCommand < Command
    @token = nil
    def initialize(n)
        @n = n
    end
    def execute()
    @token = Buffer.instance.remove(@n)
    end
    def unexecute()
    Buffer.instance.insert(@n, @token)
    end
end

def example_driver()
    puts(Buffer.instance.string())
    actions = [
        PasteCommand.new(0,"Hello"),
        PasteCommand.new(1,"World"),
        PasteCommand.new(1,"Beautiful"),
        RemoveCommand.new(2),
        RemoveCommand.new(0),
    ]
    for action in actions
        action.execute()
        puts(Buffer.instance.string())
    end
    revactions = actions.reverse
    for action in revactions
        action.unexecute()
        puts(Buffer.instance.string())
    end
end

example_driver()

class Invoker
    def initialize()
        @undoqueue = []
        @redoqueue = []
    end
    def do(x)
        x.execute()
        @undoqueue << x
        @redoqueue = []
    end
    def undo()
        x = @undoqueue.pop()
        x.unexecute() if x
        @redoqueue << x if x
    end
    def redo()
        x = @redoqueue.pop()
        if (x) 
            x.execute()
            @undoqueue << x
        end
    end
end
class BufferInvoker < Invoker
    def do(x)
        super(x)
        puts(Buffer.instance.string())
    end
    def undo()
        super()
        puts(Buffer.instance.string())
    end
    def redo()
        super()
        puts(Buffer.instance.string())
    end
end

def example_invoker()
    invoker = BufferInvoker.new()
    [
        PasteCommand.new(0,"Snakes"),
        PasteCommand.new(1,"Hiss"),
        PasteCommand.new(1,"Go"),
        RemoveCommand.new(2),
        RemoveCommand.new(0),
    ].each { |x| invoker.do( x ) }
    for i in (1..5)
        invoker.undo()
    end
    for i in (1..5)
        invoker.redo()
    end
end

example_invoker()
