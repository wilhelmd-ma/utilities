#!/bin/bash

echo "Results:" >results-lp.txt
echo "" >result-tuples-lp.txt

iterations=25

  for dataset in hyperedges-mathoverflow-answers.txt com-orkut.top5000.cmty.txt; do #for dataset in com-orkut.top5000.cmty.txt
    echo "Dataset: $dataset" >>results-lp.txt
    echo "%Dataset: $dataset" >>result-tuples-lp.txt

#    for partitionAlgo in Plain Greedy Bi Aweto Replica; do
 for partitionAlgo in 1D-src 1D-dst 2D GreedySrc GreedyDst HybridSrc HybridDst; do
#  for partitionAlgo in 2D; do
      echo $partitionAlgo

      echo "\addplot coordinates{ " >>result-tuples-lp.txt

      #   for numberOfPartitions in 1 2 3 4 5
    	#	for numberOfPartitions in 10 15 25 ; do 
    	for numberOfPartitions in 1 2 3 4 5 10 15 20 25; do
      #for numberOfPartitions in 1 10 20 30 40 50 60 70 80 90 100; do
        #        for numberOfPartitions in 5 10; do

        start=$(date +%s.%N)
        echo "running lp on MESH with $iterations iterations on $dataset with $numberOfPartitions "

        command="/home/ubuntu/tmp/spark/bin/spark-submit --num-executors 3 --total-executor-cores 6 --class umn.dcsg.examples.LabelPropagationRunner /mnt/lrz/mesh-scripts/examples-1.0-SNAPSHOT-jar-with-dependencies.jar "/mnt/datasets/com-orkut.top5000.cmty.bipartite.txt" -1 $partitionAlgo $numberOfPartitions $iterations 1 1 1"
        echo "running: "+ "$command"
        $command

        end=$(date +%s.%N)
        runtime=$(echo "$end - $start" | bc -l)

        log="lp with $iterations iterations on MESH and $partitionAlgo partitioning took $runtime s for $dataset with $numberOfPartitions partitions"
        echo $log
        echo $log >>results-lp.txt
        echo "($numberOfPartitions, $runtime) % $partitionAlgo $dataset" >>result-tuples-lp.txt
      done

      echo " };	\addlegendentry{lp ($iterations iterations, $partitionAlgo and $numberOfPartitions partitions}" >>result-tuples-lp.txt
    done
  done
