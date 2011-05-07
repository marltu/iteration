require "./generic_matrix"
require "./vector"

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

e = 0.0001
x = [0]*a.size_y

def gradient_solve(a, b, x, e)

    if not a.symmetrical?
        raise "Matrix is not symmetrical"
    end

    k = 0

    pk = Vector.sub((a * x), b)
    zk = pk

    while k < 1000 do

        rk = a * pk
        rkpk = Vector.vmul(rk, pk)
        zkzk = Vector.vmul(zk, zk) 
        tk = zkzk/rkpk

        x.each_with_index do |xk, i|
            x[i] = xk - tk*pk[i]
        end

        print "x: #{k} #{x.inspect}\n"

        zk1 = Vector.sub(zk,Vector.mul(rk, tk))
        zk1zk1 = Vector.vmul(zk1, zk1)

        if zk1zk1 < e**2 
            return x
        else
            betak = zk1zk1/zkzk
            pk1 = Vector.add(zk1, Vector.mul(pk, betak))

            k += 1
            pk = pk1
            zk = zk1
        end

    end
end

print gradient_solve(a, b, x, e).inspect
print "\n"

