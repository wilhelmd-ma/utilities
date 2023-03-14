# converts a hypergraph given as edgelist into bipartite format

# input_file = "test.txt"
# input_file = "com-orkut.top5000.cmty.txt"
input_file = "hyperedges-mathoverflow-answers.txt"

input_path = "/Volumes/ga87yol/ma-fs/datasets/"
output_path = "./"

output = output_path + input_file.rstrip("txt") + "bipartite.txt"
input = input_path + input_file
print(output)
print(input)

edge_id = 0
with open(output, 'a') as o_file:
    with open(input, 'r') as infile:
        for line in infile:
            edge_id += 1
            split = line.strip().split(',')
            for vertex in split:
                print(edge_id)
                o_file.write(str(edge_id) + "," + vertex + "\n")
