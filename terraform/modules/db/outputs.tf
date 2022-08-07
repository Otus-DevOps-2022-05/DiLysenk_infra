output "external_ip_address_db" {
value = yandex_compute_instance.db.network_interface.0.nat_ip_address
}
output "name_host_name" {
  value = yandex_compute_instance.db.hostname
}
output "name" {
  value = yandex_compute_instance.db.name
}
