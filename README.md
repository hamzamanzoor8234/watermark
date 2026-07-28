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

## Prerequisites

Before running the application, make sure you have the following installed:
1. **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** (Make sure the Docker daemon is running)
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

## Configuration & Customization

- **Device Support**: The default run command in the `Dockerfile` uses `--device cuda`. If you do not have an NVIDIA GPU, you can change `"cuda"` to `"cpu"` in the `ENTRYPOINT` of the [Dockerfile](file:///c:/Users/Admin/Desktop/watermark/Dockerfile).
- **Default Model**: The container starts with the **LaMa** (`lama`) inpainting model, which is highly efficient for watermark and object removal.
- **Port Mapping**: If port `8085` is in use, you can update the ports mapping section in [docker-compose.yml](file:///c:/Users/Admin/Desktop/watermark/docker-compose.yml) and the URL in [run_iopaint.bat](file:///c:/Users/Admin/Desktop/watermark/run_iopaint.bat).
