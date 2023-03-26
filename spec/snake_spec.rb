require 'spec_helper'
require 'snake'

RSpec.describe Snake do
  let(:head) { [0, 0] }

  describe 'head movement' do
    it 'moves up' do
      snake = described_class.new(direction: :up, body: [head])
      snake.move

      expect(snake.head).to eq [0, -1]
    end

    it 'moves down' do
      snake = described_class.new(direction: :down, body: [head])
      snake.move

      expect(snake.head).to eq [0, 1]
    end

    it 'moves right' do
      snake = described_class.new(direction: :right, body: [head])
      snake.move

      expect(snake.head).to eq [1, 0]
    end

    it 'moves left' do
      snake = described_class.new(direction: :left, body: [head])
      snake.move

      expect(snake.head).to eq [-1, 0]
    end

    it 'checks collision' do
      snake = described_class.new(direction: :right, body: [[0, 0], [0, 0]])

      expect(snake.collision?).to eq true
    end
  end

  describe 'whole body movement' do
    it 'copies head movement' do
      body = [[0, 0], [1, 0], [2, 0], [3, 0]]

      snake = described_class.new(direction: :left, body: body)

      snake.move

      expect(snake.body).to eq [[1, 0], [2, 0], [3, 0], [2, 0]]
    end
  end

  describe 'eating' do
    it 'adds to body' do
      snake = described_class.new(direction: :up, body: [head])
      food = [0, -1]
      snake.move(food)

      expect(snake.body).to eq [[0, 0], [0, -1]]
    end
  end
end
