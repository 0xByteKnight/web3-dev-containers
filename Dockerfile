# syntax=docker/dockerfile:1.8
# check=error=true

# Multi-stage build for Echidna.
FROM --platform=linux/amd64 ghcr.io/crytic/echidna/echidna:latest AS echidna

# Base debian build (latest).
FROM mcr.microsoft.com/vscode/devcontainers/base:debian

# Install essential packages and switch to root.
USER root
RUN apt-get update && apt-get install -y \
    zsh curl sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables for consistent paths.
ENV SHELL=/usr/bin/zsh \
    HOME=/home/vscode

# Switch shell to zsh.
SHELL ["/usr/bin/zsh", "-c"]

# Switch to non-root user.
USER vscode
WORKDIR ${HOME}

# Install Rust.
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc && \
    source $HOME/.cargo/env

# Install uv (and add to PATH) from the Astral project.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
ENV PATH="/home/vscode/.local/bin:$PATH"

# Install Solidity & Security Tools using uv.
RUN uv tool install solc-select && \
    uv tool install slither-analyzer && \
    uv tool install crytic-compile

# Install Foundry and Aderyn.
RUN curl -L https://foundry.paradigm.xyz | zsh && foundryup --version stable
RUN curl -L https://raw.githubusercontent.com/Cyfrin/aderyn/dev/cyfrinup/install | zsh && cyfrinup

# Copy Echidna binary into user's local bin.
COPY --chown=vscode:vscode --from=echidna /usr/local/bin/echidna ${HOME}/.local/bin/echidna
RUN chmod 755 ${HOME}/.local/bin/echidna

# Clean up.
USER root
RUN apt-get autoremove -y && apt-get clean -y
USER vscode
