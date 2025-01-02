require_relative 'tree'

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new(arr)

tree.pretty_print
tree.preorder(tree.root) { |node| p "This node is #{node.data}" }
