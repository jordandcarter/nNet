load "node.rb"
class Net
  attr_accessor :input, :output, :hidden
  
  def initialize input_count=2, hidden_depth=1, hidden_width=2, output_count=2
    @input = []
    input_count.times do |i|
      @input << Node.new('i')
    end
    
    @output = []
    output_count.times do |i|
      @output << Node.new('o')
    end
    
    @hidden = []
    hidden_depth.times do |d|
      row = []
      @hidden << row
      hidden_width.times do |w|
        row << Node.new('h')
      end
    end
    make_links
    nil
  end
  
  def make_links
    @input.each { |n| n.clear_links }
    @hidden.flatten.each { |n| n.clear_links }
    @output.each { |n| n.clear_links }
    
    #link inputs to hidden
    @input.each do |i|
      @hidden.first.each do |h|
        i.link_to h
      end
    end
    
    #link hidden to hidden
    @hidden[0..-2].size.times do |i|
      @hidden[i].each do |h|
        @hidden[i+1].each do |j|
          h.link_to j if rand > 0.7
        end
      end
    end
    #TODO for deeper nets
    
    #link hidden to outputs
    @hidden.last.each do |h|
      @output.each do |o|
        h.link_to o
      end
    end
    nil
  end
  
  def tick(times = 1)
    times.times do |count|
      hidden.flatten.each {|h| h.clear_value!}
      (input+hidden+output).flatten.each do |i|
        i.links_out.each do |node|
          i.fire_at node
        end
      end
    end
    self
  end
  
  def to_s
    result = "input:\t" + input.collect{|n| n.to_s}.join("\t")
    hidden.each do |h|
      result = result + "\nhidden:\t"
      result = result + h.collect{|n| n.to_s}.join("\t")
    end
    result = result + "\noutput:\t" + output.collect{|n| n.to_s}.join("\t")
    result
  end
  
  def new_inputs new_input
    @input = []
    new_input.each do |i|
      @input << Node.new('i', i)
    end
    make_links
  end
  
  def links_out_count
    (input+hidden+output).flatten.collect{|n| n.links_out}.flatten.size
  end
  
end
