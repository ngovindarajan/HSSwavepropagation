workspace()
include("/Users/Nithin/Box Sync/numerical codes/HSS FMM code/nithin's FMM 2D code/typedefinitions.jl")
include("/Users/Nithin/Box Sync/numerical codes/HSS FMM code/nithin's FMM 2D code/HSSoperations.jl")
using HSStypes


## Construct HSS matrix



# Leaf HSS matrix
n = 10
p = 4
o = 2;

A2_1 = HSSleaf(randn(n,p), randn(n,p), randn(n,n))
A2_2 = HSSleaf(randn(n,p), randn(n,p), randn(n,n))
A2_3 = HSSleaf(randn(n,p), randn(n,p), randn(n,n))
A2_4 = HSSleaf(randn(n,p), randn(n,p), randn(n,n))

A1_1 = HSSnode( randn(p,p), randn(p,p), randn(p,p),
       randn(p,p), randn(p,p), randn(p,p), A2_1, A2_2)
A1_2 = HSSnode( randn(p,p), randn(p,p), randn(p,p),
       randn(p,p), randn(p,p), randn(p,p), A2_3, A2_4)

A0 = HSSnode(Array{Float64}(0,2),Array{Float64}(0,2),Array{Float64}(0,2),Array{Float64}(0,2),randn(p,p), randn(p,p), A1_1, A1_2)


x = rand(2^o*n);

y = HSSmatrixvectormultiply(A0, x)
