abstract AtomicUnit{T}

atoms = [
    #     Name   Symbol  Valence
    (:Hydrogen,  :H,     1),
    (  :Carbon,  :C,     4)
]

for (atom, sym, valence) in atoms
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

        typealias $sym $atom
    end
end

function Base.show(io::IO, a::AtomicUnit)
    print(io, "$(typeof(a))(value = $(a.value), valence = $(a.valence), degree = $(a.degree), free = $(a.free))")
end

Base.(:(==))(a₁::AtomicUnit, a₂::AtomicUnit) = a₁.valence == a₂.valence
