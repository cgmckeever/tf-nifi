# Instance Key
resource "aws_key_pair" "tf-nifi-instance-key" {
  key_name                = "tf-nifi-instance-key"
  public_key              = var.instance_key
  tags                    = {
    Name                    = "tf-nifi-instance-key"
  }
}

# Instance(s)
resource "aws_instance" "tf-nifi-1" {
  ami                     = aws_ami_copy.tf-nifi-latest-vendor-ami-with-cmk.id
  instance_type           = var.instance_type
  iam_instance_profile    = aws_iam_instance_profile.tf-nifi-instance-profile.name
  key_name                = aws_key_pair.tf-nifi-instance-key.key_name
  subnet_id               = aws_subnet.tf-nifi-prinet1.id
  private_ip              = var.node1_ip
  vpc_security_group_ids  = [aws_security_group.tf-nifi-prisg1.id]
  tags                    = {
    Name                    = "tf-nifi-1"
    Nifi                    = "zookeeper"
  }
  user_data               = file("userdata/tf-nifi-userdata-1.sh")
  root_block_device {
    volume_size             = var.instance_vol_size
    volume_type             = "standard"
    encrypted               = "true"
    kms_key_id              = aws_kms_key.tf-nifi-kmscmk-ec2.arn
  }
  depends_on              = [aws_nat_gateway.tf-nifi-ng1,aws_ssm_association.tf-nifi-zookeepers-ssm-assoc,aws_iam_policy.tf-nifi-instance-policy]
}

resource "aws_instance" "tf-nifi-2" {
  ami                     = aws_ami_copy.tf-nifi-latest-vendor-ami-with-cmk.id
  instance_type           = var.instance_type
  iam_instance_profile    = aws_iam_instance_profile.tf-nifi-instance-profile.name
  key_name                = aws_key_pair.tf-nifi-instance-key.key_name
  subnet_id               = aws_subnet.tf-nifi-prinet2.id
  private_ip              = var.node2_ip
  vpc_security_group_ids  = [aws_security_group.tf-nifi-prisg1.id]
  tags                    = {
    Name                    = "tf-nifi-2"
    Nifi                    = "zookeeper"
  }
  user_data               = file("userdata/tf-nifi-userdata-2.sh")
  root_block_device {
    volume_size             = var.instance_vol_size
    volume_type             = "standard"
    encrypted               = "true"
    kms_key_id              = aws_kms_key.tf-nifi-kmscmk-ec2.arn
  }
  depends_on              = [aws_nat_gateway.tf-nifi-ng2,aws_ssm_association.tf-nifi-zookeepers-ssm-assoc,aws_iam_policy.tf-nifi-instance-policy]
}

resource "aws_instance" "tf-nifi-3" {
  ami                     = aws_ami_copy.tf-nifi-latest-vendor-ami-with-cmk.id
  instance_type           = var.instance_type
  iam_instance_profile    = aws_iam_instance_profile.tf-nifi-instance-profile.name
  key_name                = aws_key_pair.tf-nifi-instance-key.key_name
  subnet_id               = aws_subnet.tf-nifi-prinet3.id
  private_ip              = var.node3_ip
  vpc_security_group_ids  = [aws_security_group.tf-nifi-prisg1.id]
  tags                    = {
    Name                    = "tf-nifi-3"
    Nifi                    = "zookeeper"
  }
  user_data               = file("userdata/tf-nifi-userdata-3.sh")
  root_block_device {
    volume_size             = var.instance_vol_size
    volume_type             = "standard"
    encrypted               = "true"
    kms_key_id              = aws_kms_key.tf-nifi-kmscmk-ec2.arn
  }
  depends_on              = [aws_nat_gateway.tf-nifi-ng3,aws_ssm_association.tf-nifi-zookeepers-ssm-assoc,aws_iam_policy.tf-nifi-instance-policy]
}
