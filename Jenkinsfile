pipeline{
    agent any
    stages{

        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
                bat "terraform init"
            }
        }
        stage("TF Validate"){
            steps{
                echo "idating Terraform Code"
                bat "terraform validate"
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
               
                bat "terraform plan"
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
                bat "terraform apply --auto-approve"
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
                bat 'aws lambda invoke --function-name lambda_fun --region ap-south-1 --log-type Tail out.json'
            }
        }
    }
}
