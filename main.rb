require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require_relative 'lib/snake'
require_relative 'lib/game'

SQUARE_SIZE = 20

set title: "Snake",
  width: Game::WIDTH * SQUARE_SIZE,
  height: Game::HEIGHT * SQUARE_SIZE,
  viewport_width: Game::WIDTH * SQUARE_SIZE,
  viewport_height: Game::HEIGHT * SQUARE_SIZE

game = Game.new
base_speed = 6
new_direction = :right

tick = 0
update do
  if tick % (60 / (base_speed + game.speed)) == 0
    tick = 0

    clear

    # allow only one direction change per game tick
    game.set_snake_direction(new_direction)
    game.tick

    render_head(game.snake.head)
    render_body(game.snake.body)
    render_food(game.food)

    # Text.new(get :fps)
  end

  tick += 1
end

on :key_up do |event|
  directions = ['up', 'down', 'left', 'right']

  if directions.include?(event.key)
    new_direction = event.key.to_sym
  end
end

def render_head(head)
  render_square(head[0], head[1])
end

def render_food(food)
  render_square(food[0], food[1], color: 'red')
end

def render_body(body)
  body.each do |square|
    render_square(square[0], square[1])
  end
end

def render_square(x, y, color: 'blue')
  offset = 1
  size = SQUARE_SIZE - offset
  Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: size, color: color)
end

show
