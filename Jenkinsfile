pipeline{
    agent any
    stages{

        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
                sh "terraform init"
            }
        }
        stage("TF Validate"){
            steps{
                echo "idating Terraform Code"
                sh "terraform validate"
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
                sh "terraform untaint aws_route_table.route_table1"
                sh "terraform untaint aws_security_group.example01"
                sh "terraform plan"
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
                sh "terraform apply --auto-approve"
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
                sh 'aws lambda invoke --function-name lambda --region ap-south-1 --log-type Tail'
            }
        }
    }
}
