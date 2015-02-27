type AtomicUnitSet
    α::Int
    atoms::Vector{AtomicUnit}

    AtomicUnitSet(α::Int) = new(α, AtomicUnit[])
end

typealias AUSet AtomicUnitSet

A⁽⁸⁾ = AtomicUnitSet(8)

function Base.show(io::IO, A::AtomicUnitSet)
    print(io, "AtomicUnitSet(α = $(A.α), atoms = $(A.atoms))")
end

function Base.push!(A::AtomicUnitSet, a::AtomicUnit)
    a.e ≤ A.α/2 ? push!(A.atoms, a) : error("α = $(A.α) ∴ a ∉ A^(α)")    # how to render?: A⁽ᵅ⁾ (A^(α))
end

type CovalentBonds
end

abstract MolecularUnit

type Molecule <: MolecularUnit
    A::AtomicUnitSet
    B::CovalentBonds
    state::Symbol    # :stable or :unstable

end

# molecular unit behavior
phi{T<:Real}(x::T, d::Int, vH) = sum([a*x^i for i=1:d])
ϕ = phi
