require "./generic_matrix"
require "./vector"
require "./methods"

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

e = 0.000000000000001
x = [0]*a.size_y

print "p: #{e}\n"
print gradient_solve(a, b, x, e).inspect
print "\n"

