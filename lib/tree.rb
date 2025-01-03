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

  def insert(value, cur_root = root)
    return Node.new(value) if cur_root.nil?

    return cur_root if cur_root.data == value

    if value < cur_root.data
      cur_root.left_c = insert(value, cur_root.left_c)
    elsif value > cur_root.data
      cur_root.right_c = insert(value, cur_root.right_c)
    end

    cur_root
  end

  def get_successor(cur_root)
    cur_root = cur_root.right_c
    cur_root = cur_root.left_c until cur_root.nil? || cur_root.left_c.nil?
    cur_root
  end

  def delete(value, cur_root = root)
    return if cur_root.nil?

    if value < cur_root.data
      cur_root.left_c = delete(value, cur_root.left_c)
    elsif value > cur_root.data
      cur_root.right_c = delete(value, cur_root.right_c)
    else
      return cur_root.right_c if cur_root.left_c.nil?
      return cur_root.left_c if cur_root.right_c.nil?

      successor = get_successor(cur_root)
      cur_root.data = successor.data
      cur_root.right_c = delete(successor.data, cur_root.right_c)
    end

    cur_root
  end

  def find(value, cur_root = root)
    return if cur_root.nil?

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

  def preorder(cur_root = root, return_arr = [], &block)
    return if cur_root.nil?

    if block_given?
      yield(cur_root)
    else
      return_arr << cur_root.data
    end

    preorder(cur_root.left_c, return_arr, &block)
    preorder(cur_root.right_c, return_arr, &block)

    return_arr
  end

  def inorder(cur_root = root, return_arr = [], &block)
    return if cur_root.nil?

    inorder(cur_root.left_c, return_arr, &block)

    if block_given?
      yield(cur_root)
    else
      return_arr << cur_root.data
    end

    inorder(cur_root.right_c, return_arr, &block)

    return_arr unless block_given?
  end

  def postorder(cur_root, return_arr = [], &block)
    return if cur_root.nil?

    postorder(cur_root.left_c, return_arr, &block)
    postorder(cur_root.right_c, return_arr, &block)

    if block_given?
      yield(cur_root)
    else
      return_arr << cur_root.data
    end

    return_arr unless block_given?
  end

  def height(cur_root, edge_count = 0)
    return if cur_root.nil?
    return edge_count if cur_root.left_c.nil? && cur_root.right_c.nil?

    l_count = cur_root.left_c.nil? ? edge_count : height(cur_root.left_c, edge_count + 1)
    r_count = cur_root.right_c.nil? ? edge_count : height(cur_root.right_c, edge_count + 1)

    l_count > r_count ? l_count : r_count
  end

  def depth(node, cur_root = root, count = 0)
    return if node.nil?

    if node == cur_root
      count
    elsif cur_root.left_c.nil? && cur_root.right_c.nil?
      nil
    elsif node.data < cur_root.data
      cur_root.left_c.nil? ? count : depth(node, cur_root.left_c, count + 1)
    else
      cur_root.right_c.nil? ? count : depth(node, cur_root.right_c, count + 1)
    end
  end

  def balanced?
    l_height = height(root.left_c)
    r_height = height(root.right_c)
    diff = l_height > r_height ? l_height - r_height : r_height - l_height
    diff <= 1
  end

  def rebalance
    new_arr = inorder(root)
    self.root = build_tree(new_arr, 0, new_arr.length - 1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_c, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_c
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_c, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_c
  end
end
