# 🐳 Uptime Kuma Docker

Uptime Kuma’s official Docker images aren’t updated very often — so I decided to take matters into my own hands.

This repository automatically builds and publishes the latest Uptime Kuma Docker image from the official source code at louislam/uptime-kuma￼ every hour, or whenever new commits are detected.

## 📦 Image

All images are published to GitHub Container Registry (GHCR):

`ghcr.io/amirparsadd/uptimekuma:latest`

### 🔄 Automatic Updates
-	Checks for new commits on the upstream louislam/uptime-kuma repository every hour
-	Builds a fresh Docker image when changes are found
-	Pushes the image to GHCR automatically

## 🚀 How to Use

Pull the image:
docker pull ghcr.io/amirparsadd/uptimekuma:latest

Run it:
`docker run -d -p 3001:3001 –name uptime-kuma ghcr.io/amirparsadd/uptimekuma:latest`

## 🛠️ Why

The official image sometimes lags behind the source repository.
This build keeps everything up to date, built directly from the latest commits.

---

💡 This is not an official Uptime Kuma project. All credit goes to Louis Lam￼ and contributors.