output "db_connect_string" {
  value = "Server=${aws_db_instance.database.address}; Database=ExampleDB; Uid=${var.db_username}; Pwd=${var.db_password}"
  description = "MySQL database connection string"
    sensitive = true
}
