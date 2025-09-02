# 🚀 Terraform S3 Static Website — Sunil's Lab Project

Just me, Sunil, learning Terraform and doing my best not to break the cloud ☁️  
This repo deploys a static website to AWS S3 using Infrastructure as Code (IaC) with Terraform.

---

## 📦 Project Overview

This project sets up:
- A uniquely named S3 bucket for static website hosting
- Public access configuration with read-only permissions
- Website configuration for `index.html` and `error.html`
- Upload of HTML files from the `build/` folder
- Output of the live website URL

---

## 🛠️ Tech Stack

- **Terraform** (v1.x)
- **AWS S3**
- **HTML/CSS** (Gen Z–styled test page)
- Optional: GitHub for version control and portfolio hosting

---

## 🚀 How to Deploy

1. Clone this repo:
   ```bash
   git clone https://github.com/connect2sunil/terraform-s3-static-site.git
   cd terraform-s3-static-site
