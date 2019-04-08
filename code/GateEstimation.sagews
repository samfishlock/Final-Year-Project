︠355e3f06-b746-477f-b17f-55379b43d5b0︠
#This worksheet performs the gate estimations using the values for gates below
F.<n> = IntegerRing()[]
inv = 32*n^2*log(n,2)
mul_montgomery_full = 16*n^2*log(n,2)-float(26.3)*n
mul_full = 32*n^2*log(n,2)-float(59.4)*n^2
sub_full = 16*n*log(n,2)-float(23.8)*n
add_full = 16*n*log(n,2)-float(26.9)*n
squ_montgomery_full = 16*n^2*log(n,2)-float(26.3)*n

mul_montgomery = 16*n^2*log(n,2)
mul = 32*n^2*log(n,2)
sub = 16*n*log(n,2)
add = 16*n*log(n,2)
squ_montgomery = 16*n^2*log(n,2)

nnp = (51*mul + 7*sub).expand()
npp = (51*mul + 4*sub).expand()
nnn = (47*mul + 7*sub).expand()
npn = (48*mul + 4*sub).expand()
ppp = (47*mul + 4*sub).expand()
ppn = (44*mul + 4*sub).expand()
anp = (40*mul + 5*sub).expand()
app = (40*mul + 3*sub).expand()
ann = (36*mul + 5*sub).expand()
apn = (37*mul + 3*sub).expand()
aaa = (inv + 22*mul + 3*sub).expand()
kakaka = (15*mul + 5*sub).expand()

"NNP: {}".format(nnp)
"NPP: {}".format(npp)
"NNN: {}".format(nnn)
"NPN: {}".format(npn)
"PPP: {}".format(ppp)
"PPN: {}".format(ppn)
"ANP: {}".format(anp)
"APP: {}".format(app)
"ANN: {}".format(ann)
"APN: {}".format(apn)
"AAA: {}".format(aaa)
"K(a)K(a)K(a): {}".format(kakaka)









