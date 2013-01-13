# http://apidock.com/ruby/Module/private_class_method
# http://dalibornasevic.com/posts/9-ruby-singleton-pattern-again
class MySingleton
   # attempt to limit access to the constructor
   private_class_method :new
   # class variable instance
   @@instance = nil
   def self.instance()
      if (@@instance.nil?())
          # self. and MySingleton tend not to work
          @@instance = self.new()
      end
      return @@instance
   end
end


