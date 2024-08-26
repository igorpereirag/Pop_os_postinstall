# pop-os-postinstall

Este script automatiza a instalação e configuração de ferramentas essenciais no Pop!_OS, incluindo:

- Visual Studio Code
- Git
- Docker
- SDKMAN
- Bitwarden
- Google Chrome
- Insomnia

## Como Usar

Execute o seguinte comando no terminal:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/igorpereirag/Pop_os_postinstall/main/pop-os-postinstall.sh)"
```

## O Que o Script Faz

- Atualiza e faz a manutenção do sistema
- Verifica a conexão com a Internet
- Remove travas do `apt`
- Instala pacotes essenciais via `apt`, `snap` e `flatpak`
- Configura o Docker para uso sem `sudo`
- Instala SDKMAN para gerenciar múltiplas versões de ferramentas de desenvolvimento

## Personalização

Para adicionar mais programas ou modificar a lista existente, edite os arrays `PROGRAMAS_APT`, `PROGRAMAS_SNAP`, `PROGRAMAS_FLATPAK`, e `URLS` no script.

