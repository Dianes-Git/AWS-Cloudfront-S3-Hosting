# 🌍 Deploying a Static Website on AWS Using Terraform  

## 📌 Overview  
This project automates the deployment of a **static website** on AWS using **Terraform**. It provisions:  
✅ **Amazon S3** for website hosting  
✅ **CloudFront** as a CDN for global distribution  for content delivery and HTTPS
✅ **IAM policies** for security  
✅ **Automatic file upload** from the `website/` folder  
✅ **Terraform Cloud** is used for remote state management to ensure consistency and collaboration.
Supports automatic deployment of website files to the S3 bucket



By the end, your website will be accessible via a **CloudFront URL**, with a simple design.

---
## Architecture Diagram
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

---
## Project Structure
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
git clone https://github.com/Dianes-Git/static-website-aws-terraform.git
cd static-website-aws-terraform
```

### ✅ **3. Configure Terraform Cloud
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

Then, log in to Terraform Cloud:

3️⃣ Configure AWS Credentials
Ensure you have AWS credentials configured:

sh
Copy
Edit
aws configure
You'll be prompted to enter:

AWS Access Key

AWS Secret Key

Default region (e.g., us-east-1)

4️⃣ Modify Website Files (Optional)
Customize the index.html inside the website/ folder to suit your needs.

🏗 Deploy the Infrastructure
5️⃣ Initialize Terraform
sh
Copy
Edit
terraform init
6️⃣ Validate Terraform Configuration
sh
Copy
Edit
terraform validate
7️⃣ Deploy with Terraform
sh
Copy
Edit
terraform apply --auto-approve
This will:
✅ Create an S3 bucket and enable website hosting
✅ Upload website files to S3 automatically
✅ Configure CloudFront for global content distribution
✅ Apply necessary IAM permissions

🔍 Verify Deployment
After successful deployment, Terraform will output the CloudFront URL:

makefile
Copy
Edit
Outputs:
cloudfront_url = "https://d123example.cloudfront.net"
Open this URL in your browser to view the deployed website.

🚀 Updating the Website
If you update the website/ folder (e.g., changing index.html):

sh
Copy
Edit
aws s3 sync website/ s3://<your-s3-bucket-name> --delete
Then invalidate the CloudFront cache:

sh
Copy
Edit
aws cloudfront create-invalidation --distribution-id <CloudFront-ID> --paths "/*" --output json

### 🛠 Destroy the Infrastructure
To remove all resources:

sh
Copy
Edit
terraform destroy --auto-approve
🛑 Troubleshooting Guide
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

sh
Copy
Edit
terraform destroy --auto-approve
terraform apply --auto-approve


📌 Next Steps
✅ Enhance website design with CSS
✅ Add a contact form using AWS Lambda
✅ Set up a custom domain with Route 53
✅ Set up a custom domain using Route 53
✅ Automate deployment with GitHub Actions



💡 Author: 
Diane Ihezue

🎉 Congratulations on deploying your first AWS-hosted static website using Terraform! 🚀
