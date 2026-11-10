# deploy_ansible

Ansible-плейбуки для базовой настройки серверов и DoH.

## Секреты

Домены, бэкенды сайтов, e-mail для Let's Encrypt и секретный путь DoH
**не хранятся в репозитории**. В CI они приходят из GitHub Secrets:

- `ANSIBLE_EXTRA_VARS` — YAML с `doh_domain`, `doh_zone`, `doh_email`,
  `doh_secret_path` и `sites_configs` (формат: `docs/extra_vars.example.yml`);
- `CF_API_TOKEN` — токен Cloudflare (добавляется в extra vars workflow'ом);
- `ANSIBLE_INVENTORY`, `DNSMASQ_SPOOF_LIST`, `SSH_PRIVATE_KEY` — как раньше.

Локальный `extra_vars.yml` git-игнорируется. Никогда не коммитьте реальные
домены, IP бэкендов и токены.
