# 🌍 Deploying a Static Website on AWS with S3, CloudFront, and Terraform  

## 📌 Project Overview 
This project automates the deployment of a **static website** on AWS using **Terraform**. It provisions:  
✅ **Amazon S3** for website hosting  
✅ **CloudFront** as a CDN for global distribution  for content delivery and HTTPS
✅ **IAM policies** for security  
✅ **Automatic file upload** from the `website/` folder  
✅ **Terraform Cloud** is used for remote state management to ensure consistency and collaboration.
Supports automatic deployment of website files to the S3 bucket


By the end, your website will be accessible via a **CloudFront URL**, with a simple design.

---
## 📐 Architecture Diagram
```sh
+------------------+
|  Terraform Cloud |
+------------------+
        |
        v
+------------------+
|   AWS S3 Bucket  |  (Stores Website Files)
+------------------+
        |
        v
+------------------+
|  AWS CloudFront  |  (Content Delivery Network)
+------------------+
        |
        v
+------------------+
|    End Users     |
+------------------+
```
---
## 📂 Project Structure
```sh
terraform-s3-cloudfront/
│── website/               # Static website files
│   ├── index.html         # Homepage file
│   ├── styles.css         # Styling for the website
│
│── backend.tf             # Terraform Cloud backend configuration
│── main.tf                # Terraform configuration for AWS resources
│── outputs.tf             # Terraform output variables
│── uploads.tf             # Handles file uploads to S3
│── variables.tf           # Defines Terraform variables
│── README.md              # Project documentation
```
---
## 🛠 Technologies Used  
- **Terraform** → Infrastructure as Code (IaC)  
- **AWS S3** → Static file storage  
- **AWS CloudFront** → Content delivery network (CDN)  
- **AWS IAM** → Access control

---

## 🏗 Project Setup  

### ✅ **1. Prerequisites**  
Ensure you have the following installed:  
🔹 **Terraform** → [Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)  
🔹 **AWS CLI** → [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)  
🔹 **An AWS Account** with IAM permissions  
🔹 **Terraform Cloud account** ([Sign Up](https://app.terraform.io/signup))

### ✅ **2. Clone the Repository**  
```sh
git clone https://github.com/Dianes-Git/AWS-Cloudfront-S3-Hosting.git
```

### ✅ **3. Configure Terraform Cloud**
Ensure Terraform Cloud is set up by configuring the backend.tf file:
```sh
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "<YOUR_TERRAFORM_ORG>"
    workspaces {
      name = "<YOUR_TERRAFORM_WORKSPACE>"
    }
  }
}
```
Edit: Replace <YOUR_TERRAFORM_ORG> with your Terraform Cloud organization name and <YOUR_TERRAFORM_WORKSPACE> with the workspace name you created in Terraform Cloud.

### ✅ **4. Set Up AWS Credentials in Terraform Cloud**
1️⃣ Navigate to Terraform Cloud, Select your organization and workspace (<YOUR_WORKSPACE_NAME>).

2️⃣ Open Variables Settings

In the workspace, go to the Variables tab.

3️⃣ **Add AWS Credentials as Environment Variables**  

   | **Variable Name**        | **Value**                | **Category**          | **Sensitive** |
   |-------------------------|-------------------------|----------------------|--------------|
   | `AWS_ACCESS_KEY_ID`     | `<YOUR_AWS_ACCESS_KEY>` | Environment Variable  | ✅            |
   | `AWS_SECRET_ACCESS_KEY` | `<YOUR_AWS_SECRET_KEY>` | Environment Variable  | ✅            |
   | `AWS_REGION`            | `<YOUR_AWS_REGION>`     | Environment Variable  | ❌ (Optional) |

4️⃣ Click Save and ensure all variables are correctly added.

Now, when Terraform runs in Terraform Cloud, it will automatically use these credentials.

Then, log in to Terraform Cloud:
```sh
terraform login
```

### ✅ **4. Configure AWS Credentials**
Ensure you have AWS credentials configured:

```sh
aws configure
```
You'll be prompted to enter:

AWS Access Key

AWS Secret Key

Default region (e.g., us-east-1)

### ✅ **5. Modify Website Files (Optional)**
Customize the index.html inside the website/ folder to suit your needs.

### ✅ **6. Deploy the Infrastructure**
 Initialize Terraform
```sh
terraform init
```
Validate Terraform Configuration
```sh
terraform validate
```
Deploy with Terraform
```sh
terraform apply --auto-approve
```
This will:
✅ Create an S3 bucket and enable website hosting
✅ Upload website files to S3 automatically
✅ Configure CloudFront for global content distribution
✅ Apply necessary IAM permissions

### ✅ **7. Verify Deployment**
After successful deployment, Terraform will output the CloudFront URL:
```sh
Outputs:
cloudfront_url = "https://d123example.cloudfront.net"
```
Open this URL in your browser to view the deployed website.

### ✅ **8. Updating the Website**
If you update the website/ folder (e.g., changing index.html):

```sh
aws s3 sync website/ s3://<your-s3-bucket-name> --delete
```

Then invalidate the CloudFront cache:
```
aws cloudfront create-invalidation --distribution-id <CloudFront-ID> --paths "/*" --output json
```

### ✅ **9. 🧹 Cleanup: Destroy the Infrastructure (Optional)**
To remove all resources:

```sh
terraform destroy --auto-approve
```
---
## 📸 Screenshots for Documentation
### 1. **S3 Bucket Permissions**
<img width="1268" alt="S3 Bucket Policy" src="https://github.com/user-attachments/assets/ef446d34-95d7-472d-b669-0b9f4f73e15b" />

### 2. **S3 Bucket Website Configuration**
<img width="1275" alt="S3 Static Website Hosting" src="https://github.com/user-attachments/assets/9ded3a01-07ba-47a5-85a1-c63a03cce439" />

### 3. **CloudFront Distribution Setup**
<img width="1276" alt="CloudFront Distribution Setup" src="https://github.com/user-attachments/assets/a3b7ba47-c6cf-4afb-aa38-6e339ac73d9c" />

### 4. **Website Live on CloudFront**
<img width="1272" alt="Live Website" src="https://github.com/user-attachments/assets/f2e270a0-89e8-43b1-bd95-85e87a65a000" />

### 5. **Terraform Apply Output**
<img width="1280" alt="Terraform Apply Execution" src="https://github.com/user-attachments/assets/164866af-d1c8-4b3b-a3c4-0cf17d5a2160" />

### 6. **Terraform Cloud Integration**
<img width="1271" alt="Terraform Cloud Integration" src="https://github.com/user-attachments/assets/92ab3df6-7d24-4f7a-a40a-ac273f748304" />

### 7. **Terraform Destroy Execution**
<img width="1280" alt="Terraform Destroy Execution" src="https://github.com/user-attachments/assets/c494c592-407b-4c1a-aa1b-c1f828e32b88" />


---
### 🛑 Troubleshooting Guide
❌ 1. Access Denied on S3 Files
Issue: You see an XML error: Access Denied.

Solution:

Ensure S3 bucket policy allows CloudFront access.

Check if OAC is enabled in CloudFront.

```sh
aws cloudfront get-distribution --id <distribution_id> --query "Distribution.DistributionConfig.Origins.Items[0].S3OriginConfig.OriginAccessIdentity"
```
If empty, update your CloudFront settings.

❌ 2. Website Not Displaying After Deployment
🔹 Problem: CloudFront returns a 403 error.
🔹 Solution: Ensure index.html exists in the bucket.
Invalidate the CloudFront cache:

```sh
aws cloudfront create-invalidation --distribution-id <distribution_id> --paths "/*"
```

❌ 3. CloudFront Not Showing Updates
🔹 Problem: You updated index.html, but CloudFront still serves the old version.
🔹 Solution: Run:

```sh
aws cloudfront create-invalidation --distribution-id <CloudFront-ID> --paths "/*"
```

❌ 4. Terraform Apply Fails with Missing Resource Error
🔹 Problem: Terraform fails because it can't find a resource.
🔹 Solution: Destroy and reapply everything:

```sh
terraform destroy --auto-approve
terraform apply --auto-approve
```

---
## 🎯 Why This Project Stands Out
This project demonstrates:

✅ Infrastructure as Code (IaC) – Everything is deployed using Terraform, ensuring consistency and repeatability. No manual setup needed!

✅ Scalability & Performance – By leveraging AWS S3 and CloudFront, the website benefits from high availability, low latency, and global content delivery.

✅ Automation with Terraform Cloud – Using a backend.tf file, the project integrates with Terraform Cloud, enabling remote state management and team collaboration.

✅ Security Best Practices – The S3 bucket is private, with access restricted via CloudFront’s Origin Access Control (OAC), preventing direct exposure.

✅ Simple Yet Elegant Design – Instead of a plain white page, the website includes a styled UI with colors, making it visually appealing while remaining lightweight.

✅ Hands-on DevOps Experience – This project is a great showcase of using Terraform, AWS services, and cloud automation, making it highly relevant for cloud engineers and DevOps professionals.

---
📌 Next Steps
✅ Enhance website design with CSS
✅ Adding a contact form using AWS Lambda
✅ Setting up a custom domain with Route 53
✅ Automate deployment with GitHub Actions

---
👩‍💻 Author

Diane Ihezue

DevOps & Cloud Engineer 

🎉 Congratulations on deploying your first AWS-hosted static website using Terraform! 🚀
