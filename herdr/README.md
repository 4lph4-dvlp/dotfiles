# Herdr Configuration

AI 코딩 에이전트 터미널 워크스페이스 매니저인 **[Herdr](https://herdr.dev)**의 크로스 플랫폼(Windows, Linux, macOS) 설정입니다. **GNU Stow**의 관리 구조를 따릅니다.

---

## 📁 디렉터리 구조

```text
dotfiles/
└── herdr/
    ├── .config/
    │   └── herdr/
    │       └── config.toml   # Herdr 공통 설정 파일
    └── README.md
```

---

## 🚀 설치 및 적용 가이드

### 1. Linux & macOS (GNU Stow)

Linux와 macOS에서 Herdr는 기본적으로 `~/.config/herdr/config.toml`을 탐색하므로, Stow를 통해 바로 심볼릭 링크를 생성하여 사용할 수 있습니다.

```bash
cd ~/dotfiles
stow herdr
```

---

### 2. Windows 환경 설정

Windows에서 Herdr는 기본적으로 `%APPDATA%\herdr\config.toml`을 바라봅니다.  
전역 환경 변수를 건드리지 않고 Neovim 등 다른 툴들과 충돌 없이 설정 파일만 dotfiles로 관리하려면, **`%APPDATA%\herdr\config.toml`을 dotfiles의 설정 파일과 하드링크(HardLink)**로 연결합니다.

*(NTFS 하드링크는 관리자 권한 없이 즉시 연결되며, 양방향으로 실시간 동기화됩니다.)*

```powershell
# 1. %APPDATA%\herdr 디렉터리 확인/생성
New-Item -ItemType Directory -Force -Path "$env:APPDATA\herdr"

# 2. config.toml 하드링크 연결 (관리자 권한 불필요)
New-Item -ItemType HardLink -Force -Path "$env:APPDATA\herdr\config.toml" -Target "$HOME\dotfiles\herdr\.config\herdr\config.toml"
```

> [!TIP]
> * 이렇게 연결하면 세션 상태(`session.json`), 스냅샷, 소켓 파일 등 Windows 로컬 런타임 파일은 `%APPDATA%\herdr`에 안전하게 유지되면서, `config.toml`만 dotfiles와 완벽하게 동기화됩니다.
> * Neovim이나 다른 CLI 도구의 경로 간섭 없이 독립적으로 안전하게 동작합니다.

> [!WARNING]
> Windows 사용자 환경 변수에 `XDG_CONFIG_HOME`을 전역으로 등록하지 마세요.  
> Neovim 등 다른 크로스 플랫폼 CLI 도구들이 Windows 기본 경로(`AppData\Local`) 대신 빈 `~/.config` 경로를 참조하게 되어 기존 설정이나 플러그인이 로드되지 않는 충돌이 발생할 수 있습니다.

---

## ✅ 적용 확인 및 진단

```powershell
# 1. Herdr가 참조하는 설정 파일 경로 확인
herdr --help
# 출력 하단에 "Config: C:\Users\<사용자>\AppData\Roaming\herdr\config.toml" 표시 확인

# 2. 설정 파일 구문 유효성 검사
herdr config check
# 정상인 경우 "config: ok" 출력
```

---

## ⚙️ 설정 팁 (Tips)

### `default_shell` (기본 셸)
* OS 간 설정을 통일할 때 `config.toml`에서 `default_shell` 항목을 비워두거나 주석 처리하면:
  * **Windows**: `pwsh.exe`(PowerShell 7) 또는 `powershell.exe`를 자동 감지
  * **Linux / macOS**: 현재 로그인 셸(`$SHELL` 예: `zsh`, `bash`)을 자동 감지
* 따라서 서로 다른 OS에서 동일한 `config.toml`을 공유할 때는 `default_shell`을 명시하지 않는 것이 편리합니다.
