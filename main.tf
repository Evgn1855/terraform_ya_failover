terraform {
  required_providers {
    yandex = {
        source = "yandex-cloud/yandex"
        #hashicorp/local-file = { source = "terraform-mirror.yandexcloud.net" }
        #version = "0.206.0"
    }
    local = {
        source = "hashicorp/local"
        version = "~> 2.0"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
    zone = "ru-central1-a"
    folder_id = "b1g4s2ti1evo8s936cp3"
    service_account_key_file = file("~/.authorized_key.json")
}

resource "yandex_compute_instance" "vm" {
    count = 2

    name        = "vm${count.index}"
    platform_id = "standard-v1"
    boot_disk {
        initialize_params {
            image_id = "fd83ica41cade1mj35sr" #ubuntu 24.04 fd83ica41cade1mj35sr
            size     = 10
        }
    } 

    network_interface {
        subnet_id = yandex_vpc_subnet.subnet1.id
        nat       = true
    }

    # boot_disk {
    #     initialize_params {
    #         image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
    #         type     = "network-hdd"
    #         size     = 10
    #     }
    # }

    resources {
        cores  = 2
        memory = 2
        core_fraction = 20
    }

    #metadata = { ssh-keys="ubuntu:${file("~/.ssh/id_ed25519_nopass.pub")}"}
    metadata = {
        user-data          = file("./cloud-init.yml")
        serial-port-enable = 1
    }
}
#создаем облачную сеть
resource "yandex_vpc_network" "network1"{
    name = "network1"
}

#создаем подсеть
resource "yandex_vpc_subnet" "subnet1" {
    name           = "subnet1"
    v4_cidr_blocks = ["172.24.9.0/24"] # 172.24.8.0/24
    network_id     = yandex_vpc_network.network1.id
}


#Группа балансировки
resource "yandex_lb_target_group" "group1"{
    name = "group1"

    dynamic "target" { #для каждого ресурса в списке будет создан параметр target
        for_each = yandex_compute_instance.vm
        content { #содержимое target
            subnet_id = yandex_vpc_subnet.subnet1.id #подсеть
            address   = target.value.network_interface.0.ip_address #сетевой адрес на нулевом сетевом интерфейсе
        }
    }
}

resource "yandex_lb_network_load_balancer" "balancer1" {
    name                = "balancer1"
    deletion_protection = "false"
    listener {
        name = "my-lb1"
        port = 80
        external_address_spec {
            ip_version = "ipv4"
        }
    }
    #К балансировщику подключаем группу балансировки
    attached_target_group {
        target_group_id = yandex_lb_target_group.group1.id
        #проверка серверов перед подключением балансировщика
        healthcheck {
            name = "http"
            http_options {
                port = 80
                path = "/"
            }
        }
    }
}