resource "aws_db_instance" "this" {
  identifier              = var.identifier
  engine                  = "postgres"
  engine_version          = "16.3"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"
  username                = var.username
  password                = var.password
  db_name                 = var.db_name
    parameter_group_name    = "default.postgres16"
  skip_final_snapshot     = true
  publicly_accessible     = false
  deletion_protection     = false
  multi_az                = false
  backup_retention_period = 1
  tags = {
    Name = var.identifier
  }
}
