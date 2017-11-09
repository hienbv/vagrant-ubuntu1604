## Nội dung ##
### [Vagrant](https://www.vagrantup.com/) là gì? ###
Create and configure lightweight, reproducible, and portable development environments.

### Tại sao sử dụng vagrant? ###
Vagrant là một công cụ tiện lợi, giúp bạn có thể tạo ra môi trường phát triển cho team phát triển một cách nhanh chóng và tiện lợi. 

Hướng dẫn này sẽ giúp bạn có thể tạo môi trường phát triển trên ubuntu có cài đặt LAMP + Git và phpmyadmin.

## Yêu cầu phần mềm ##
Trước khi bắt đầu học vagrant thì chúng ta cần phải cài đặt một số phần mềm sau:

- Máy ảo [virtualbox](https://www.virtualbox.org/wiki/Downloads)
- Phiên bản [Vagrant](https://www.vagrantup.com/downloads.html) mới nhất.
- Terminal [Xshell](https://www.netsarang.com/products/xsh_overview.html) bạn có thể sử dụng terminal của [git for window](https://git-for-windows.github.io/)

Sau khi hoàn thành xong cài đặt phần mềm, chúng ta sẽ bắt đầu tạo máy ảo.
## Cài đặt máy ảo ubuntu + LAMP + phpmyadmin + Git ##
Sau khi đã hoàn thành việc cài đặt các phần mềm cần thiết. Bạn có thể mở terminal nên, tạo một thư mục cho vagrant:
> $ mkdir vagrant_dir

Sau khi tạo thành công thư mục hãy copy toàn bộ thư mục con trong thư mục ubuntu vào thư mục vagrant_dir vừa tạo.

Di chuyển vào thư mục vagrant_dir bằng terminal:
> $ cd vagrant_dir

Cuối cùng là bạn gõ lệnh sau để hoàn thành việc thiết lập môi trường phát triển
> $ vagrant up

Công việc còn lại của bạn là ngồi chờ kết quả cuối cùng. Sẽ mất thời gian cho lần chạy đầu tiên vì vagrant sẽ phải download box từ [HashiCorp](https://atlas.hashicorp.com/boxes/search), sau đó mới tiến hành build máy ảo trên virtualbox cho bạn. 

Làm sao để biết mình đã hoàn thành tạo máy ảo thành công. Rất đơn giản, bạn có thể gõ vào lệnh sau:
> $ vagrant ssh

Hoặc bạn gõ vào trình duyệt url [http//:192.168.56.56/phpinfo.php](http//:192.168.56.56/phpinfo.php) 

Cuối cùng là hãy chiêm ngưỡng kết quả đạt được!

## Thông tin tác giả ##
- Author: HienBV
- Email: [hienbv.it@gmail.com](hienbv.it@gmail.com)