# Scheduling in OpenMP Parallel Programming Model

## Introduction
This project explores the implementation and optimization of a 3D Fast Fourier Transform (FFT) using the OpenMP parallel programming model. OpenMP, based on the Shared Memory Model, is widely used for multi-threaded parallelism in systems with shared memory abstraction, such as multi-core processors. This direct memory access between threads enables faster communication compared to distributed memory systems. The focus of this exploration is to understand and compare the scheduling modes provided by OpenMP and their impact on performance.

## Objectives
- Gain hands-on experience with the OpenMP library and scheduling techniques in high-performance computing (HPC).
- Investigate the limits and overheads of parallelization.
- Compare the impact of different OpenMP scheduling modes on the performance of a parallelized 3D FFT algorithm.

## Overview of Scheduling in OpenMP
OpenMP provides several scheduling modes for distributing loop iterations among threads during runtime. These scheduling modes significantly influence load balancing and performance:

### Static Mode
Iterations are divided into chunks at compile time and assigned to threads. This method minimizes runtime overhead and is generally faster when workloads are evenly distributed.
- **Syntax**: `#pragma omp parallel for schedule(static, chunk_size)`

### Dynamic Mode
Iterations are divided into chunks, and threads are assigned chunks dynamically during runtime. This mode ensures better load balancing, especially for uneven workloads, at the cost of higher overhead.
- **Syntax**: `#pragma omp parallel for schedule(dynamic, chunk_size)`

### Guided Mode
This is a variant of dynamic scheduling where larger chunks are allocated initially, and chunk sizes decrease as iterations progress. It combines the efficiency of static scheduling with the flexibility of dynamic scheduling.
- **Syntax**: `#pragma omp parallel for schedule(guided, chunk_size)`

## 3D Fast Fourier Transform (FFT) Algorithm
The implementation solves a 3D partial differential equation using FFTs. The algorithm leverages OpenMP to parallelize the computation, with tasks distributed among multiple threads.

### Key Steps:
1. **Initialization**:
   - Memory allocation for arrays storing transformed data and coefficients.
   - Setting initial conditions for the computation.

2. **Computation**:
   - Perform 1D FFTs in each dimension (x, y, z).
   - Transpose arrays to optimize memory access.
   - Evolve the system over multiple iterations.

3. **Parallelization**:
   - Tasks are distributed across multiple threads using OpenMP scheduling directives.
   - Timers are implemented to measure execution time for different phases (setup, FFT, evolution).

4. **Validation**:
   - Checksums are computed at each iteration to validate the accuracy of results.

## Experimentation
Two datasets are used to evaluate the performance of the algorithm:
- **Debug Dataset**:
  - Grid size: `64 × 64 × 64`
  - Iterations: `6`
- **Test Dataset**:
  - Grid size: `512 × 256 × 256`
  - Iterations: `20`

### Performance Metrics:
- Execution time for different scheduling modes (Static, Dynamic, Guided) and configurations.
- Speedup achieved by varying the number of threads.
- Load balancing efficiency across threads.

### Optimization:
- Modify scheduling policies and chunk sizes to minimize execution time.
- Record performance improvements and compare with baseline results.

## Infrastructure and Setup
- The project is designed to run on HPC clusters with OpenMP-compatible compilers and libraries pre-installed.
- Starter code and datasets are included in the repository.

### Steps to Run:
1. Clone the repository and navigate to the project directory.
2. Compile the code using the provided Makefile:
   ```bash
   make clean   # Remove prebuilt binaries
   make debug   # Compile for the debug dataset
   make test    # Compile for the test dataset
   ```
3. Execute the compiled binaries on an interactive HPC cluster node.
4. Adjust the number of threads by modifying the `THREADS` variable in the Makefile.

## Results and Analysis
1. **Loop Analysis**:
   - Identify loops in the code and record their execution times.

2. **Scheduling Comparison**:
   - Evaluate performance for Static, Dynamic, and Guided scheduling with varying chunk sizes.

3. **Optimization**:
   - Apply and analyze code optimizations to further reduce execution time.

### Visualization:
- Bar graphs illustrating speedup achieved with different scheduling policies and thread configurations.
- Comparisons normalized to the execution time of the serial version (`THREADS=1`).

## Conclusion
This project provides insights into the practical implementation and optimization of parallel algorithms using OpenMP. By exploring scheduling policies and their impact on performance, it highlights the trade-offs between load balancing and overhead in HPC systems. The findings can guide future efforts in designing efficient parallel applications.

---

## Repository Contents
- **Source Code**: `FT/ft.c`
- **Makefile**: For compilation
- **Datasets**: Debug and Test configurations
- **Validation**: Scripts and benchmarks

Feel free to contribute to this project or use it as a reference for similar parallel computing explorations!

