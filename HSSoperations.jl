##  HSS operations ##

using HSStypes

#------------------------------------------------------#

function upsweep(A::HSSleaf, b::Vector)
  g = vectreeleaf(A.V' * b)
  return g
end

function upsweep(A::HSSnode, b::Vector)
  gsubtree1 =  upsweep(A.A1, b[1:A.A1.n])
  gsubtree2 =  upsweep(A.A2, b[(A.A1.n+1):A.n])
  if ~(isempty(A.W1) && isempty(A.W2))
    g = vectreenode( A.W1' * gsubtree1.v + A.W2' * gsubtree2.v, gsubtree1 , gsubtree2)
  else
    g = vectreenode( [], gsubtree1 , gsubtree2)
  end
  return g
end

#-------------------------------------------------------#

function downsweep(A::HSSnode, f::Vector, g::vectreenode)

 if isempty(f)
   f1 =  A.B12 * g.subtree2.v;
   f2 =  A.B21 * g.subtree1.v;
 else
   f1 = A.R1 * f +  A.B12 * g.subtree2.v;
   f2 = A.R2 * f +  A.B21 * g.subtree1.v;
 end

c1 = downsweep(A.A1,f1, g.subtree1)
c2 = downsweep(A.A2,f2, g.subtree2)

c = [c1;c2]

end


function downsweep(A::HSSleaf, f::Vector, g::vectreeleaf)
  c = A.U * ( g.v + f );
end


#--------------------------------------------------------#

function addDenseblocks(A::HSSnode, b::Vector)
   c1 = addDenseblocks(A.A1,b[1:A.A1.n])
   c2 = addDenseblocks(A.A2,b[(A.A1.n+1):A.n])
   c = [c1;c2]
   return c
end

function addDenseblocks(A::HSSleaf, b::Vector)
   c = A.D * b[:]
   return c
end

#--------------------------------------------------------#

function HSSmatrixvectormultiply(A::HSSleaf, b::Vector)
  return A.D*b
end

function HSSmatrixvectormultiply(A::HSSnode, b::Vector)


 # Step 1: Perform the downsweep to obtain the g-tree.
 g = upsweep(A,b)
 # Step 2: Perform the upsweep the add up the low rank parts:
 c_lowrank = downsweep(A,[],g)
 # Step 3: Add up dense parts:
 c_dense = addDenseblocks(A, b)

 c = c_lowrank + c_dense
 return c

end
