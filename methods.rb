require "./generic_matrix"
require "./vector"


def gradient_solve(a, b, x, e)

    if not a.symmetrical?
        raise "Matrix is not symmetrical"
    end

    k = 0

    # A * x - b (b = f)
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

        zk1 = Vector.sub(zk,Vector.mul(rk, tk))
        zk1zk1 = Vector.vmul(zk1, zk1)

        print "x: #{k} #{x.inspect} #{zk1zk1} #{pk}\n"
        
        if zk1zk1 < e**2 
            return x
        else
            # beta = (zk1, zk1) / (zk, zk)
            betak = zk1zk1/zkzk
            pk1 = Vector.add(zk1, Vector.mul(pk, betak))

            k += 1
            pk = pk1
            zk = zk1
        end

    end
    raise "Unable to solve in #{k} iterations"
end


def relaxation_solve(a, b, x, e, w)
    
    if not a.diagonally_dominant? and not a.symmetrical?
        raise "Matrix does not converge"
    end
    
    n = x.size
    if (n != a.size_x or b.size != a.size_y)
        raise "Relaxation.solve: blogi parametrai."
    end

    maxloop = 10000
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

        z = Vector.norm(Vector.sub(x, xp)) / Vector.norm(xp)
        zn = Vector.norm(Vector.sub(a * x, b)) / Vector.norm(b)
        k += 1

        # there are two ways checking diff...
        if z < e and zn < e
            return xp
        end
        x, xp = xp, x
    end

    raise "Relaxation.solve: nepavyko isspresti per max (#{maxloop}) iteraciju."
end
