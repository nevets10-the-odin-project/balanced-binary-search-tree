class Node
  include Comparable

  attr_accessor :data, :left_c, :right_c

  def initialize(data)
    self.data = data
    self.left_c = nil
    self.right_c = nil
  end

  def <=>(other)
    data <=> other.data
  end
end
