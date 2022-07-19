#!/bin/bash
#"Перед тем как дать команду terraform'у применить изменения,
#хорошей практикой является предварительно посмотреть, какие
#изменения terraform собирается произвести относительно
#состояния известных ему ресурсов (tfstate файл), и проверить, что
#мы действительно хотим сделать именно эти изменения
terraform plan

#Так как провижинеры по умолчанию запускаются сразу после
#создания ресурса (могут еще запускаться после его удаления),
#чтобы проверить их работу нам нужно удалить ресурс VM и создать
#его снова.
#Terraform предлагает команду taint, которая позволяет пометить
#ресурс, который terraform должен пересоздать, при следующем
#запуске terraform apply

terraform taint yandex_compute_instance.app
#Планируем изменения:
terraform plan


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
