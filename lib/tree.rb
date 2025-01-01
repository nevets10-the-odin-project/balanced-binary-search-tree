require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(arr)
    self.root = build_tree(arr.sort.uniq, 0, arr.sort.uniq.length - 1)
  end

  def build_tree(arr, start, ending)
    return if start > ending

    mid = start + ((ending - start) / 2)

    new_root = Node.new(arr[mid])
    new_root.left_c = build_tree(arr, start, mid - 1)
    new_root.right_c = build_tree(arr, mid + 1, ending)

    new_root
  end

  def insert(value)
  end

  def delete(value)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_c, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_c
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_c, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_c
  end
end
