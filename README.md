Here’s a comprehensive documentation tailored for **Linux**, **macOS**, and **Windows** users to set up and run your Neovim configuration from the repository: [https://github.com/9manhasan/nvim](https://github.com/9manhasan/nvim).

---

# **Introduction**
This repository provides a minimal, single-file Neovim configuration designed to be:

- **Lightweight**: Focused on essential tools and plugins.
- **Well-Documented**: Easy to understand and customize.
- **Extensible**: A starting point for your own Neovim setup, not a full-fledged distribution.

Whether you're new to Neovim or an experienced user, this configuration is designed to get you up and running quickly.

---

# **Installation**

## **1. Install Neovim**
Ensure you have the latest stable or nightly version of Neovim installed. If you encounter issues, update Neovim to the latest version.

### **Linux**
```bash
sudo apt update
sudo apt install neovim
```

### **macOS**
```bash
brew install neovim
```

### **Windows**
Download the latest release from the [Neovim GitHub page](https://github.com/neovim/neovim/releases) and follow the installation instructions.

---

## **2. Install External Dependencies**
Some plugins and tools require external dependencies. Install them before proceeding.

### **Basic Requirements**
- **Git**: For version control and plugin management.
- **ripgrep**: For fast searching (`rg`).
- **fd**: A simple and fast alternative to `find`.
- **fzf**: A fuzzy finder for Neovim plugins.
- **Nerd Fonts**: For icons in the UI (optional but recommended).

### **Install Dependencies**

#### **Linux**
```bash
sudo apt update
sudo apt install git ripgrep fd-find fzf tree-sitter nodejs python3 clang golang prettier eslint black flake8
# Install Nerd Fonts manually (e.g., Hack Nerd Font)
```

#### **macOS**
```bash
brew install git ripgrep fd fzf tree-sitter node python clang go prettier eslint black flake8 font-hack-nerd-font
```

#### **Windows**
```powershell
choco install git ripgrep fd fzf nodejs python clang golang prettier eslint black flake8
# Install Nerd Fonts manually (e.g., Hack Nerd Font)
```

---

## **3. Install the Configuration**
Clone this repository to your Neovim configuration directory.

### **Backup Existing Configuration**
If you already have a Neovim configuration, back it up:

#### **Linux/macOS**
```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

#### **Windows**
```powershell
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
```

### **Clone the Repository**

#### **Linux/macOS**
```bash
git clone https://github.com/9manhasan/nvim.git ~/.config/nvim
```

#### **Windows**
```powershell
git clone https://github.com/9manhasan/nvim.git $env:LOCALAPPDATA\nvim
```

---

# **Post Installation**

## **1. Start Neovim**
Launch Neovim to automatically install plugins:

#### **Linux/macOS**
```bash
nvim
```

#### **Windows**
```powershell
nvim
```

## **2. Plugin Management**
This configuration uses `lazy.nvim` for plugin management. After starting Neovim:
- Plugins will be installed automatically.
- Use `:Lazy` to view the plugin status and manage plugins.

---

# **Customization**
The configuration is designed to be easy to extend. Open the `init.lua` file in your Neovim configuration directory to:
- Add new plugins.
- Modify keybindings.
- Configure LSP servers and formatters.

---

# **Getting Started**
For more information on how to use and extend this configuration:
- Read the comments in the `init.lua` file.
- Check the documentation of individual plugins for advanced usage.

---

# **Support**
If you encounter any issues or have questions:
- Open an issue on the [GitHub repository](https://github.com/9manhasan/nvim/issues).
- Feel free to contribute by submitting pull requests.

---

Enjoy your Neovim setup! 🚀
