BOARD_WIDTH = 3
BLANK = nil
class Array_2
  attr_reader :board
  def initialize
    @board =  Array.new(BOARD_WIDTH) { Array.new(BOARD_WIDTH) { BLANK } }
    @board[0][0] = "x"
    @board[1][1] = "x"
    @board[2][2] = "x"
  end

end


array_object = Array_2.new
@request_data = {board: Array.new(BOARD_WIDTH) { Array.new(BOARD_WIDTH) { BLANK } }, opponent_piece: "X", player_piece: "X"}

@request_data[:board].each_with_index do |array,in1|
  array.each_with_index do |element,in2|
    puts "#{in1},#{in2} #{element}"
  end
end
puts "separacion"
array_object.board.each_with_index do |array,in1|
  array.each_with_index do |element,in2|
    @request_data[:board][in1][in2] = element
  end
end

puts "copiando el array"

#@request_data[:board] = array_object.board

@request_data[:board].each_with_index do |array,in1|
  array.each_with_index do |element,in2|
    puts "#{in1},#{in2} #{element}"
  end
end
