require_relative 'tree'

arr = (Array.new(15) { rand(1..100) })

def puts_info(tree)
  tree.pretty_print
  puts "Is the tree balanced? Survey says #{tree.balanced?}."

  puts 'Level order'
  p tree.level_order

  puts 'Preorder'
  p tree.preorder

  puts 'Postorder'
  p tree.postorder

  puts 'Inorder'
  p tree.inorder
end

tree = Tree.new(arr)
puts_info(tree)

puts '----------------------------------------------------'
puts "Let's add a few more numbers."
tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.pretty_print
puts "Is the tree balanced? Survey says #{tree.balanced?}."
puts '----------------------------------------------------'
puts "Let's rebalance the tree!"
tree.rebalance
puts_info(tree)
