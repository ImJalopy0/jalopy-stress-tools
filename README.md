![Jalopy Stress Tools Banner](https://raw.githubusercontent.com/ImJalopy0/jalopy-stress-tools/main/A_digital_graphic_design_features_the_centered_tex.png)
# 🚀 Jalopy Stress Tools

A professional suite of high-performance network stress testing and monitoring scripts, designed for private lab environments and controlled server testing.

---

# 📦 What's Included

| Script | Purpose |
|:-------|:--------|
| `jalopy_pinger.sh` | Real-time IP pinger and monitor |
| `megastress_spoofed.sh` | Mid-level network flood (spoofed) |
| `megastress_spoofed_failsafe.sh` | Mid-level flood with automatic protection |
| `nuclearbomb_spoofed.sh` | Heavy randomized flood (spoofed) |
| `nuclearbomb_spoofed_failsafe.sh` | Heavy flood with failsafe protection |
| `stressbomb.sh` | Light basic flood attack |
| `truechaosbomb.sh` | Dynamic chaos flooder that scales attacks over time |

---

# 🛠 Installation Guide

You can run these scripts on **Linux**, **WSL (Windows Subsystem for Linux)**, or directly on **Windows** if properly configured.

---

## 📜 Installing on Linux / WSL (Ubuntu)

1. **Clone the repository:**
    ```bash
    git clone https://github.com/ImJalopy0/jalopy-stress-tools.git
    cd jalopy-stress-tools
    ```

2. **Make all scripts executable:**
    ```bash
    chmod +x *.sh
    ```

3. **Install hping3 (required for flood scripts):**
    ```bash
    sudo apt update
    sudo apt install hping3
    ```

✅ You're ready to run the scripts!

---

## 📜 Installing on Windows CMD / PowerShell

**Option 1:** (Best way)  
✅ **Install WSL (Windows Subsystem for Linux)** and use Linux commands as shown above.

How:
```bash
wsl --install
