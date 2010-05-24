class Link
  attr_accessor :link_to, :link_from, :weight
  
  def initialize node_in, node_out, link_weight
    @link_to = node_in
    @link_from = node_out
    @weight = link_weight
  end
end
