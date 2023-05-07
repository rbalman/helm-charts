resource "aws_cloudformation_stack" "network" {
  name = "networking-stack"

  parameters = {
    PrivateSubnetAZ1 = module.vpc.private_subnets[0]
    PrivateSubnetAZ2 = module.vpc.private_subnets[1]

    PublicSubnetAZ1 = module.vpc.public_subnets[0]
    PublicSubnetAZ2 = module.vpc.public_subnets[1]

    VpcId = module.vpc.vpc_id

    VpcCidr = module.vpc.vpc_cidr_block

    EnvironmentName = var.EnvironmentName
  }

  template_body = <<STACK
---
Parameters:
  EnvironmentName:
    Type: String
    Description: Name of the environment
  VpcId:
    Type: String
    Description: ID of VPC
  VpcCidr:
    Type: String
    Description: VPC IPV4 CIDR
  PrivateSubnetAZ1:
    Type: String
    Description: Private Subnet AZ1
  PrivateSubnetAZ2:
    Type: String
    Description: Private Subnet AZ2
  PublicSubnetAZ1:
    Type: String
    Description: Private Subnet AZ1
  PublicSubnetAZ2:
    Type: String
    Description: Private Subnet AZ2
Conditions:
  Never:
    Fn::Equals:
    - A
    - B
Resources:
  NonResource:
    Type: Custom::NonResource
    Condition: Never
Outputs:
  PrivateSubnetAZ1:
    Value: !Ref PrivateSubnetAZ1
    Export: 
      Name: !Sub '$${EnvironmentName}:SubnetAZ1Private'
  PrivateSubnetAZ2:
    Value: !Ref PrivateSubnetAZ2
    Export: 
      Name: !Sub '$${EnvironmentName}:SubnetAZ2Private'
  PublicSubnetAZ1:
    Value: !Ref PublicSubnetAZ1
    Export: 
      Name: !Sub '$${EnvironmentName}:SubnetAZ1Public'
  PublicSubnetAZ2:
    Value: !Ref PublicSubnetAZ2
    Export: 
      Name: !Sub '$${EnvironmentName}:SubnetAZ2Public'
  LambdaPrivateSubnetAZ1:
    Value: !Ref PrivateSubnetAZ1
    Export:
      Name: !Sub '$${EnvironmentName}:LambdaSubnetAZ1Private'
  LambdaPrivateSubnetAZ2:
    Value: !Ref PrivateSubnetAZ2
    Export:
      Name: !Sub '$${EnvironmentName}:LambdaSubnetAZ2Private'
  VpcId:
    Value: !Ref VpcId
    Export: 
      Name: !Sub '$${EnvironmentName}:VPC'
  CidrBlock:
    Value: !Ref VpcCidr
    Export: 
      Name: !Sub '$${EnvironmentName}:CidrBlock'
  SecondaryCidrBlock:
    Value: !Ref VpcCidr
    Export: 
      Name: !Sub '$${EnvironmentName}:SecondaryCidrBlock'
  IAMStatefulSubnetAZ1Private:
    Value: !Ref PrivateSubnetAZ1
    Export: 
      Name: !Sub "$${EnvironmentName}:iam:StatefulSubnetAZ1Private"
  IAMStatefulSubnetAZ2Private:
    Value: !Ref PrivateSubnetAZ2
    Export: 
      Name: !Sub "$${EnvironmentName}:iam:StatefulSubnetAZ2Private"
  IAMStatelessSubnetAZ1Private:
    Value: !Ref PrivateSubnetAZ1
    Export: 
      Name: !Sub "$${EnvironmentName}:iam:StatelessSubnetAZ1Private"
  IAMStatelessSubnetAZ2Private:
    Value: !Ref PrivateSubnetAZ2
    Export: 
      Name: !Sub "$${EnvironmentName}:iam:StatelessSubnetAZ2Private"
  InternalDomain:
    Value: !Sub "$${EnvironmentName}internal.cloudfactorypre.app"
    Export: 
      Name: !Sub "$${EnvironmentName}:InternalDomain"
STACK
}