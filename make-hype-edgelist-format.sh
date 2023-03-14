#!/bin/bash

# HYPE requires the edgelist to have every line prefixed with the partition id.
# This script adds the linenumber as partitionId to every line

#dataset = hyperedges-mathoverflow-answers.txt
dataset=com-orkut.top5000.cmty.txt 
#dataset=test.txt
output=/mnt/lrz/datasets/$dataset'.hyperx.txt'
echo "" > $output
linenumber=0
echo "processing file:" $dataset
echo "output:" $output

while IFS= read -r line; do
    echo $linenumber': '$line
    echo $linenumber': '$line >> $output
    ((linenumber=linenumber+1))
done < /mnt/lrz/datasets/$dataset