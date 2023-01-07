require 'spec_helper'
require 'game'

RSpec.describe Game do
  let(:snake) { Snake.new(head: [0, 0]) }
  let(:game) { described_class.new(snake: snake) }

  it 'generates food' do
  end

  describe 'snake out of bounds' do
    it 'moves snake up' do
      head = [Game::HEIGHT, 0]
      allow(snake).to receive(:head).and_return(head)

      game.move_out_of_bounds
      expect(snake.head).to eq [0, 0]
    end

    it 'moves snake down' do
      head = [-1, 0]
      allow(snake).to receive(:head).and_return(head)

      game.move_out_of_bounds
      expect(snake.head).to eq [Game::HEIGHT - 1, 0]
    end

    it 'moves snake left' do
      head = [0, Game::WIDTH]
      allow(snake).to receive(:head).and_return(head)

      game.move_out_of_bounds
      expect(snake.head).to eq [0, 0]
    end

    it 'moves snake right' do
      head = [0, -1]
      allow(snake).to receive(:head).and_return(head)

      game.move_out_of_bounds
      expect(snake.head).to eq [0, Game::WIDTH - 1]
    end
  end

  describe 'game tick' do
    it 'checks collision' do
      allow(snake).to receive(:collision?).and_return(true)
      expect(game).to receive(:reset_game)

      game.tick
    end

    it 'food is eaten' do
      allow(game).to receive(:food_eaten?).and_return(true)

      expect(snake).to receive(:move_head)
      expect(snake).to receive(:eat)
      expect(snake).not_to receive(:move_body)
      expect(game).to receive(:generate_food)

      game.tick
    end

    it 'food is not eaten' do
      allow(game).to receive(:food_eaten?).and_return(false)

      expect(snake).to receive(:move_head)
      expect(snake).not_to receive(:eat)
      expect(snake).to receive(:move_body)
      expect(game).not_to receive(:generate_food)

      game.tick
    end
  end
end
