#записать в фаил список созданных виртуальных машин
#resource "local-file" "ansible-inventory" {
#    file-permission = "0644"
#    filename        = "${path.module}/../ansible/inventory.ini"
#    content         = <<EOT
# [all]
# %{for host in yandex_compute_instance.vm~}
# ${trimspace("${host.name} ansible_host=${host.network_interface.0.nat_ip_address}")}
# %{endfor~}
# EOT
# }