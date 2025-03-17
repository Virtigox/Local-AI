# Foundation of AI Hardware Requirements

The primary components required for AI workloads include processors (CPUs), accelerators (GPUs, TPUs, or specialized AI chips), memory (RAM), storage units, and adequate power and cooling systems. 

The use case and importance of each component will differ depending on whether the system is designed for training new models or running inference on pre-trained ones. In this case, we are focusing on **inference**—where the model takes input data (e.g., text) and generates output (e.g., predictions, responses).

---

# Relationship Between Model Parameters and Hardware Requirements

Model parameters (e.g., Llama 3.1 8B: 8 billion parameters), which represent the learned variables within an AI model, directly influence hardware requirements, particularly memory usage. 

- A 7 billion parameter model typically requires around **28GB of memory** when using full precision (FP32) or about **14GB** when using mixed precision (FP16). 
- However, distilled models are smaller and more efficient than their original counterparts. Additionally, there are smaller models,to make them feasible for devices with limited resources, they often utilize lower mixed precision and other optimization techniques. As a result, it is possible to run an 8 billion parameter model on **8GB of VRAM**, though this may come at the cost of reduced token production per second.

---

# VRAM Calculation Formula for Running LLMs
> To estimate the GPU memory (VRAM) required to run a large language model (LLM), use the following formula:  
$$\text{VRAM Required} = \text {Number of Parameters (in billions)} × \text{Bytes per Parameter} × \text{Overhead Factor}$$

This formula provides a reliable estimate of the **GPU memory needed** to load and run a model efficiently. Learn more [here](https://twm.me/posts/calculate-vram-requirements-local-llms/).  

**1. Number of Parameters**  
This represents the total number of model weights, typically expressed in **billions (B)**:  

- **LLaMA-13B** → 13 billion parameters  
- **DeepSeek-V2-67B** → 67 billion parameters  
- **GPT-4 (estimated)** → 1.76 trillion parameters  

---

## **2. Bytes per Parameter (Precision Level)**  
The amount of VRAM required **depends on the numerical precision** used for storing the model weights:  

| Precision | Bytes per Parameter | Notes |
|-----------|---------------------|-------|
| **FP32 (Full Precision)** | 4 bytes | High accuracy but very memory-intensive |
| **FP16 (Half Precision)** | 2 bytes | Common for GPUs with Tensor Cores |
| **INT8 (8-bit Quantization)** | 1 byte | Reduces memory, minor accuracy loss |
| **INT4 (4-bit Quantization)** | 0.5 bytes | Best for low VRAM usage, may impact performance |

> **Lower precision reduces memory usage but may slightly degrade accuracy.**  
> **FP16** is widely used on modern GPUs for an optimal balance of memory efficiency and precision.  

---

## **3. Overhead Factor**  
Additional VRAM is needed beyond just model weights to account for:  

- **Activations** (temporary tensors generated during inference)  
- **Framework overhead** (PyTorch, TensorFlow, etc.)  
- **GPU memory fragmentation**  

### **Recommended Overhead Factors**  

| Model Type | Overhead Factor |
|------------|----------------|
| **Text/Coding Models** | **1.15** (15% extra memory) |
| **Reasoning LLMs** | **1.25** (25% extra memory) |
| **Audio Models** | **1.30** (30% extra memory) |
| **Video Models** | **1.40** (40% extra memory) |

For most **LLM inference**, a **15% buffer (×1.15)** is sufficient.  

---

## **4. VRAM Calculation Examples**  

### **Example 1: Running `LLaMA-70B` in `FP16`**  
- **Model Size:** 70 billion parameters  
- **Precision:** FP16 (**2 bytes per parameter**)  
- **Overhead Factor:** **1.15** (15%)  
- VRAM Required = 70 × 2 × 1.15 = 161 GB

>  **INT4 quantization reduces VRAM usage by 75%, making the model fit into a 48GB GPU (e.g., RTX 6000 Ada, A100 40GB).**  

---

## **5. System RAM Considerations**  

### **What If VRAM Is Insufficient?**  
- If the **GPU VRAM is too low**, **LLMs use system RAM (swap memory or offloading)**, significantly reducing performance.  
- **32GB+ RAM** is preferable for running large models on CPU or when VRAM is limited.  

### **Unified Memory Architectures**  
Some hardware, such as **Apple’s M-series chips**, uses **Unified Memory**, where RAM is shared seamlessly between CPU & GPU. This reduces the need for explicit VRAM.  

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
