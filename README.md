
__Задание 1__

Возьмите за основу решение к заданию 1 из занятия «Подъём инфраструктуры в Яндекс Облаке».

Теперь вместо одной виртуальной машины сделайте terraform playbook, который:

создаст 2 идентичные виртуальные машины. Используйте аргумент count для создания таких ресурсов;

создаст таргет-группу. Поместите в неё созданные на шаге 1 виртуальные машины;

создаст сетевой балансировщик нагрузки, который слушает на порту 80, отправляет трафик на порт 80 виртуальных машин и http healthcheck на порт 80 виртуальных машин.

Рекомендуем изучить документацию сетевого балансировщика нагрузки для того, чтобы было понятно, что вы сделали.

Установите на созданные виртуальные машины пакет Nginx любым удобным способом и запустите Nginx веб-сервер на порту 80.

Перейдите в веб-консоль Yandex Cloud и убедитесь, что:

созданный балансировщик находится в статусе Active,

обе виртуальные машины в целевой группе находятся в состоянии healthy.

Сделайте запрос на 80 порт на внешний IP-адрес балансировщика и убедитесь, что вы получаете ответ в виде дефолтной страницы Nginx.

В качестве результата пришлите:

1. Terraform Playbook.

2. Скриншот статуса балансировщика и целевой группы.

3. Скриншот страницы, которая открылась при запросе IP-адреса балансировщика.


![alt_text](images/image1.png "image_tooltip")



![alt_text](images/image2.png "image_tooltip")



![alt_text](images/image3.png "image_tooltip")



![alt_text](images/image4.png "image_tooltip")



![alt_text](images/image5.png "image_tooltip")


Нужно создать файлик ansible.cfg со следующим содержимым


```
[defaults]
host_key_checking = False
```


Права доступа на ключ 

sudo chmod 600 /home/siadmin/.ssh/id_ed25519

sudo chmod 700 /home/siadmin/.ssh


![alt_text](images/image6.png "image_tooltip")



![alt_text](images/image7.png "image_tooltip")



![alt_text](images/image8.png "image_tooltip")


__Задание 2*__

Теперь вместо создания виртуальных машин создайте группу виртуальных машин с балансировщиком нагрузки.

Nginx нужно будет поставить тоже автоматизированно. Для этого вам нужно будет подложить файл установки Nginx в user-data-ключ метадаты виртуальной машины.

Пример файла установки Nginx.

Как подставлять файл в метадату виртуальной машины.

Перейдите в веб-консоль Yandex Cloud и убедитесь, что:

созданный балансировщик находится в статусе Active,

обе виртуальные машины в целевой группе находятся в состоянии healthy.

Сделайте запрос на 80 порт на внешний IP-адрес балансировщика и убедитесь, что вы получаете ответ в виде дефолтной страницы Nginx.

В качестве результата пришлите

1. Terraform Playbook.

2. Скриншот статуса балансировщика и целевой группы.

3. Скриншот страницы, которая открылась при запросе IP-адреса балансировщика.

Добавим в файл  cloud-init.yml конфигурацию для установки nginx


![alt_text](images/image9.png "image_tooltip")



![alt_text](images/image10.png "image_tooltip")



![alt_text](images/image11.png "image_tooltip")



![alt_text](images/image12.png "image_tooltip")



![alt_text](images/image13.png "image_tooltip")



![alt_text](images/image14.png "image_tooltip")


nginx установлен на виртуальные машины


![alt_text](images/image15.png "image_tooltip")


По умолчанию создается фаил /var/www/html/index.html с содержимым типа 


![alt_text](images/image16.png "image_tooltip")


его нужно удалить тогда подгрузится index.nginx-debian.html со стартовой страницей nginx


![alt_text](images/image17.png "image_tooltip")



![alt_text](images/image18.png "image_tooltip")


