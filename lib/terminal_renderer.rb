require 'io/console'

class TerminalRenderer
  BOUNDARY_VER = '│'
  BOUNDARY_HOR = '─'
  BODY = '█'
  HEAD = '█'
  FOOD = '*'

  attr_reader :game, :new_direction

  def initialize(game)
    @game = game
    @new_direction = :right

    Thread.new do
      tick = 0
      IO.console.raw do
        loop do
          if tick % (30 / (1 + game.speed)) == 0
            tick = 0

            # allow only one direction change per game tick
            game.tick(new_direction)
            render
          end

          tick += 1
          sleep(0.005)
        end
      end
    end

    loop do
      new_direction = read_input
      if [:up, :down, :left, :right].include?(new_direction)
        @new_direction = new_direction
      end
    end
  end

  def render
    clear_screen
    render_head
    render_tail
    render_food
    move_cursor(game.width + 2, game.height + 2)
  end

  private

  def render_head
    render_symbol(x: head[0] + 1, y: head[1] + 1, char: HEAD, color: :blue)
  end

  def render_food
    render_symbol(x: food[0] + 1, y: food[1] + 1, char: FOOD, color: :red)
  end

  def render_tail
    tail.each do |square|
      render_symbol(x: square[0] + 1, y: square[1] + 1, char: BODY, color: :b_blue)
    end
  end

  def clear_screen
    $stdout.write("\e[2J")

    # corners
    render_symbol(x: 0, y: 0, char: '┌')
    render_symbol(x: 0, y: game.width + 1, char: '└')

    render_symbol(x: game.height + 1, y: 0, char: '┐')
    render_symbol(x: game.height + 1, y: game.width + 1, char: '┘')

    (1..game.width).each do |i|
      render_symbol(x: i, y: 0, char: BOUNDARY_HOR)
      render_symbol(x: i, y: game.height + 1, char: BOUNDARY_HOR)
    end

    (1..game.height).each do |i|
      render_symbol(x: 0, y: i, char: BOUNDARY_VER)
      render_symbol(x: game.width + 1, y: i, char: BOUNDARY_VER)
    end
  end

  def render_symbol(x:, y:, char:, color: nil)
    move_cursor(x, y)

    colors = {
      red: "\e[0;31m",
      b_red: "\e[1;91m",
      blue: "\e[0;34m",
      b_blue: "\e[1;94m",
      reset: "\e[0m",
    }

    $stdout.write("#{colors[color]}#{char}#{colors[:reset]}")
  end

  def move_cursor(x, y)
    $stdout.write("\e[#{y + 1};#{x + 1}H")
  end

  def read_input
    case $stdin.getc.chr
    when 'q' # we need to be able to quit lol
      exit(0)
    when "k"
      :up
    when "j"
      :down
    when "h"
      :left
    when "l"
      :right
    end
  end

  def head
    game.snake.head
  end

  def tail
    game.snake.tail
  end

  def food
    game.food
  end
end

