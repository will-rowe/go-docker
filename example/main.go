/*
A basic program to use openMPI via the Go-bindings by marcus thierfelder
*/
package main

import (
	"fmt"
	"github.com/marcusthierfelder/mpi"
)

func main() {
	mpi.Init()
	worldSize := mpi.Comm_size(mpi.COMM_WORLD)
	rank := mpi.Comm_rank(mpi.COMM_WORLD)
	fmt.Printf("Hello world from a processor: rank %d out of %d processors\n", rank, worldSize)
	mpi.Finalize()
}
