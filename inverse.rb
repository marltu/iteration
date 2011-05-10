require "./generic_matrix"
require "./tridiagonal_matrix"
require "./vector"
require "./methods"

k = 12 
c = GenericMatrix.new([
    [0.3,   0,    0,    0],
    [0,   0.3,    0,    0],
    [0,      0, 0.3,    0],
    [0,      0,    0, 0.3]
])
kc = c*k

t = GenericMatrix.new([
    [ 2.34,  2.0,    0,    0],
    [  2.0, 2.34,  2.0,    0],
    [    0,  2.0, 2.34,  2.0],
    [    0,    0,  2.0, 2.34] 
])

a = t + kc

#a = GenericMatrix.new([
#    [ 2.0,    -1.0,    0,    0],
#    [    -1.0,  2.0,    -1.0,    0],
#    [    0,    -1.0, 2.0,    -1.0],
#    [    0,    0,    -1.0, 2.0] 
#])
e = 0.00001

lambdak = 4
xk = [1.0, 1.0, 1.0, 1.0]

def identity_matrix(n)
    matrix = GenericMatrix.new(n)
    0.upto(n-1) do |i|
        matrix.set(i, i, 1)
    end

    return matrix
end

def eighenvector(a, lambdak, xk, e)
    diff = e + 1
    yk1 = [0]*a.size_y

    i = 0

    while diff > e do
        yk1 = gradient_solve(a + (identity_matrix(a.size_y)*lambdak*-1), xk, yk1, e)

        xk1 = Vector.div(yk1, Vector.norm2(yk1))

        lambdak = Vector.vmul(a * xk1, xk1)

        diff = Vector.norm(Vector.sub(xk1, xk))
        print "/// #{i}\n lambda: #{lambdak} \n diff: #{diff} \n x: #{xk1.inspect} \n"
        if (diff >= 1.9 and diff <= 2.1)
            xk1 = Vector.mul(xk1, -1)
        end

        xk = xk1

        i += 1
    end

    return [lambdak, xk]
end

xk = eighenvector(a, lambdak, xk, e)
print "\nxk: #{xk.inspect}\n"
