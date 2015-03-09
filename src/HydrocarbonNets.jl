module HydrocarbonNets

using Compat

import Base: ==, promote_rule, push!, show

       # atomic_units.jl
export AtomicUnit, Hydrogen, H, Carbon, C,
       # molecular_units.jl
       MolecularUnit, AtomicUnitSet, AUSet, A⁽⁸⁾, phi, ϕ


include("atomic_units.jl")
include("molecular_units.jl")


end
