# This is the source file. The program runs here.

require 'curses'

$startTime = Time.now

$length = 5
$height = 5

$allnewmol = 0

$molesgend = Array.new

$list = []

#Curses.noecho
#Curses.init_screen
#Curses.stdscr.keypad(true)

def portgen
  portid = []
  $length.times do
    emt = rand($height-1) + 1
    portid << emt.to_s
  end
  return portid.join
end

class Port
  attr_accessor :id, :open, :link, :molecule
  def initialize(mol)
    @id = portgen
    @molecule = mol
    @open = true
    @link = nil
  end
end

class Molecule
  attr_accessor :name
  def initialize
    @portcount = 1
    ran = 0
    while ran == 0
      ran = rand(4)
      @portcount += 1
    end
    @ports = []
    @portcount.times do
      @ports << Port.new(self)
    end
    @name = "Untitled"
  end
  def ports
    return @ports
  end
  def fetch(id)
    fetchlist = []
    @ports.each do |fdp|
      if fdp.id == id
        fetchlist << fdp
      end
    end
    return fetchlist
    def fetchopen(id)
      fetchlist = []
      @ports.each do |fdp|
       if fdp.id == id and fdp.open? == true
         fetchlist << fdp
       end
     end
    end
    return fetchlist[0]
    def fetchclosed(id)
      fetchlist = []
      @ports.each do |fdp|
        if fdp.id == id and fdp.open? == false
          fetchlist << fdp
        end
      end
    end
    return fetchlist[0]
  end
end

def join(mol1,mol2,id)
  unless mol1.fetchopen(id) == nil or mol2.fetchopen(id) == nil
    mol1.fetchopen(id).link=(mol2.fetchopen(id))
    mol2.fetchopen(id).link=(mol1.fetchopen(id))
    mol1.fetchopen(id).open=(false)
    mol2.fetchopen(id).open=(false)
    return true
  else
    return false
  end
end

def break(mol1,id)
  unless mol1.fetchclosed(id) == nil
    mol1.fetchclosed(id).open=(true)
    mol1.fetchclosed(id).link.open=(true)
    mol1.fetchclosed(id).link.link=(nil)
    mol1.fetchclosed(id).link=(nil)
    return true
  else
    return false
  end
end
  
def services
  newmols = Time.now - $startTime
  newmols = newmols.to_i
  newmols /= 3 #60*3
  newmols -= $allnewmol
  $allnewmol += newmols
  newmols.times do
    $molesgend << Molecule.new
  end
  #Saving goes here
  #$key = Curses.getch
  if $molesgend.size > 3
    $molesgend.pop
  end
end

def showmols
  $molesgend.each do |e|
    puts e.name
    puts "-----------"
    e.ports.each do |s|
      puts s.id
    end
    puts ""
  end
end

def mode
  system 'clear'
  puts <<beanSx
Select mode:
===================
g - Generator
e - Explore
b - Bank
h - Help
beanSx
  $mode = Curses.getch 
end

#mode
#puts mode

# --------------------------------
#        The following is
#        just for testing 
#            purposes.
# --------------------------------

john = Molecule.new
puts john.ports
