abstract AtomicUnit{T}

const atoms_data = [
    # Variable       Name   Symbol  Valence
    (:hydrogen, :Hydrogen,  :H,     1),
    (  :carbon,   :Carbon,  :C,     4)
]

const atoms = Dict{Symbol, Tuple}[]

for (variable, name, symbol, valence) in atoms_data
    @eval const $variable = Dict(:name => $name, :symbol => $symbol, :valence => $valence)
end

for (_, atom, symbol, valence) in atoms
    @eval begin
        type $atom{T<:Number} <: AtomicUnit{T}
            value::Complex{T}    # atomic value
            valence::Int         # number of valence electrons
            degree::Int          # number of shared valence electons
            free::Int            # number of free valence electrons

            $atom(value) = new(value, $valence, 0, $valence)
        end

        $atom{T<:Real}(value::Complex{T}) = $atom{T}(value)
        $atom{T<:Real}(value::T) = $atom(complex(value))
        $atom() = $atom(0.0)

        typealias $symbol $atom
    end
end

for atom in [atoms["name"] for atom in atoms]
    @eval function promote_rule{T<:Real, S<:Real}(::Type{${T}}, ::Type{Carbon{S}}) = Carbon{promote_type(T, S)}

function Base.show(io::IO, a::AtomicUnit)
    print(io, "$(typeof(a))(value = $(a.value), valence = $(a.valence), degree = $(a.degree), free = $(a.free))")
end

Base.(:(==))(a₁::AtomicUnit, a₂::AtomicUnit) = a₁.valence == a₂.valence
