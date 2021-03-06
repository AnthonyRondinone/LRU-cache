
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
    @next = nil
    @prev = nil
  end
end

class LinkedList

  include Enumerable

  def initialize # lru
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i) # lru
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    self.each { |link| return link.val if link.key == key}
    nil
  end

  def include?(key)
    any? { |link| link.key == key}
  end

  def append(key, val)  # lru
    new_link = Link.new(key, val)

    new_link.next = @tail
    new_link.prev = @tail.prev
    new_link.prev.next = new_link
    @tail.prev = new_link

  end

  def update(key, val)

    current_link = self.first

    until current_link == @tail
      if current_link.key == key
        current_link.val = val
      end
      current_link = current_link.next
    end
    nil

  end

  def remove(key) # lru

    current_link = self.first

    until current_link.key == @tail
      if current_link.key == key
        current_link.remove
        break
      end
      current_link = current_link.next
    end
  end

  def each

    current_link = self.first

    until current_link == @tail
      yield(current_link)
      current_link = current_link.next
    end
    self
  end


  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
