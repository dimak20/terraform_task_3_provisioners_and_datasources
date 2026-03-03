resource "null_resource" "vm_provision" {
  triggers = {
    vm_id = data.azurerm_virtual_machine.main.id
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = data.azurerm_public_ip.pip.ip_address
    }
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/var/www/html/index.html"
    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = data.azurerm_public_ip.pip.ip_address
    }
  }
}
