class Node
  attr_accessor :links_in, :links_out, :weight, :type, :value
  
  def initialize(t, v = 0)
    @links_in = []
    @links_out = []
    @weight = rand
    @value = v
    @type = t
  end
  
  def link_to node
    @links_out << node
    node.links_in << self
  end
  
  def to_s
    sprintf("#{@type}:%.2f", hidden? ? weight : value)
  end
  
  def fire_at node
    node.value = node.value + self.value * (node.hidden? ? node.weight : 1)
    puts "#{node.value} = #{self.value} * #{(node.hidden? ? node.weight : 1)}"
  end
  
  def hidden?
    type == 'h'
  end
  
  def clear_links
    @links_in = []
    @links_out = []
  end
  
  def clear_value!
    value = 0
  end
end
