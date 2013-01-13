class NamedSizedItem
    @name = nil
    @size = 0
    def initialize(name)
        @name = name
    end
    def name()
        return @name
    end
    def size()
        return @size
    end
end

class NamedFile < NamedSizedItem
    def initialize(name)
        @name = name
        @size = 1
    end
end

class NamedFolder < NamedSizedItem
    @files = []
    def initialize(name)
        @name = name
        @files = []
    end
    def addFile(file)
        @files << file
    end
    def size()
        return @files.inject(0) { |res,elm| res + elm.size() }
    end
end

file1 = NamedFile.new("readme")
file2 = NamedFile.new("license")
file3 = NamedFile.new("a.out")
subFolder1 = NamedFolder.new("Sub1");
subFolder2 = NamedFolder.new("Sub2");
subFolder3 = NamedFolder.new("Sub3");
subFolder1.addFile(file1)
subFolder2.addFile(file2)
subFolder3.addFile(file3)
subFolder2.addFile(subFolder1)
subFolder3.addFile(subFolder2)
puts(subFolder3.size())
