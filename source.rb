# This is the source file. The program runs here.

require 'curses'

$startTime = Time.now

$length = 5
$height = 5

$allnewmol = 0

$molesgend = []

$list = []

Curses.noecho
Curses.init_screen
Curses.stdscr.keypad(true)

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
  end
  def ports
    return @ports
  end
  attr_accessor :name
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
  $key = Curses.getch
end
  
while true

services

puts $molsgend

puts $length

puts $molsgend.size

end
