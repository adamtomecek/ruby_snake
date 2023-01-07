class Snake
  attr_reader :head, :body, :direction

  def initialize(direction: :up, head: [0, 0], body: [])
    @direction = direction
    @head = head
    @body = body
  end

  def collision?
    body.include?(head)
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

  def move_head
    case direction
    when :up
      head[1] -= 1
    when :down
      head[1] += 1
    when :right
      head[0] += 1
    when :left
      head[0] -= 1
    else
      raise "Unknown direction"
    end
  end

  def move_body
    @body << head.clone
    @body = body[1..-1]
  end

  def eat
    body << head.clone
  end

  def food_eaten?(food)
    head == food
  end
end
