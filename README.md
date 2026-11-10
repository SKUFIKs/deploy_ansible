# deploy_ansible

Учебный проект по Ansible: базовая настройка серверов, DNS-over-HTTPS и
несколько сайтов за nginx.

> **Это личный проект, который я делаю только в рамках обучения.**
> Все действия выполняются на реальных серверах. Проект не претендует на
> production-ready: конфиги упрощены, а решения принимались по ходу изучения
> Ansible, nginx и Linux.

## Что внутри

| Роль | Что делает |
|---|---|
| `base` | пакеты, UFW, смена SSH-порта, Fail2Ban |
| `doh` | nginx + dnsmasq + [dns-over-https](https://github.com/m13253/dns-over-https), TLS через Let's Encrypt (DNS-01 Cloudflare) |
| `sites` | сайты за nginx: HTTP → HTTPS, SNI-маршрутизация через stream на локальные бэкенды `127.0.0.1:8443` с PROXY protocol |

## Структура

```
playbook.yml
inventory.ini          # локальный, в git не попадает
roles/
  base/
  doh/
  sites/
docs/extra_vars.example.yml
```

## Запуск

```bash
ansible-galaxy collection install -r requirements.yml
ansible-playbook -i inventory.ini playbook.yml --extra-vars @extra_vars.yml
```

`extra_vars.yml` — локальный файл с секретами, в git его нет.
Пример формата: [`docs/extra_vars.example.yml`](docs/extra_vars.example.yml).

## Секреты

Домены, адреса бэкендов, e-mail для Let's Encrypt и секретный путь DoH
хранятся **не в репозитории**, а в GitHub Secrets (`ANSIBLE_EXTRA_VARS`,
`CF_API_TOKEN`, `ANSIBLE_INVENTORY`, `DNSMASQ_SPOOF_LIST`, `SSH_PRIVATE_KEY`).
В workflow они записываются во временный `extra_vars.yml`, который удаляется
после запуска.

## Проверки

```powershell
.\lint.ps1
```

Скрипт запускает `pre-commit` (`yamllint`, `ansible-lint`) и
`ansible-playbook --syntax-check` в WSL.
