require_relative 'board'
require_relative 'game_state'
require_relative 'player/perfect_player'

module Tictactoe
  module Adapter
    class ThreeSquaredBoardAdapter
      attr_reader :board_width
      attr_accessor :request_data
      BOARD_WIDTH = 3
      BLANK = nil

      def initialize
        @request_data = {board: Array.new(BOARD_WIDTH) { Array.new(BOARD_WIDTH) { BLANK } }, opponent_piece: "O", player_piece: "X"}
      end

      def begin
        board = build_board
        game_state = build_game_state(board)
        display_positions
        puts "Quires jugar primero y/n?"
        res = gets.chomp

        if %w[n N] == res
          while !game_state.over?
            puts "Maquina tomando turno"
            puts "..."
            copy_board(Tictactoe::Player::PerfectPlayer.new.take_turn(game_state))
            board = build_board
            game_state = build_game_state(board)

            sleep 2
            print_board
            who = game_state.winner
            break if game_state.over?
            puts "Elige casilla"
            box = nil
            while !valid_box?(box,game_state)
              box = gets.chomp
              puts "casilla no es valida" if !valid_box? box,game_state
            end
            game_state = human_turn(box,game_state)
            #@request_data[:board] = game_state.board
            copy_board(game_state)
            board = build_board
            game_state = build_game_state(board)
            print_board
            who = game_state.winner
            break if game_state.over?
          end
          puts "Fin de juego"
          if game_state.draw?
            puts "Empate"
          else
            puts "gano #{who}"
          end
        else
          while !game_state.over?
            puts "Elige casilla"
            box = nil
            while !valid_box?(box,game_state)
              box = gets.chomp
              puts "casilla no es valida" if !valid_box? box,game_state
            end
            game_state = human_turn(box,game_state)
            #@request_data[:board] = game_state.board
            copy_board(game_state)
            board = build_board
            game_state = build_game_state(board)
            print_board
            who = game_state.winner
            break if game_state.over?
            puts "Maquina tomando turno"
            puts "..."
            copy_board(Tictactoe::Player::PerfectPlayer.new.take_turn(game_state))
            board = build_board
            game_state = build_game_state(board)
            sleep 2
            print_board
            who = game_state.winner
          end
          puts "Fin de juego"
          if game_state.draw?
            puts "Empate"
          else
            puts "gano #{who}"
          end
        end

      end

    private

      def display_positions # initial user friendly board display
          puts ""
          puts " 1 | 2 | 3 "
          puts "-----------"
          puts " 4 | 5 | 6 "
          puts "-----------"
          puts " 7 | 8 | 9 "
          puts ""
      end

      def print_board
         puts ""
         puts "#{print_board_help 0,0} | #{print_board_help(0,1)} | #{print_board_help(0,2)}"
         puts "-----------"
         puts "#{print_board_help(1,0)} | #{print_board_help(1,1)} | #{print_board_help(1,2)}"
         puts "-----------"
         puts "#{print_board_help(2,0)} | #{print_board_help(2,1)} | #{print_board_help(2,2)}"
         puts ""
      end

      def print_board_help(x,y)
         @request_data[:board][x][y] ? @request_data[:board][x][y].to_s : " "
      end

      def build_board
        board = Tictactoe::Board.new(BOARD_WIDTH)
        @request_data[:board].each_with_index  do |space_data,in1|
          space_data.each_with_index  do |element,in2|
            piece = element
            if valid_piece(piece)
              space = [in1,in2]
              board.place_piece(piece, space)
            end
          end
        end
        board
      end

      def copy_board(game_state)
        game_state.board.to_a.each_with_index do |element,index1|
          move = box_to_move(index1+1)
          @request_data[:board][move.first][move[1]] = element
        end
      end

      def valid_piece(piece)
        [@request_data[:player_piece], @request_data[:opponent_piece]].include? piece
      end

      def build_game_state(board)
        player_piece = @request_data[:player_piece]
        opponent_piece = @request_data[:opponent_piece]
        game_state = Tictactoe::GameState.new(player_piece, opponent_piece)
        game_state.board = board
        game_state
      end

      def valid_box?(box, game_state)
        (1..9).to_a.include? box.to_i and game_state.available_moves.include?(box_to_move(box.to_i))
      end

      def human_turn(box,game_state)
        move = box_to_move box
        game_state.human_make_move(move)
      end

      def box_to_move(box)
        case box.to_i
        when 1
          return [0,0]
        when 2
          return [0,1]
        when 3
          return [0,2]
        when 4
          return [1,0]
        when 5
          return [1,1]
        when 6
          return [1,2]
        when 7
          return [2,0]
        when 8
          return [2,1]
        when 9
          return [2,2]
        end
      end

    end
  end
end


game = Tictactoe::Adapter::ThreeSquaredBoardAdapter.new

game.begin




