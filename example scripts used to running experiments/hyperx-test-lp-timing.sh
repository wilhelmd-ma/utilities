#!/bin/bash

echo "Results:" >results-lp.txt
echo "" >result-tuples-lp.txt

iterations=50

# orig path to executable: /mnt/lrz/hyperx/hyperx/target/spark-hyperx-0.0.1-SNAPSHOT.jar
zeroLocality='/mnt/lrz/hyperx/self-compiled-versions/spark-hyperx-0.0.1-SNAPSHOT-locality-wait-0.jar'
largeLocality='/mnt/lrz/hyperx/self-compiled-versions/spark-hyperx-0.0.1-SNAPSHOT-locality-wait-10000000.jar'
origLocality='/mnt/lrz/hyperx/self-compiled-versions/spark-hyperx-0.0.1-SNAPSHOT-orig.jar'
defaultLocality='/mnt/lrz/hyperx/self-compiled-versions/spark-hyperx-0.0.1-SNAPSHOT-without-locality-config-param.jar'
exceptionThrowing='/mnt/lrz/hyperx/self-compiled-versions/spark-hyperx-0.0.1-SNAPSHOT-exception-throwing.jar'

#for executable in $zeroLocality $largeLocality $origLocality $defaultLocality; do
for executable in $origLocality; do
  echo "using exectuable:  $executable" >>result-tuples-lp.txt
  echo "using exectuable: $executable" >>results-lp.txt
  for dataset in hyperedges-mathoverflow-answers.txt com-orkut.top5000.cmty.txt; do #for dataset in com-orkut.top5000.cmty.txt
    echo "Dataset: $dataset" >>results-lp.txt
    echo "%Dataset: $dataset" >>result-tuples-lp.txt

    for partitionAlgo in Plain Greedy Bi Aweto Replica; do
#    for partitionAlgo in Aweto; do
      echo $partitionAlgo

      echo "\addplot coordinates{ " >>result-tuples-lp.txt

      #for numberOfPartitions in 5; do
      		for numberOfPartitions in 1 2 3 4 5; do
      #		for numberOfPartitions in 1 2 3 4 5 10 15 20 25; do
      #for numberOfPartitions in 1 10 20 30 40 50 60 70 80 90 100; do
              # for numberOfPartitions in 5 10; do

        start=$(date +%s.%N)
        echo "running lp with $iterations iterations on $dataset with $numberOfPartitions and partition algo $partitionAlgo"

        command="/opt/spark/bin/spark-submit \
		  		--master spark://172.24.33.87:7077  --num-executors 5 --total-executor-cores 10 --class org.apache.spark.hyperx.lib.Analytics \
		  		$executable \
		  		lp /mnt/datasets/$dataset --numPart=$numberOfPartitions --inputMode=list --separator=, --outputPath=/mnt/lrz/hyperx/output/lp-test/$dataset/$partitionAlgo/$numberOfPartitions --partStrategy=$partitionAlgo --maxIter=$iterations	"
        echo "running: "+ "$command"
        $command

        end=$(date +%s.%N)
        runtime=$(echo "$end - $start" | bc -l)

        log="lp with $iterations iterations and $partitionAlgo partitioning took $runtime s for $dataset with $numberOfPartitions partitions"
        echo $log
        echo $log >>results-lp.txt
        echo "($numberOfPartitions, $runtime) % $partitionAlgo $dataset" >>result-tuples-lp.txt
      done

      echo " };	\addlegendentry{lp ($iterations iterations, $partitionAlgo and $numberOfPartitions partitions}" >>result-tuples-lp.txt
    done
  done
done
