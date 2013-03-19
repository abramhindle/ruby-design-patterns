#please excuse the CamelCase

class Move
  def forward()
    return false
  end
  def backward()
    return false
  end
  def up()
    return false
  end
  def down()
    return false
  end
  def downBackward()
    return false
  end
  def downForward()
    return false
  end
  def upBackward()
    return false
  end
  def upForward()
    return false
  end
end


class Up < Move
  def up()
    return true
  end
end

class Down < Move
  def down()
    return true
  end
end

class Forward < Move
  def forward()
    return true
  end
end

class Back < Move
  def backward()
    return true
  end
end

class Backward < Back

end

class DownBackward < Move
  def downBackward()
    return true
  end
end

class DownForward < Move
  def downForward()
    return true
  end
end

class UpBack < Move
  def upBackward()
    return true
  end
end
class UpBackward < UpBack
end

class UpForward < Move
  def upForward()
    return true
  end
end

class Action
  def kick()
    return false
  end
  def punch()
    return false
  end
end

class Kick < Action
  def kick()
    return true
  end
end

class Punch < Action
  def punch()
    return true
  end
end 

class None < Move
end

class FireballMoveConditional
  def initialize()
    @state = :none
  end
  def say()
    return "HaDoKen!"
  end
  # this example has a state value as a guard
  # but if I mess up the conditional then all 
  # hell breaks loose
  def nextState( context, move, action )
    if    (@state == :none && move.down()) then
      @state = :ha 
    elsif (@state == :ha && move.down()) then
      @state = :ha
    elsif (@state == :ha && move.downForward()) then
      @state = :do
    elsif (@state == :do && move.forward() && action.punch()) then
      # the body of the state machine is put into 
      # these conditional blocks
      context.execute(FireballMove.new())
      @state = :none
    else
      # the general default behaviour is here
      # but sometimes different states have default 
      # behaviour too
      @state = :none
    end
    return self
  end
end

class MockContext
  def execute(v)
    puts(v)
  end
end



class FireballMove
  def say()
    return "HaDoKen!"
  end
  def nextState( context, move, action )
    if (move.down()) then
      return FireballHa.new()
    end
    return FireballMove.new()
  end
end

class FireballHa
  def nextState( context, move, action )
    if (move.downForward()) then
      return FireballDo.new()
    elsif (move.down()) then
      return FireballHa.new()
    end
    return FireballMove.new()
  end
end

class FireballDo
  def nextState( context, move, action )
    if (move.forward() && action.punch()) then
      context.execute(FireballMove.new())
    end
    return FireballMove.new()
  end
end


class DragonUppercutMove
  def say()
    return "ShoRyuKen!"
  end
  def nextState( context, move, action )
    if (move.forward()) then
      return DragonUppercutSho.new()
    end
    return DragonUppercutMove.new()
  end
end

class DragonUppercutSho
  def nextState( context, move, action )
    if (move.downBackward()) then
      return DragonUppercutRyu.new()
    end
    return DragonUppercutMove.new()
  end
end

class DragonUppercutRyu
  def nextState( context, move, action )
    if (move.forward() && action.punch()) then
      context.execute(DragonUppercutMove.new())
    end
    return DragonUppercutMove.new()
  end
end

class WhirlwindKickMove
  def say()
    return "TaTsunaki!"
  end
  def nextState( context, move, action )
    if (move.up()) then
      return WhirlwindKickTa.new()
    end
    return WhirlwindKickMove.new()
  end
end

class WhirlwindKickTa
  def nextState( context, move, action )
    if (move.down()) then
      return WhirlwindKickTsun.new()
    end
    return WhirlwindKickMove.new()
  end
end

class WhirlwindKickTsun
  def nextState( context, move, action )
    if (move.downBackward()) then
      return WhirlwindKickAki.new()
    end
    return WhirlwindKickMove.new()
  end
end
class WhirlwindKickAki
  def nextState( context, move, action )
    if (move.backward() && action.kick()) then
      context.execute(WhirlwindKickMove.new())
    end
    return WhirlwindKickMove.new()
  end
end




class RyuPlayer
  def initialize()
    @moves = [WhirlwindKickMove.new(), FireballMove.new(), DragonUppercutMove.new()]
    @todo = []
  end
  def execute( move )
    @todo = [ move ]
  end
  def move( move, action )
    @todo = []
    @moves = @moves.map {|specialMove| specialMove.nextState( self, move, action ) }
    # @moves.each {|x| puts("\t" + x.class.name) }
    executeMove()
  end
  def executeMove()
    if (@todo.length > 0)
      puts(@todo[0].say())
    end
  end
end


class RyuApp 

  def trySomeMoves()
    player = RyuPlayer.new()
    puts("# walking")
    player.move( Forward.new(), Action.new() )
    player.move( Forward.new(), Action.new() )
    puts("# start fireball")
    player.move( Down.new(), Action.new() )
    player.move( DownForward.new(), Action.new() )
    player.move( Forward.new(), Punch.new() ) # fireball
    puts("# start fireball")
    player.move( Down.new(), Action.new() )
    player.move( DownForward.new(), Action.new() )
    player.move( Forward.new(), Punch.new() ) # fireball
    puts("# start fireball")
    player.move( Down.new(), Action.new() )
    player.move( DownForward.new(), Action.new() )
    player.move( Forward.new(), Punch.new() ) # fireball
    puts("# crouching")
    player.move( Down.new(), Action.new() )
    player.move( Down.new(), Action.new() )
    player.move( Down.new(), Action.new() )
    puts("# starting fireball")
    player.move( Down.new(), Action.new() )
    player.move( DownForward.new(), Action.new() )
    player.move( Forward.new(), Punch.new() ) #fireball
    puts("# converting to dragon uppercut")
    player.move( DownBackward.new(), Action.new() )
    player.move( Forward.new(), Punch.new() ) #DragonUppercut
    puts("# charging whirlwind kick")
    player.move( Up.new(), Action.new() )
    player.move( Down.new(), Action.new() )
    player.move( DownBackward.new(), Action.new() )
    player.move( Backward.new(), Kick.new() ) #whirlwind
    player.move( Forward.new(), Punch.new() )  
  end


  def genKeymap() 
    keymap = {
      "\e[C"=>     [ Forward.new(),      Action.new()],
      "\e[D"=>     [ Backward.new(),     Action.new()],
      "\e[B"=>     [ Down.new(),         Action.new()],
      "\e[A"=>     [ Up.new(),           Action.new()],
      "\e[C\e[B"=> [ DownForward.new(),  Action.new()],
      "\e[D\e[B"=> [ DownBackward.new(), Action.new()],
      "\e[B\e[C"=> [ DownForward.new(),  Action.new()],
      "\e[B\e[D"=> [ DownBackward.new(), Action.new()],
      "\e[C\e[A"=> [ UpForward.new(),    Action.new()],
      "\e[D\e[a"=> [ UpBackward.new(),   Action.new()],
      "\e[A\e[C"=> [ UpForward.new(),    Action.new()],
      "\e[A\e[D"=> [ UpBackward.new(),   Action.new()],
      ""        => [ None.new(), Action.new() ]
    }
    keys = keymap.keys
    keys.each { |key| keymap[key + 'x'] = [ keymap[key][0] , Kick.new()] }
    keys.each { |key| keymap[key + 'z'] = [ keymap[key][0], Punch.new()] }
    return keymap
  end

  def initialize()
    @keymap = genKeymap()
    @player = RyuPlayer.new()
  end
  def get_action()

  end
  def run()
    while( keys = STDIN.readline().chomp() )
      act = @keymap[keys]
      if (act) then
        puts(act.map {|x| "\t"+x.class.name })
        @player.move( *act )
      end
    end
  end
end

app = RyuApp.new()
app.trySomeMoves()
app.run()

