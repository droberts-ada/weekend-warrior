class Hamming
  def self.compute(left, right)
    if left.length != right.length
      raise ArgumentError.new("Strings must have same length! Got #{left.length}, #{right.length}")
    end

    mutations = 0
    left.length.times do |i|
      if left[i] != right[i]
        mutations += 1
      end
    end

    return mutations
  end
end
