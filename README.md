# 0xByteKnight's Secure DevContainer

This development container is designed to safely run untrusted Solidity and Rust code while keeping your host system isolated. Built with security in mind, it incorporates a variety of state-of-the-art tools and hardened configurations. Inspired by The Red Guild's and Patric Collins's approaches to secure container setups, this container aims to streamline development while reducing risk.

> **Note:** This container is continuously evolving. Contributions, suggestions, and improvements are welcome!

## Requirements

1. **Visual Studio Code**  
   - Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
2. **Docker**  
   - Ensure Docker is installed and running.
   - For macOS (Silicon), be aware that some images (like `linux/amd64` based ones) may run under emulation.
3. **Command Line Tools**  
   - `docker-buildx` (for multi-architecture builds, if needed).

## Setup & Kick-off

1. **Start Docker:**  
   - Make sure Docker is running and your user is added to the `docker` group. You may need to log out and log back in after adding yourself.
2. **Clone the Repository:**  
   - Clone this repo to your local machine.
3. **Open with VS Code:**  
   - Open the repository folder in VS Code (`code .` works well).
4. **Reopen in Container:**  
   - When prompted, select **Reopen in Container**. VS Code will build the container according to the provided configuration.
5. **Initial Setup:**  
   - On the first run, you might need to press Enter in the terminal to kick off certain initialization scripts.

## Container Features

### Tooling & Languages

- **Solidity & Ethereum Tools**
  - *Compilers & Tools:* `solc-select`, `slither-analyzer`, `crytic-compile`, and Foundry (`forge`, `anvil`, `cast`)
  - *Fuzz Testing:* Prebuilt **Echidna** and integration with **ityfuzz**.
- **Rust Development**
  - Rust toolchain installed via `rustup` for seamless Rust development.
- **Additional Languages & Package Managers**
  - Support for JavaScript (npm, pnpm, yarn), Python, and more.
  - Multi-version management with tools like **asdf**, **nvm**, and **pipx**.

### Security & Isolation

- **Filesystem Isolation:**  
  - Workspace mounted as a `tmpfs` ensures that all changes are ephemeral.
- **Container Hardening:**  
  - **Read-only filesystems:** For directories not explicitly required to be writable.
  - **Capability Dropping:** All Linux capabilities are dropped (`--cap-drop=ALL`) to minimize privileged operations.
  - **Security Options:**  
    - `no-new-privileges` to prevent unexpected privilege escalation.
    - AppArmor profile (`apparmor:docker-default`) enforced.
    - Additional sysctl settings disable IPv6 and raw packet capabilities.
- **VS Code Settings:**  
  - **Workspace Trust Disabled:** (`"security.workspace.trust.enabled": false`) prevents automatic execution of tasks in untrusted workspaces.
  - **Telemetry Turned Off:** (`"telemetry.telemetryLevel": "off"`) avoids unwanted data sharing.

### Shell Environment

- **ZSH as the Default Shell:**  
  - Configured with essential autocompletions for tools like **medusa**, **anvil**, **cast**, and **forge**.

### Additional Repositories

- **building-secure-contracts:**  
  - A repository cloned into the workspace to provide examples and templates for secure Solidity development.

## Using the Container

Once inside the dev container:

- **Access the Terminal:**  
  - Your default shell is ZSH. All tools (Rust, Solidity compilers, fuzzers, analyzers) are in your PATH.
- **Leverage VS Code Extensions:**  
  - A curated set of extensions (like `juanblanco.solidity`, `trailofbits.slither-vscode`, `rust-lang.rust-analyzer`, etc.) is pre-installed for a smooth development experience.
- **Explore New Repositories:**  
  - Clone additional repositories into the ephemeral workspace if needed. All changes remain isolated unless explicitly mounted.

## Advanced Security Considerations

For those looking to push the security further, consider:

- **SELinux / AppArmor:**  
  - Enabling SELinux on your host and ensuring Docker is configured to leverage it.
- **Seccomp Profiles:**  
  - Customizing seccomp profiles to restrict system calls further.
- **Read-only Mode:**  
  - Experiment with `--read-only` mode to harden the filesystem. Remember to mount specific directories as writable if necessary.

## References & Further Reading

- **Where do you run your code?**  
  [The Red Guild Blog](https://blog.theredguild.org/where-do-you-run-your-code-part-ii-2/)
- **Related Projects:**  
  - [@Deivitto's auditor-docker](https://github.com/Deivitto/auditor-docker)
  - [@trailofbit's eth-security-toolbox](https://github.com/trailofbits/eth-security-toolbox)
- **Workshops:**  
  - [Build Your Own DevContainer Workshop](https://eth-security-explorations.notion.site/Come-and-build-your-own-devContainer-13b3c0d74d7f448f836419281d916369)

## Contributing

Contributions are welcome! If you have ideas or improvements to increase the security or functionality of this dev container, please submit a pull request or open an issue.

---

By combining advanced security settings with a robust set of development tools, this dev container offers a secure environment to explore and develop Solidity and Rust projects without compromising your host system.
