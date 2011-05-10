class Vector
    class << self
        def add(v1, v2)
            result = []
            v1.each_with_index do |v, i|
                result << v + v2[i]
            end

            return result
        end
        
        def sub(v1, v2)
            result = []
            v1.each_with_index do |v, i|
                result << v - v2[i]
            end

            return result
        end

        def max(v)
            max = nil
            v.each do |val|
                if max.nil? or val > max
                    max = val
                end
            end

            return max
        end

        def abs(v)
            v.each.collect do |val|
                val.abs
            end
        end

        def mul(v, k)
            v.each.collect do |val|
                val*k
            end
        end

        def div(v, k)
            v.each.collect do |val|
                val / k
            end
        end
        def vmul(v1, v2)
            sum = 0.0
            v1.each_with_index do |val, i|
                sum += val * v2[i]
            end

            return sum
        end

        def norm(v)
            return Vector.max(Vector.abs(v))
        end

        def norm2(v)
            sum = 0
            v.each do |val|
                sum += val**2
            end

            return Math.sqrt(sum)
        end
    end
end
