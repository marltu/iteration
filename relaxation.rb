require "./generic_matrix"
require "./vector"
# student number
k = 12

b = [1.941, -0.23, -1.941, 0.230]
c = GenericMatrix.new([
    [0.01,   0,    0,    0],
    [0,   0.01,    0,    0],
    [0,      0, 0.01,    0],
    [0,      0,    0, 0.01]
])

kc = c*k

d = GenericMatrix.new([
    [ 1.342,  0.202, -0.599,  0.432],
    [ 0.202,  1.342,  0.202, -0.599],
    [-0.599,  0.202,  1.342,  0.202],
    [ 0.432, -0.599,  0.202,  1.342] 
])

a = d + kc

x = [0]*a.size_y
p = 0.000001
w = 0.5

def relaxation_solve(a, b, x, e, w)
    
    if not a.diagonal_always_max? or a.symmetrical?
        raise "Matrix does not converge"
    end
    
    n = x.size
    if (n != a.size_x or b.size != a.size_y)
        raise "Relaxation.solve: blogi parametrai."
    end
    
    print "--k--\t--x--\t\t\t--z--"

    maxloop = 1000
    xp = [0.0]*n
    z = 0.0
    zn = Vector.sub(a * x, b)    #netiktis?
    
    k = 0
    while k < maxloop do
        print "\n#{k} \t#{x.inspect} \t#{z}"
        (0..(n-1)).each do |i|
            sum = 0.0
            (0..(n-1)).each do |j|
                if (j != i)
                    if (j < i)
                        sum += a.get(i, j) * xp[j]
                    else
                        sum += a.get(i, j) * x[j]
                    end
                end
            end

            xp[i] = (w / a.get(i,i)) * (b[i] - sum) + (1 - w) * x[i]
        end

        z = Vector.max(Vector.abs(Vector.sub(x, xp)))    #paklaida
        zn = Vector.sub(a * x, b)    #netiktis?
        k += 1

        # there are two ways checking diff...
        if z < e
            return [xp, k, z, Vector.max(Vector.abs(zn))]
        end
        x, xp = xp, x
    end

    raise "Relaxation.solve: nepavyko isspresti per max (#{maxloop}) iteraciju."
end
result = relaxation_solve(a, b, x, p, w)
print "\nresult: #{result.inspect}\n"
