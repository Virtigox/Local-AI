# Foundation of AI Hardware Requirements

The primary components required for AI workloads include processors (CPUs), accelerators (GPUs, TPUs, or specialized AI chips), memory (RAM), storage units, and adequate power and cooling systems. 

The use case and importance of each component will differ depending on whether the system is designed for training new models or running inference on pre-trained ones. In this case, we are focusing on **inference**—where the model takes input data (e.g., text) and generates output (e.g., predictions, responses).

---

# Relationship Between Model Parameters and Hardware Requirements

Model parameters (e.g., Llama 3.1 8B: 8 billion parameters), which represent the learned variables within an AI model, directly influence hardware requirements, particularly memory usage. 

- A 7 billion parameter model typically requires around **28GB of memory** when using full precision (FP32) or about **14GB** when using mixed precision (FP16). 
- However, distilled models are smaller and more efficient than their original counterparts. Additionally, there are smaller models,to make them feasible for devices with limited resources, they often utilize lower mixed precision and other optimization techniques. As a result, it is possible to run an 8 billion parameter model on **8GB of VRAM**, though this may come at the cost of reduced token production per second.

---

# Hardware Requirements for AI Use

For those experimenting with AI or running smaller models with limited performance but functional workflows, a basic hardware configuration can serve as an entry point without significant investment. 

These systems primarily rely on **CPU processing** with minimal or no GPU acceleration, making them suitable for educational purposes or simple inference tasks.

## CPU-Based Processing for Small Models

- **Recommended CPU**: Intel Core i5 10th generation or newer, or AMD Ryzen 5 3600 (or equivalent)
- CPUs can efficiently handle inference for optimized and lightweight models.
- **System memory**: 8GB minimum, though 16GB is strongly recommended.
- **Storage**: 50GB of free space, preferably on an SSD, to minimize data loading latencies.
- **Performance**: CPU-based inference operates slower than GPU-accelerated processing, with small language models (1–3 billion parameters) running acceptably but with response times measured in seconds rather than milliseconds.
- These systems are not suitable for training or fine-tuning operations.

## GPU-Accelerated Processing for Mid-Sized Models

- Dedicated GPU acceleration significantly improves performance for both inference and limited training tasks.
- **Recommended CPU**: Intel Core i7 12th generation, or AMD Ryzen 7 5800X
- **Recommended GPU**: NVIDIA RTX 3060 (12GB VRAM or 8GB VRAM for 8-7B models) or AMD RX 6800
- **System memory**: 32GB RAM to support data preprocessing and model operations.
- **Storage**: At least 200GB on NVMe SSDs to accommodate larger models, datasets, and intermediate files.

## Professional-Grade Components for Large-Scale AI

Professional-grade systems are designed for training large models, running multiple complex inference workloads simultaneously, or efficiently handling extremely large parameter models.

- **Recommended CPU**: Intel Core i9 13th generation, or AMD Ryzen 9 7950X
- **Recommended GPU**: NVIDIA RTX 4090 (24GB VRAM), NVIDIA A100 (40GB or 80GB VRAM), or AMD MI250
- **System memory**: Minimum of 64GB, with 128GB or more recommended for optimal performance, especially with large datasets.
- **Storage**: At least 1TB of high-speed NVMe storage, with additional capacity for datasets and model checkpoints.

---

# Important Notes

- This documentation is provided for personal exploration and educational purposes.
- Training and fine-tuning AI models from scratch require more resources and technical expertise, and that is not the focus here.
- The main goal is to help you get your own AI models running locally, isolated from the internet, to better understand how large language models (LLMs) work.
