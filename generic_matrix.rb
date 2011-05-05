class GenericMatrix
    @matrix
    
    def initialize(n)
        @matrix = []

        data = nil
        if (n.kind_of? Array)
            data = n
            n = data.length
        end

        fill_zero(n)

        if not (data.nil?)
            set_array(data)
        end
    end

    def get(y, x)
        @matrix[y][x]
    end

    def set(y, x, value)
        @matrix[y][x] = value
    end

    def set_array(data)
        data.each_index { |y| data[y].each_index { |x| set(y, x, data[y][x])}}
    end

    def fill_zero(n)
        @matrix = []
        n.times do 
            line = []
            n.times { line << 0 }
            @matrix << line
        end
    end

    def *(k)
        if k.kind_of?(Array)
            return vector_multiply(k)
        end
        # deep copy hack
        data = Marshal.load(Marshal.dump(@matrix))
        data.each_index { |y| data[y].each_index {|x| data[y][x] = k * data[y][x] }}

        return GenericMatrix.new(data)
    end

    def vector_multiply(v)
        result = []
        @matrix.each do |row|
            sum = 0.0
            row.each_with_index do |column, i|
                sum += column * v[i]
            end
            result << sum
        end

        return result
    end

    def +(b)
        # deep copy hack
        data = Marshal.load(Marshal.dump(@matrix))
        data.each_index { |y| data[y].each_index {|x| data[y][x] = b.get(y, x) + data[y][x] }}

        return GenericMatrix.new(data)
    end

    def size_y
        return @matrix.size
    end

    def size_x
        return @matrix[0].size
    end

    def diagonal_always_max?
        @matrix.each_with_index do |row, i|
            row.each_with_index do |value, j|
                if i != j and value.abs >= @matrix[i][i]
                    return false
                end
            end
        end

        return true
    end

    def symetrical?
        @matrix.each_with_index do |row, i|
            @matrix.each_with_index do |value, j|
                if @matrix[i, j] != @matrix[j, i]
                    return false
                end
            end
        end

        return true
    end
end
