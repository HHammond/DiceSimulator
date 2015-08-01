
module Game

typealias Face Int32

immutable Faces 
    A_1::Face
    A_2::Face
    A_3::Face
    A_4::Face
    A_5::Face
    A_6::Face
end

type Die
    faces::Faces
end

function Die()
    unsafe_load(ccall((:new_die, "dice"), Ptr{Die}, ()))
end

function rand_die(lower::Int, upper::Int, total::Int)
    d = Die()
    get_die!(d, lower, upper, total)
    d
end

function simulate_game(d1::Die, d2::Die, max_score::Int)
    ccall((:simulate_game, "dice"), Int8, (Ptr{Die}, Ptr{Die}, Int32), &d1, &d2, max_score)
end

function get_die!(d::Die, lower::Int, upper::Int, total::Int)
    ccall((:get_die, "dice"), Nothing, (Ptr{Die}, Int32, Int32, Int32), &d, lower, upper, total)
    d
end

function play(d1::Die, d2::Die, n::Int)
    w = zeros(Int, 2)
    for i=1:n
        w[simulate_game(d1, d2, 100)] += 1
    end
    w
end

function best(d1::Die, d2::Die, n::Int)
    indmax(play(d1, d2, n))
end

function cmp_batch(dice::Array{Die, 1})
    n = length(dice)
    wins = zeros(Int, n)
    @inbounds for i = 1:n
        @simd for j = i+1:n
            v = best(dice[i], dice[j], 100)

            if v == 1
                wins[i] += 1
            else
                wins[j] += 1
            end
        end
    end
    dice[indmax(wins)]
end

function new_batch(n::Int)
    A = Array(Die, n)
    @inbounds @simd for i=1:n
        A[i] = rand_die(-10, 100, 60)
    end
    A
end

function get_best(d1::Die, d2::Die; n::Int=1000)
    best(d1, d2, n) == 1? d1 : d2
end

export Face, Die, Faces, simulate_game, get_die!, play, best, rand_die, new_batch, cmp_batch, get_best
end
