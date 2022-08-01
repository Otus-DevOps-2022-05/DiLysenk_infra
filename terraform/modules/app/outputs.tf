#Выходные данные для пользователя
output "external_ip_address_app" {
  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
}
output "name_host_name" {
  value = yandex_compute_instance.app.hostname
}
output "name" {
  value = yandex_compute_instance.app.name
}
