︠cc946e80-8d97-4b20-873e-0d3ce1682c52r︠
##This worksheet performs hyperelliptic curve arithmetic, which I used to help me understand the operations happening in a divisor addition.
def create_divisor(c):
    while True:
        try:
            x1,y1,x2,y2 = raw_input("Enter coordinates: ").split(",")
            p1 = c.point((x1,y1))
            p2 = c.point((x2,y2))
            print("{:s}{:s}\n".format("First point: ", p1))
            print("{:s}{:s}\n".format("Second point: ", p2))
            u = F("{:s}".format("x-"+x1))*F("{:s}".format("x-"+x2))
            y1 = p1[1]
            y2 = p2[1]
            x1 = int(x1)
            x2 = int(x2)
            m = (y1-y2)/(x1-x2)
            c = y1 - (m*x1)
            v = F("{:s}".format(str(m)+"x+"+str(c)))
            return(u,v)
            break
        except ValueError as e:
            print(e)
        except TypeError as e:
            print(e)

def add_divisors(f, h, u1, v1, u2, v2):
    d1, e1, e2 = xgcd(u1,u2)
    d, c1, c2 = xgcd(d1, v1+v2+h)
    s1 = c1*e1
    s2 = c1*e2
    s3 = c2
    u = F((u1*u2)/(d^2))
    v = F((s1*(u1*v2) + s2*(u2*v1) + s3*(v1*v2) + s3*f)/d).mod(u)
    g = (f.degree()-1)/2
    while (u.degree() > g):
        u = F((f-(v*h)-(v^2))/u)
        v = F(-h-v).mod(u)
    u1 = u
    v1 = v
    u1 = u1/u1[2]
    return (u1, v1)

def mul_divisor(f, h, u, v, n):
    if (n == 0):
        return (0,0)
    elif (n == 1):
        return (u,v)
    elif (mod(n,2) == 1):
        (u1,v1) = mul_divisor(f, h, u, v, n-1)
        return add_divisors(f, h, u, v, u1, v1)
    else:
        (u,v) = dbl_divisor(f, h, u, v)
        return mul_divisor(f, h, u, v, n/2)

def dbl_divisor(f, h, u, v):
    return add_divisors(f,h,u,v,u,v)

F.<x> = QQ[]
#x^5-4x^4-14x^3+36x^2+45x
#x^5-5x^3+4x+1
#Inputs
while True:
    try:
        a = raw_input("Enter equation: ")
        f = F("{:s}".format(a))
        c = HyperellipticCurve(f)
        j = c.jacobian()
        print(c)
        break
    except TypeError as e:
        print(e)
    except ValueError as e:
        print(e)
    except SyntaxError as e:
        print(e)

(u1,v1) = create_divisor(c)
print("{:s}({:s}, {:s})\n".format("Divisor 1: ",u1,v1))
while True:
    op = raw_input("What arithmetic to perform: Addition (a) or Multiplication (m)")
    if(op == "a"):
        print("Define another divisor")
        (u2, v2) = create_divisor(c)
        print("{:s}({:s}, {:s})\n".format("Divisor 2: ",u2,v2))
        (u1, v1) = add_divisors(f, 0, F(u1), F(v1), F(u2), F(v2))
        print("result: (u,v) = ({:s}), ({:s})\n".format(u1,v1))
    elif(op == "m"):
        try:
            m = int(raw_input("What to multiply by"))
            (u1, v1) = mul_divisor(f, 0, u1, v1, m)
            print("result: (u,v) = ({:s}), ({:s})\n".format(u1,v1))
        except ValueError as e:
            print(e)
        except NameError:
            pass
    else:
        print("Invalid operation")









