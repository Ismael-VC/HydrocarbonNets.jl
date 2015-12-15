abstract AtomicUnit{T}

const atoms_data = [
    #     Name   Symbol  Valence
    (:Hydrogen,  :H,     1),
    (  :Carbon,  :C,     4)
]

for (name, symbol, valence) in atoms_data
    @eval begin
        type $name{T<:Number} <: AtomicUnit{T}
            value::Complex{T}    # atomic value
            valence::Int         # number of valence electrons
            degree::Int          # number of shared valence electons
            free::Int            # number of free valence electrons

            $name(value) = new(value, $valence, 0, $valence)
        end

        typealias $symbol $name
        
        $name{T<:Real}(value::Complex{T}) = $name{T}(value)
        $name{T<:Real}(value::T) = $name(complex(value))
        $name() = $name(0.0)

        function promote_rule{T<:Real, S<:Real}(::Type{$name{T}}, ::Type{$name{S}})
            $name{promote_type(T, S)}
        end
    end
end

function Base.show(io::IO, a::AtomicUnit)
    print(io, "$(typeof(a))(value = $(a.value), valence = $(a.valence), degree = $(a.degree), free = $(a.free))")
end

Base.(:(==))(a₁::AtomicUnit, a₂::AtomicUnit) = a₁.valence == a₂.valence
