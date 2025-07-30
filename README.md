# Artifact for "Tabby: A Synthesis-Aided Compiler for High-Performance Zero-Knowledge Proof Circuits"

> Note: The main paper is under revision. Please only evaluate the [Getting Started](#getting-started) section of the artifact. We will submit a revised version that includes the additional benchmarks and experiments.


## Introduction

This directory contains the artifact for the OOPSLA 2025 submission "Tabby: A Synthesis-Aided Compiler for High-Performance Zero-Knowledge Proof Circuits".

## Hardware Dependencies
We have tested the artifact on a MacBook Pro (M1 Pro, 16 GB RAM) with macOS version 14.2.1.

## Getting Started

Note that due to the large size of the compiled circuits, we recommend running the benchmarks with at least 20 GB of free storage space.

To get started, simply build and run the docker image. This step might take 10-20 minutes.
```shell
docker build -t tabby:latest .
docker run --rm -it --entrypoint bash tabby
```
The container will start with working directory set to `/tabby`.

## Instructions

### Running the Tabby compiler
In the docker container,
```
cd ZKCompiler
eval $(opam env)
python3 run_all.py
```
This will run the Tabby compiler on *all* existing benchmarks, including both Noir and Circom benchmarks. If you see
```
▶️ Running benchmark 0 (1 / 16)
✅ Synthesis finished for benchmark 0 in 3.904s → saved to out/bench_0.txt
Circuit performance:  {'k': '6', 'num of rows': 25, 'num of columns': 5, 'proving time': '0.017261583', 'proof size': '384', 'verifying time': '0.002886208'}
```
it means:
1. Benchmark 0 has been successfully compiled into a Halo2 circuit
2. The proving time and other metrics were measured.

At this point, you can safely `CTRL+C` to stop the process (for kick-the-tires phase). The remaining benchmarks may take more than 1 hour to finish.

This will collect data for Table 1 (benchmark statistics), "Tabby" columns in Table 2, and "Tabby" columns in Table 3 of the paper.

### Running the Noir compiler

The following commands will run the Noir compiler on the Noir benchmark suite.
```shell
cd /tabby/halo2_backend/
cargo +1.82 test --package noir_halo2_backend_pse --lib -- tests::test::test_circuits_native 
```

Once you see
```
Downloading the Ignite SRS (65.5 KB)
Downloaded the SRS successfully!

Downloading the Ignite SRS (128 B)
Downloaded the SRS successfully!
...
Circuit witness successfully solved
Witness saved to /tabby/halo2_backend/crates/noir_halo2_backend_common/test_programs/0_fib/target/witness.tr
```
it means the Noir compiler has successfully compiled the first Noir benchmark (0_fib) into a Halo2 circuit, and the witness has been generated.
You can safely `CTRL+C` to stop the process (for kick-the-tires phase). The remaining benchmarks may take more than 1 hour to finish.

This will collect data for "Noir" columns in Table 2 of the paper.

### Running the Circom compiler

The following commands will run the Circom compiler on the Circom benchmark suite.
    
```shell
cd /tabby/noir-halo2-backend/
cargo +1.82 test tests::test::circom -- --nocapture -- --exact 
```

### Running the CirC compiler

The reviewers have requested us to compare Tabby against the CirC compiler. The following commands will run the Noir compiler on the Noir benchmark suite.
```shell
cd /tabby/noir-halo2-backend/
cargo +1.82 test tests::test::circ -- --nocapture -- --exact
```
