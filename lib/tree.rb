require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(arr)
    self.root = build_tree(arr.sort.uniq, 0, arr.sort.uniq.length - 1)
  end

  def build_tree(arr, start, ending)
    return if start > ending

    mid = start + ((ending - start) / 2)

    new_root = Node.new(mid)
    new_root.left_c = build_tree(arr, start, mid - 1)
    new_root.right_c = build_tree(arr, mid + 1, ending)

    new_root
  end
end
