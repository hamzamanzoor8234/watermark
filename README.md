# Watermark Remover & Image Inpainting (IOPaint)

This repository provides a self-hosted, Dockerized environment for running **IOPaint** (powered by PyTorch and the LaMa model). It is designed to run locally with GPU acceleration (CUDA) support to easily remove watermarks, objects, or text from images.

---

## Features

- **Local & Private**: All image processing runs entirely on your local machine.
- **CUDA Acceleration**: Built on top of the PyTorch CUDA runtime for high-performance GPU processing.
- **Persistent Caches**: Keeps HuggingFace and PyTorch model weights saved on your host machine under the `cache/` directory to avoid re-downloading them every time you restart the container.
- **Conflict-free Port Mapping**: Configured to run on port `8085` by default to avoid conflicts with other local development servers running on port `8080`.

---

## File Structure

```text
watermark/
├── cache/                  # Persisted ML model weights (Git ignored)
│   ├── torch/
│   └── huggingface/
├── images/                 # Local directory mapped to container for processing (Git ignored)
├── Dockerfile              # Builds the GPU-enabled PyTorch container with IOPaint
├── docker-compose.yml      # Orchestrates the container volumes, GPU access, and ports
├── run_iopaint.bat         # Windows batch script to launch, open, and teardown IOPaint
├── .gitignore              # Ignores large model weights, local images, and virtual envs
└── README.md               # This documentation file
```

---

## System Requirements & Prerequisites

### Minimum System Specifications
* **Operating System**: Windows 10/11 (with WSL2 enabled) or Linux.
* **GPU (Graphics Card)**: NVIDIA GPU with CUDA support (Minimum **4GB VRAM**; 6GB+ recommended).
* **System RAM**: Minimum **8GB** (16GB recommended).
* **Storage Space**: At least **10GB** of free disk space (for the base PyTorch CUDA docker image and cached ML models).

### Prerequisites
Before running the application, make sure you have the following installed:
1. **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** (Ensure the Docker daemon is running)
2. **[NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)** (Required for GPU/CUDA support inside Docker)

---

## How to Run

### Method 1: Using the Windows Batch Script (Recommended)
Simply double-click the **`run_iopaint.bat`** file or run it in your terminal:
```cmd
run_iopaint.bat
```
This script will:
1. Automatically build and start the Docker container in the background.
2. Wait a few seconds for the server to spin up.
3. Open your default web browser to the interface at `http://localhost:8085`.
4. Press any key in the console to stop and remove the container when you are done.

---

### Method 2: Manual Commands
If you prefer running commands manually:

1. **Build and start the container:**
   ```bash
   docker compose up -d --build
   ```
2. **Access the application:**
   Open your browser and navigate to:
   [http://localhost:8085](http://localhost:8085)

3. **Stop the container:**
   ```bash
   docker compose down
   ```

---

## Running on Linux and macOS

Yes, this repository can be run on Linux and macOS. 

### 1. On Linux (with NVIDIA GPU)
The setup is identical to Windows:
- Run the setup script:
  ```bash
  chmod +x run_iopaint.sh
  ./run_iopaint.sh
  ```
- Or run manually: `docker compose up -d --build`

### 2. On macOS (or systems without an NVIDIA GPU)
Docker on macOS does not support NVIDIA GPU acceleration (CUDA). You have two options:

#### Option A: Run inside Docker (CPU Only)
To run the container on CPU:
1. Open [docker-compose.yml](file:///c:/Users/Admin/Desktop/watermark/docker-compose.yml) and remove or comment out the `deploy.resources.reservations` block (lines 9–15).
2. Open the [Dockerfile](file:///c:/Users/Admin/Desktop/watermark/Dockerfile) and change `--device cuda` to `--device cpu` on line 24.
3. Build and start:
   ```bash
   chmod +x run_iopaint.sh
   ./run_iopaint.sh
   ```

#### Option B: Run natively on macOS Host (Apple Silicon GPU / MPS support)
For high-performance GPU acceleration on Apple Silicon (M1/M2/M3), run IOPaint natively using Python on your host machine instead of Docker:
1. Install Python 3.10 or 3.11.
2. Install IOPaint and PyTorch:
   ```bash
   pip install iopaint torch torchvision
   ```
3. Start the server (which natively utilizes Apple Silicon GPU acceleration via `--device mps`):
   ```bash
   iopaint start --host 127.0.0.1 --port 8085 --device mps --model lama
   ```
4. Visit `http://localhost:8085` in your browser.

---

## Configuration & Customization

- **Default Model**: The container starts with the **LaMa** (`lama`) inpainting model, which is highly efficient for watermark and object removal.
- **Port Mapping**: If port `8085` is in use, you can update the ports mapping section in [docker-compose.yml](file:///c:/Users/Admin/Desktop/watermark/docker-compose.yml), [run_iopaint.bat](file:///c:/Users/Admin/Desktop/watermark/run_iopaint.bat), and [run_iopaint.sh](file:///c:/Users/Admin/Desktop/watermark/run_iopaint.sh).
