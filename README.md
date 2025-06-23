# Artifact for Tabby

## Prerequisite

Make sure rust with version of `>=1.79' installed


## `Noir` Benchmarks

* cd to the directory `halo2_backend/`
* Run the following command:

    ```
    cargo test --package noir_halo2_backend_pse --lib -- tests::test::test_circuits_native 
    ```

## `Circom` Benchmarks

* cd to the directory `noir-halo2-backend/`
* Run the following command:
    
    ```
    cargo test tests::test::circom -- --nocapture
    ```

