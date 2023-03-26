class Snake
  attr_reader :body, :direction

  def initialize(direction: :up, body: [[0, 0]])
    @direction = direction
    @body = body
  end

  def collision?
    tail.include?(head)
  end

  def head
    body.last
  end

  def tail
    body[0..-2]
  end

  def set_direction(new_direction)
    # can't set direction to opposite direction
    if (new_direction == :up && direction == :down) ||
        (new_direction == :down && direction == :up) ||
        (new_direction == :left && direction == :right) ||
        (new_direction == :right && direction == :left)
      return
    end

    @direction = new_direction
  end

  def move(food = nil)
    move_head

    if food && food_eaten?(food)
      @body = body
    else
      @body = body[1..]
    end
  end

  def food_eaten?(food)
    head == food
  end

  private

  def eat
    @body = [head] + body
  end

  def move_head
    new_head = head.clone

    case direction
    when :up
      new_head[1] -= 1
    when :down
      new_head[1] += 1
    when :right
      new_head[0] += 1
    when :left
      new_head[0] -= 1
    else
      raise "Unknown direction"
    end

    body.push(new_head)
  end
end
