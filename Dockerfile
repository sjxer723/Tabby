ARG UBUNTU_NAME=jammy
ARG UBUNTU_VERSION=22.04
FROM ubuntu:$UBUNTU_VERSION as dev

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /tabby
WORKDIR /tabby

RUN apt-get update && \
    apt-get --yes install --no-install-recommends \
    # General-needed
    python-is-python3 python3 python3-pip vim wget

RUN apt-get install -y m4 opam libgmp3-dev pkg-config
RUN apt-get --yes install bubblewrap git

# Install Rust
RUN apt-get update && \
    apt-get --yes install --no-install-recommends \
    # Required by rust
    curl libffi-dev
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain 1.80.0 -y
ENV CARGO_PATH=/root/.cargo/bin
ENV PATH=${PATH}:${CARGO_PATH}



# Set up OCaml
RUN opam init -y --disable-sandboxing --bare
RUN opam switch create 5.1.1 ocaml-variants.5.1.1+options
RUN eval $(opam env)
RUN opam install -y dune

COPY . /tabby
WORKDIR ZKCompiler
ENV OPAM_PATH=/root/.opam/5.1.1/bin
ENV PATH=${PATH}:${OPAM_PATH}
RUN echo ${PATH}
RUN opam install . -y --deps-only || true
RUN eval $(opam env)
RUN pip3 install pandas
RUN (cd polyexen; cargo build --release)


WORKDIR /tabby

# Install Circom
RUN rustup install 1.80
RUN git clone https://github.com/iden3/circom.git
RUN (cd circom; cargo +1.80 build --release; cargo +1.80 install --path circom)

