@everywhere using Game, TimeIt

batch_size = 1000
num_batches = 200

tic()

batches = {new_batch(batch_size) for i=1:num_batches}
picks = pmap(cmp_batch, batches) |> (l) -> convert(Array{Die, 1}, l)

display(picks)

die = cmp_batch(picks)

print("\n\n")
toc()
print("\n\n")
print("Best Pick:\n")

@show die

