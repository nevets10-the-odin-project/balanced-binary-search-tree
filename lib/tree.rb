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

  def insert(cur_root, value)
    return Node.new(value) if cur_root.nil?

    return cur_root if cur_root.data == value

    if value < cur_root.data
      cur_root.left_c = insert(cur_root.left_c, value)
    elsif value > cur_root.data
      cur_root.right_c = insert(cur_root.right_c, value)
    end

    cur_root
  end

  def get_successor(cur_root)
    cur_root = cur_root.right_c
    cur_root = cur_root.left_c until cur_root.nil? || cur_root.left_c.nil?
    cur_root
  end

  def delete(cur_root, value)
    return if cur_root.nil?

    if value < cur_root.data
      cur_root.left_c = delete(cur_root.left_c, value)
    elsif value > cur_root.data
      cur_root.right_c = delete(cur_root.right_c, value)
    else
      return cur_root.right_c if cur_root.left_c.nil?
      return cur_root.left_c if cur_root.right_c.nil?

      successor = get_successor(cur_root)
      cur_root.data = successor.data
      cur_root.right_c = delete(cur_root.right_c, successor.data)
    end

    cur_root
  end

  def find(value, cur_root = root)
    node = nil

    node = cur_root if cur_root.data == value

    if value < cur_root.data
      node = find(value, cur_root.left_c)
    elsif value > cur_root.data
      node = find(value, cur_root.right_c)
    end

    node
  end

  def level_order(cur_root)
    return if cur_root.nil?

    queue = [cur_root]
    return_arr = []

    until queue.empty?
      node = queue[0]
      queue << node.left_c unless node.left_c.nil?
      queue << node.right_c unless node.right_c.nil?

      if block_given?
        yield(node)
      else
        return_arr << queue[0].data
      end

      queue.shift
    end

    return_arr.flatten unless block_given?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_c, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_c
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_c, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_c
  end
end
