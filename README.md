# README
1) Настраиваем на сервере ngix+passenger, устанавливаем ruby, устанавливаем postgres.Подробно рассказывается как сделать - https://www.youtube.com/watch?v=zvXyHR085a8 .
2) в директорию /#{name_app}/shared/config на сервере заносим database.yml, master.key
3) Заходим в  nano ~/.bashrc и добавляем в начало два ключа:
export RAILS_MASTER_KEY=key
export SECRET_KEY_BASE=key

sudo tail -f ~/www/current/log/production.log - смотрим логи на сервере, что происходит с приложением.

