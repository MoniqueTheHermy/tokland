require 'rubygems'
require 'test/unit'

require 'adt_tree'

class TreeTest < Test::Unit::TestCase
  def setup
    @tree = Tree.node("1", Tree.leaf("1a"), 
                           Tree.node("1b", Tree.empty, 
                                           Tree.leaf("1bB")))
  end
  
  def test_weight
    assert_equal 4, @tree.weight
  end                                     

  def test_values
    assert_equal ["1", "1a", "1b", "1bB"], @tree.values
  end
  
  def test_fmap
    assert_equal ["v=1", "v=1a", "v=1b", "v=1bB"], 
                 @tree.fmap { |x| "v=#{x}" }.values
  end
  
  def test_inspect
    assert_equal '(Node "1" (Leaf "1a") (Node "1b" Empty (Leaf "1bB")))', @tree.inspect
  end
  
  def Xtest_tree_leaf_paths
    assert_equal [], Tree.empty.leaf_paths
    assert_equal [[1]], Tree.leaf(1).leaf_paths
    assert_equal [[1]], Tree.node(1, Tree.empty, Tree.empty).leaf_paths
    assert_equal [[1, 2]], Tree.node(1, Tree.leaf(2), Tree.empty).leaf_paths
    assert_equal [[1, 2], [1, 3]], Tree.node(1, Tree.leaf(2), Tree.leaf(3)).leaf_paths
    assert_equal [[1, 3, 4], [1, 3, 5, 6], [1, 3, 5, 7]],
                 Tree.node(1, Tree.empty, 
                              Tree.node(3, Tree.leaf(4), 
                                           Tree.node(5, Tree.leaf(6),
                                                        Tree.leaf(7)))).leaf_paths
  end
end
