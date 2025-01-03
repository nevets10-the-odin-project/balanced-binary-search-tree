require_relative 'tree'

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new(arr)

tree.pretty_print
puts "The tree is balanced. Survey says #{tree.balanced?}"

tree.insert(tree.root, 999_999)
tree.insert(tree.root, 999_998)

tree.pretty_print
puts "The tree is balanced. Survey says #{tree.balanced?}"
