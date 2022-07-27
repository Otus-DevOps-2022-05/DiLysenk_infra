terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_compute_instance" "app" {
  name     = "reddit-app"

  resources {
    cores  = var.instance_count
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашнем задании (настроено)
      image_id = var.image_id
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a (настроено)
    subnet_id = var.subnet_id
    nat       = true
  }
  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    host        = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key)
  }
  provisioner "file" {
    source      = "file/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "file/deploy.sh"
  }
}
