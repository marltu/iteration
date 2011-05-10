require "./generic_matrix"
require "./vector"
require "./methods"
# student number
k = 12

b = [1.941, -0.23, -1.941, 0.23]
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
p = 0.00001
w = 1.246

result = relaxation_solve(a, b, x, p, w)
print "\nresult: #{result.inspect}\n"
print "\np: #{p}\n"
real = [1.05776813013717012177411178, -0.24419676739102486806721397, -0.841300694705757136784478093, -0.139047165222926434301103204]
print "max diff: #{Vector.norm(Vector.sub(real, result))}\n"
