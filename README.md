# site

A new Flutter project.

## Getting Started

Проект создавался для диплома. Т.к. тема диплома была в последствии уточнена, данный сайт не понадобился и был незавершен(брошен).
Основные возможности сайта:
1) Учителя регистрируются и добавляют предметы.
2) При добавлении предмета указываются ключевые слова (термы) предмета.
3) Учителя выгружают файлы(конспекты, учебники). При загрузке выбирают к какому предмету относится загружаемый материал; 
Использовался firebase для базы данных и backendless для выгрузки файлов. В последствии от backendless отказался.
Проект был успешно реализован, но столкнулся с ключевой проблемой.
https://github.com/flutter/flutter/issues/33577
При загрузке больших файлов через file picker и иногда с 200мб+ web-страница зависала.
Найденое решение это написание js worker'a с задачей по загрузке файла.
Было нереализовано с связи с неактуальностью проекта.
//TODO
Собрать все файлы вместе, проверить работоспособность, обновить репозиторий.
