class Node
  attr_accessor :data, :left_c, :right_c

  def initialize(data)
    self.data = data
    self.left_c = nil
    self.right_c = nil
  end
end
