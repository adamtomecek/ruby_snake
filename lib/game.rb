require_relative 'snake'

class Game
  WIDTH = 30
  HEIGHT = 30

  attr_reader :snake, :food

  def initialize(snake: nil)
    @snake = snake
    @food = nil

    if snake.nil?
      reset_game
    end

    generate_food
  end

  def tick
    # move head first to check for collision and food eating
    snake.move_head

    # snake collided with its body, reset game
    if collision?
      reset_game
      return
    end

    # move nead out of bounds if needed
    move_out_of_bounds

    if food_eaten?
      snake.eat
      generate_food
    else
      snake.move_body
    end
  end

  def speed
    snake.body.length / 10
  end

  def set_snake_direction(direction)
    snake.set_direction(direction)
  end

  # moves sneak out of bounds to the opposite side of the viewport
  def move_out_of_bounds
    if snake.head[0] == WIDTH
      snake.head[0] = 0
    elsif snake.head[0] < 0
      snake.head[0] = WIDTH - 1
    elsif snake.head[1] == HEIGHT
      snake.head[1] = 0
    elsif snake.head[1] < 0
      snake.head[1] = HEIGHT - 1
    end
  end

  private
  def collision?
    snake.collision?
  end

  def food_eaten?
    snake.food_eaten?(food)
  end

  def generate_food
    coords = nil

    # generate new food in position not colliding with snake body
    loop do
      @food = [rand(WIDTH), rand(HEIGHT)]

      unless snake.body.include?(food)
        break
      end
    end
  end

  def reset_game
    head = [2, 0]
    body = [[0, 0], [1, 0], [2, 0]]

    @snake = Snake.new(direction: :right, head: head, body: body)
  end
end
