### Домашнее задание №2: Bash скрипт

Этот скрипт выводит название организаций, которым принадлежат те IP адреса, к которым осуществляет подключение процесс, переданный в качестве параметра этому скрипту. Процесс можно указать по имени или по proccess ID.

##### Синтаксис
  >./script PID [опции]
  
##### Описание опции
  -w - получение дополнительный данных из вывода whois
  
  --ss - использовать вместо netstat утилиту ss
  
  -n - выводит указанное количество строк. Пример:
  >./script PID -n 5 - ограничение вывода в 5 строк
  
  -s a - отобразит все виды подключений.<br>
  -s l - отобразить только прослушиваемые соединения.<br>
  Скрипт без этой опции отобразит только установленные подключения. Примеры:
   > ./script PID -w a - отобразит все подключения.<br>
   > ./script PID -w l - отобразит только прослушиваемые соединения.<br>
   > ./script PID - отобразит установленные подключения.<br>
  