require_relative 'tree'

arr = (Array.new(15) { rand(1..100) })

tree = Tree.new(arr)
tree.pretty_print
puts "The tree is balanced. Survey says #{tree.balanced?}"
puts 'Level order'
p tree.level_order
