resource "aws_key_pair" "welcome-prod-keypair" {
  key_name   = "newkeyjohan"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
  lifecycle {
    ignore_changes = [public_key]
  }
}