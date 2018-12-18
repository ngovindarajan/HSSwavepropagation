### Type definitions ###

module HSStypes

export HSS, HSSleaf, HSSnode, HSSroot, vectree, vectreenode, vectreeleaf, vectreeroot


  #--------------- Parametric type: --------------------#
  #---------------   binary tree    --------------------#


  abstract type binarytree end

  struct binarytreeleaf{T}<:binarytree
    fields::T
  end


  struct binarytreenode{T}<:binarytree
    fields::Vector
    subtree1::binarytree
    subtree2::binarytree
  end


  #------------------------------------------------------#

  abstract type vectree end

  struct vectreeleaf<:vectree
    v::Vector
  end

  struct vectreenode<:vectree
    v::Vector
    subtree1::vectree
    subtree2::vectree
  end


  #------------------------------------------------------#

  abstract type HSS end

  struct HSSleaf<:HSS
    U::Matrix
    V::Matrix
    D::Matrix
    n::Int64
  end
  HSSleaf(U,V,D) = HSSleaf(U,V,D,size(D,1))

  struct HSSnode<:HSS
    R1::Matrix
    R2::Matrix
    W1::Matrix
    W2::Matrix
    B12::Matrix
    B21::Matrix
    A1::HSS
    A2::HSS
    n::Int64
  end
   HSSnode(R1,R2,W1,W2,B12,B21,A1,A2) = HSSnode(R1,R2,W1,W2,B12,B21,A1,A2,A1.n+A2.n)




#------------------------------------------------------#


end
