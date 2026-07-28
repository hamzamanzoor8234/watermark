FROM pytorch/pytorch:2.2.1-cuda12.1-cudnn8-runtime

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TORCH_HOME=/app/cache/torch
ENV HF_HOME=/app/cache/huggingface

# Install system dependencies for OpenCV and image operations
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install iopaint
RUN pip install --no-cache-dir --default-timeout=1000 iopaint

# Set the working directory
WORKDIR /app

# Expose port
EXPOSE 8080

# Run native iopaint start on container launch
ENTRYPOINT ["iopaint", "start", "--host", "0.0.0.0", "--port", "8080", "--device", "cuda", "--model", "lama"]
