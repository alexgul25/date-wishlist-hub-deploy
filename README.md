# Date Wishlist Hub

Центральный репозиторий проекта **Date Wishlist Hub**

## :jigsaw: Используемые микросервисы

- :point_right: [Gateway Service](https://github.com/alexgul25/gateway-svc) - единая точка входа, через которую клиенты взаимодействуют со всеми внутренними сервисами

- :point_right: [User Service](https://github.com/alexgul25/user-svc) - работа с данными о пользователях и подписках

- :point_right: [Place Service](https://github.com/alexgul25/place-svc) - работа с данными о местах, добавленных пользователями

- Notify Service (ещё создаётся)

## :bulb: Идея проекта

**Data Wishlist Hub** - сервис, где каждый пользователь ведёт свой вишлист мест, которые он хотел бы посетить. Пользователи могут просматривать вишлисты, чтобы выбрать идею для совместной прогулки. Есть возможность подписки на пользователя, она позволяет получать уведомления на почту о появлении новых мест в вишлисте интересующего пользователя (на данном этапе письма на почту симулируются с помощью логирования).

## :building_construction: Архитектура проекта

<!-- markdownlint-disable MD033 -->
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/Date_Wishlist_hub_dark.png">
    <source media="(prefers-color-scheme: light)" srcset="docs/Date_Wishlist_hub_light.png">
    <img alt="Схема взаимодействий" src="docs/Date_Wishlist_hub_light.png" width="650">
  </picture>
</p>
<!-- markdownlint-enable MD033 -->

## :world_map: План развития проекта

### MVP

- [x] User Service – регистрация, аутентификация, подписки

- [x] Place Service – добавление мест и просмотр их актуального списка

- [x] Gateway Service – единая точка входа, gRPC-прокси

- [ ] Notify Service – логирование уведомлений

### Дальнейшие шаги

- [ ] Подробный README для каждого сервиса

- [ ] Unit-тесты для бизнес-логики сервисов

- [ ] Интеграционные тесты с testcontainers

- [ ] Docker-образы для всех сервисов

- [ ] Docker Compose для локального запуска всего кластера

- [ ] Сбор метрик (Prometheus + Grafana)
