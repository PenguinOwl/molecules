# This is the source file. The program runs here.

length = 5
height = 5

def portgen
  portid = []
  length.times do
    emt = rand(height-1) + 1
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

