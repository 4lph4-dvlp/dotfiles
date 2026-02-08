# Neovim Configuration

Arch Linux 환경을 위한 개인 Neovim 설정입니다. **GNU Stow**를 사용하여 관리하기에 최적화되어 있습니다.

## 📦 Features

이 설정은 다음의 핵심 플러그인들을 포함합니다:

*   **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
*   **Theme**: [Catppuccin](https://github.com/catppuccin/nvim) (Luxurious & Modern)
*   **Dashboard**: [alpha-nvim](https://github.com/goolord/alpha-nvim) (Stylized start screen)
*   **File Explorer**: [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
*   **Fuzzy Finder**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
*   **Syntax Highlighting**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
*   **LSP & Formatting**: [Mason](https://github.com/williamboman/mason.nvim), [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [none-ls](https://github.com/nvimtools/none-ls.nvim)
*   **Completion & AI**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), [Copilot](https://github.com/github/copilot.vim)

## 🛠️ Prerequisites (필수 요구사항)

이 설정은 **Arch Linux**를 기준으로 작성되었습니다. 아래 명령어로 필요한 패키지들을 일괄 설치할 수 있습니다.

```bash
sudo pacman -S --needed neovim git stow ripgrep fd npm python base-devel unzip
```

*   **Neovim** >= 0.9.0
*   **Git**: 플러그인 및 설정 관리
*   **Stow**: 설정 파일 심볼릭 링크 관리
*   **Ripgrep / Fd**: Telescope 검색 최적화
*   **NPM / Node.js**: Copilot 및 일부 LSP 서버 구동용
*   **Python**: Python 관련 LSP 및 툴링
*   **GCC / Make**: Treesitter 파서 컴파일용 (base-devel)

## 🚀 Installation with GNU Stow

이 설정을 클론하고 Stow를 사용하여 `~/.config/nvim`에 적용하는 방법입니다.

1.  **Dotfiles 클론**
    ```bash
    git clone https://github.com/4lph4-dvlp/dotfiles.git
    ```

2.  **Stow를 사용하여 설정 적용**
    Stow는 해당 디렉토리의 내용을 상위 디렉토리(기본값)로 심볼릭 링크합니다.
    (주의: 이 저장소의 구조가 `init.lua`가 루트에 있는 경우, 아래와 같이 타겟을 지정해야 합니다. 만약 저장소 구조가 `.config/nvim/...` 식이라면 단순히 `stow nvim`만 하면 됩니다.)

    **Case A: 저장소 구조가 `.config/nvim/init.lua`인 경우 (권장)**
    ```bash
    cd ~/dotfiles
    stow nvim
    ```

    **Case B: 저장소 구조가 `init.lua`가 바로 있는 경우 (현재 구조)**
    ```bash
    cd ~/dotfiles/nvim
    # 현재 디렉토리 내용을 ~/.config/nvim으로 링크
    mkdir -p ~/.config/nvim
    stow --target=$HOME/.config/nvim .
    ```

3.  **플러그인 설치 확인**
    `nvim`을 실행하면 `lazy.nvim`이 자동으로 플러그인을 설치합니다. 설치가 완료되면 `:Mason` 명령어로 LSP 서버 상태를 확인하세요.

## ⌨️ Keybindings (단축키)

### Basic
| Key | Function |
| :--- | :--- |
| `<Space>` | **Leader Key** |
| `jj` | (설정 시) Insert Mode 종료 |

### File Management
| Key | Description | Plugin |
| :--- | :--- | :--- |
| `<C-o>` | 파일 검색 (Find Files) | Telescope |
| `<Space>fg` | 내용 검색 (Live Grep) | Telescope |
| `<C-\>` | 탐색기 토글 | Neo-tree |
| **Neo-tree** | `a`:추가, `d`:삭제, `r`:이름변경 | |

### Coding & LSP
| Key | Description |
| :--- | :--- |
| `K` | Hover 설명 보기 |
| `gd` | 정의로 이동 |
| `<Space>ca` | 코드 액션 (Fix) |
| `<Space>gf` | 포매팅 (Format) |

---
*Created with ❤️ by Antigravity*
