provider "yandex"
{
  token     = "<OAuth или статический ключ сервисного аккаунта>"
  cloud_id  = "<идентификатор облака>"
  folder_id = "<идентификатор каталога>"
  zone      = "ru-central1-a"


}

resource "yandex_compute_instance" "app" {
  name     = "reddit-app"

  resources {
    cores  = 1
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашнем задании (настроено)
      image_id = "fd8uabquugg00lcrdiga"
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a (настроено)
    subnet_id = "e9bafsjttjgqetoe8mau"
    nat       = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file("~/.ssh/yc.pub")}"
  }

  connection {
    type        = "ssh"
    host        = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    # путь до приватного ключа
    private_key = file("~/.ssh/yc")
  }
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

}




