require 'spec_helper'
require 'snake'

RSpec.describe Snake do
  let(:head) { [0, 0] }

  describe 'head movement' do
    it 'moves up' do
      snake = described_class.new(direction: :up, head: head)
      snake.move_head

      expect(snake.head).to eq [0, -1]
    end

    it 'moves down' do
      snake = described_class.new(direction: :down, head: head)
      snake.move_head

      expect(snake.head).to eq [0, 1]
    end

    it 'moves right' do
      snake = described_class.new(direction: :right, head: head)
      snake.move_head

      expect(snake.head).to eq [1, 0]
    end

    it 'moves left' do
      snake = described_class.new(direction: :left, head: head)
      snake.move_head

      expect(snake.head).to eq [-1, 0]
    end

    it 'checks collision' do
      snake = described_class.new(direction: :right, head: head, body: [[0, 0]])

      expect(snake.collision?).to eq true
    end
  end

  describe 'body movement' do
    it 'copies head movement' do
      head = [3, 0]
      body = [[0, 0], [1, 0], [2, 0]]

      snake = described_class.new(direction: :left, head: head, body: body)

      snake.move_body

      expect(snake.body).to eq [[1, 0], [2, 0], [3, 0]]
    end
  end

  describe 'eating' do
    it 'adds to body' do
      snake = described_class.new(direction: :up, head: head)
      snake.eat

      expect(snake.body).to eq [[0, 0]]
    end
  end
end
