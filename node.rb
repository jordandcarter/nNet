load "link.rb"
class Node
  attr_accessor :links_in, :links_out, :type, :value, :threshold
  
  def initialize(t, v = 0.0, thres = 0.5)
    @links_in = []
    @links_out = []
    @value = v
    @type = t
    @threshold = thres
  end
  
  def link_to node
    link = Link.new(node, self, rand)
    @links_out << link
    node.links_in << link
  end
  
  def fire
    sum = links_in.inject(0){|sum, link| sum + link.link_from.value * link.weight}
    @value = sigmoid(sum - threshold)
    puts "#{value} = sigmoid(#{sum} - #{threshold}"
  end
  
  def sigmoid v
    1.0/(1.0+Math.exp(-v))
  end
  
  def to_s
    ([sprintf("#{@type}:%.2f", value)]+links_in.collect{|i| sprintf("%.2f", i.weight)}).join("|")
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
