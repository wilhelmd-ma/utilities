# this script encodes the partitioning results of MESH into the bipartite hypergraph with a given offest
# e.g. vertex 3 assigned to partition 5 and an offset of 6 figures results in the new vertex id 5000003


# input_file = "test.txt"
# input_file = "com-orkut.top5000.cmty.txt"
input_dir = "/Volumes/ga87yol/ma-fs/datasets/orkut"
graph_file = "com-orkut.top5000.cmty.bipartite.spaced.txt"
numberOfPartitions = 5
partitionOffset = 1000000

dict = {}  # id, partition


def getNewId(id, partition):
    return partitionOffset * (partition + 1) + id


for i in range(0, numberOfPartitions):
    print("reading partition:", i)
    file_name = input_dir + '/' + graph_file + '_partition_' + str(i)
    with open(file_name, 'r') as infile:
        for line in infile:
            if ('id' in line) or ('nodes' in line):
                continue
            print(int(line))
            dict[int(line)] = i

print('done reading all partitions')

with open(input_dir + '/' + graph_file + 'new_ids', 'a') as o_file:
    with open(input_dir + '/' + graph_file, 'r') as infile:
        for line in infile:
            print("processing" + line)
            (v_id, e_id) = line.rstrip().split(' ')
            o_file.write(str(getNewId(int(v_id), dict[int(v_id)])) + " " + e_id + "\n")

pribnt('done writing graph')
