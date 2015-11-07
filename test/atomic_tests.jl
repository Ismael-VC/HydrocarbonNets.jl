# test atomic units equiality based in valence
let equality_tests = [
        crash!!!!
        :((C().valence == H().valence) == false)
        :((H().valence == H().valence) == true)
        :((C() == H()) == false)
        :((C() == C()) == true)
        :((C(10) == H(10)) == false)
        :((C(10) == C(15)) == true)
    ]
    for test in equality_tests
        @eval @test $test
    end
end

# test atomic units constructors against every native numeric type
let n = 1
    nums_data = [
        (int8(n), Int8),
        (uint8(n), Uint8),
        (int16(n), Int16),
        (uint16(n), Uint16),
        (int32(n), Int32),
        (uint32(n), Uint32),
        (int64(n), Int64),
        (uint64(n), Uint64),
        (int128(n), Int128),
        (uint128(n), Uint128),
        (true, Bool),
        (complex(true, true), Bool),
        (float16(n), Float16),
        (float32(n), Float32),
        (float64(n), Float64),
        (BigInt(n), BigInt),
        (BigFloat(n), BigFloat),
        (n//n, Rational{Int}),
        (n//n + n//big(n)*im, Rational{BigInt}),
        (n+n*im, Int),
        (Inf*im, Float64)
    ]
    for (value, T) in nums_data
        @test Carbon{T} == typeof(C(value))
    end
end
