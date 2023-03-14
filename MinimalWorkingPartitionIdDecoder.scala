trait PartitionStrategy {
  /** Returns the partition number for a given edge. */
  def getPartition(src: Long): Int
}

object PartitionStrategy {

   case object EdgePartition1D extends PartitionStrategy {
    override def getPartition(src: Long): Int = {
      val mixingPrime: Long = 1125899906842597L
      val partitionId = (math.abs(src * mixingPrime) % 4).toInt
    }
}


   case object Custom extends PartitionStrategy {
    override def getPartition(src: Long): Int = {
      val partitionId = src / 1000000
      partitionId.toInt
    }
  }

}    


object Hello {
    def main(args: Array[String]) = {
        println("Hello, world")
        
        var partitionStrategy = args(0) match {
             case "custom" => PartitionStrategy.Custom
             case "default"=> PartitionStrategy.EdgePartition1D   
        }

        println(partitionStrategy.getPartition(42000000))
        println(partitionStrategy.getPartition(5000000))
        println(partitionStrategy.getPartition(0))

    }
}
