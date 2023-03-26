require 'ruby2d/core'

class GuiRenderer
  SQUARE_SIZE = 20
  include Ruby2D::DSL

  attr_reader :game, :direction

  def initialize(game)
    @game = game
    @direction = :right

    set title: "Snake",
      width: Game::WIDTH * SQUARE_SIZE,
      height: Game::HEIGHT * SQUARE_SIZE,
      viewport_width: Game::WIDTH * SQUARE_SIZE,
      viewport_height: Game::HEIGHT * SQUARE_SIZE

    game_loop
    show
  end

  def game_loop
    tick = 0
    update do
      if tick % (60 / (6 + game.speed)) == 0
        tick = 0

        clear

        # allow only one direction change per game tick
        game.tick(direction)

        render_head(game.snake.head)
        render_tail(game.snake.tail)
        render_food(game.food)

        # Text.new(get :fps)
      end

      tick += 1
    end

    on :key_up do |event|
      directions = ['up', 'down', 'left', 'right']

      if directions.include?(event.key)
        @direction = event.key.to_sym
      end
    end
  end

  def render_head(head)
    render_square(head[0], head[1], color: 'green')
  end

  def render_food(food)
    render_square(food[0], food[1], color: 'red')
  end

  def render_tail(tail)
    tail.each do |square|
      render_square(square[0], square[1])
    end
  end

  def render_square(x, y, color: 'blue')
    offset = 1
    size = SQUARE_SIZE - offset
    Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: size, color: color)
  end
end
