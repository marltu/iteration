require "./generic_matrix"
require "./tridiagonal_matrix"
require "./vector"
require "./methods"

# student number
k = 12 
# constant matrix
c = GenericMatrix.new([
    [0.3,   0,    0,    0],
    [0,   0.3,    0,    0],
    [0,      0, 0.3,    0],
    [0,      0,    0, 0.3]
])

# matrix C multiplied by constant k (student number)
kc = c*k

t = GenericMatrix.new([
    [ 2.34,  2.0,    0,    0],
    [  2.0, 2.34,  2.0,    0],
    [    0,  2.0, 2.34,  2.0],
    [    0,    0,  2.0, 2.34] 
])

# matrix A, which is T + kC
a = t + kc

# precission
e = 0.00001

print a.inspect
print "\n"

# initial lambda
lambdak = 2
# initial x
xk = [1, 0, 0, 0]

# generates identity matrix (diagonally 1) for size n
def identity_matrix(n)
    matrix = GenericMatrix.new(n)
    0.upto(n-1) do |i|
        matrix.set(i, i, 1)
    end

    return matrix
end

# finds eighenvector and eighenvalue given
# Marix a
# initial lambda value (eighenvalue)
# initial x value (eighenvector)
# precission
def eighenvector(a, lambdak, xk, e)
    # make sure diff is > e
    diff = e + 1

    # make initial values for yk1
    yk = [0]*a.size_y

    # cycle counter
    i = 0

    while diff > e do
        # (A - lambdak * I)yk1 = xk
        # converted to: 
        # (A + I*lambdak*-1)yk1 = xk
        # solve for yk1

        yk1 = gradient_solve(a + (identity_matrix(a.size_y)*lambdak*-1), xk, yk, e)

        # find new eighenvector
        # xk1 = yk1 / ||yk1||2 (second norm)
        xk1 = Vector.div(yk1, Vector.norm2(yk1))

        # find new eighenvalue
        lambdak1 = Vector.vmul(a * xk1, xk1)

        # calculate precission using
        # || xk1 - xk ||
        diff = Vector.norm(Vector.sub(xk1, xk))
        print "/// #{i}\n lambda: #{lambdak1} \n diff: #{diff} lambdadiff: #{(lambdak1 - lambdak).abs}\n x: #{xk1.inspect}\n"

        # if diff is ~= 2, we need to change vector direction
        if (diff >= 1.9 and diff <= 2.1)
            # xk1 = xk1 * -1
            xk1 = Vector.mul(xk1, -1)
        end

        # max difference || xk1 - xk || or | lambdak1 - lambdak |
        diff = Vector.max([diff, (lambdak1 - lambdak).abs])

        # set newly found eighenvector
        xk = xk1
        yk = yk1
        lambdak = lambdak1

        i += 1
    end

    # return [eighenvalue, eighenvector]
    return [lambdak, xk]
end

xk = eighenvector(a, lambdak, xk, e)
print "\nxk: #{xk.inspect}\n"
