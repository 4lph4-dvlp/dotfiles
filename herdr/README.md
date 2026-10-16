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

---

## ⌨️ Tmux 스타일 키 바인딩 (Keybindings)

Herdr의 키 바인딩을 **모던 Tmux 관례**에 맞춰 직관적으로 구성한 설정입니다. 기본 프리픽스는 Tmux와 동일하게 **`ctrl+b`**입니다.

### 1. 패널 제어 (Pane Control)
| 기능 | 단축키 | 설명 |
|---|---|---|
| **수직 분할 (좌/우)** | `prefix + \|` 또는 `prefix + v` | 모던 tmux 파이프(`\|`) 및 `v` |
| **수평 분할 (상/하)** | `prefix + -` (minus) | 모던 tmux 대시(`-`) |
| **패널 포커스 이동** | `prefix + h / j / k / l` | Vim 스타일 방향 이동 |
| **다음 패널 순환** | `prefix + o` | Tmux rotate/cycle pane (`cycle_pane_next`) |
| **마지막 패널 복귀** | `prefix + ;` | 직전 활성 패널로 전환 (`last_pane`) |
| **패널 맞바꾸기 (Swap)** | `prefix + {` / `prefix + }` | Tmux 표준 패널 스왑 (`swap_pane_left/right`) |
| **패널 닫기 (Kill)** | `prefix + x` | 현재 패널 닫기 |
| **패널 최대화 (Zoom)** | `prefix + z` | 현재 패널 전체화면 토글 |
| **패널 크기 조절 (Direct)** | `prefix + Ctrl + 방향키`<br>`prefix + Shift + H / J / K / L` | Tmux 스타일 좌/하/상/우 크기 조절 |
| **패널 리사이즈 모드** | `prefix + r` | 리사이즈 전용 모드 진입 (`h/j/k/l` 또는 방향키 연타 후 `Esc` 종료) |

### 2. 탭 관리 (Tab / Tmux Window)
| 기능 | 단축키 | 설명 |
|---|---|---|
| **새 탭 생성** | `prefix + c` | Tmux `new-window` |
| **탭 닫기** | `prefix + &` | Tmux `kill-window` |
| **이전 / 다음 탭** | `prefix + p` / `prefix + n` | 탭 순차 이동 |
| **탭 번호 바로가기** | `prefix + 1..9` | 1~9번 탭 즉시 전환 |
| **탭 이름 변경** | `prefix + ,` (comma) | Tmux 창 이름 변경 |

### 3. 세션 및 워크스페이스 (Session & Workspace)
| 기능 | 단축키 | 설명 |
|---|---|---|
| **세션 분리 (Detach)** | `prefix + d` | 백그라운드로 분리하고 셸로 복귀 |
| **세션(워크스페이스) 선택** | `prefix + s` | 워크스페이스 내비게이션 창 열기 |
| **워크스페이스 이름 변경** | `prefix + $` | 현재 워크스페이스 이름 변경 |
| **이전 / 다음 워크스페이스**| `prefix + (` / `prefix + )` | 워크스페이스 순차 이동 |

### 4. Herdr 고유 기능 (Tmux 비충돌 배치)
| 기능 | 단축키 | 설명 및 배치 이유 |
|---|---|---|
| **설정 다시 불러오기** | `prefix + Shift + R` (`R`) | `prefix+r`이 리사이즈 모드이므로 대문자 `R`로 지정 |
| **Herdr 환경설정** | `prefix + Shift + S` (`S`) | `prefix+s`가 워크스페이스 선택기이므로 대문자 `S`로 지정 |
| **AI 알림 바로가기** | `prefix + u` | `prefix+o`가 패널 이동이므로 Urgent(`u`)로 재배치 |
| **사이드바 토글** | `prefix + b` | 좌측 탐색 사이드바 열기/닫기 |
| **통합 옴니 네비게이터** | `prefix + g` | 워크스페이스/터미널/에이전트 통합 검색창 (`goto`) |
| **스크롤백 에디터 열기** | `prefix + e` | 현재 터미널 버퍼 내용을 `$EDITOR`(nvim 등)로 열기 |
| **복사 모드 (Copy Mode)** | `prefix + [` | 키보드 복사 모드 진입 |
| **키 바인딩 도움말** | `prefix + ?` | 전체 활성 키 목록 확인 |
| **새 Git Worktree 생성** | `prefix + Shift + G` | 워크스페이스 기반 새 Git worktree 생성 |
| **AI 에이전트 전환** | `prefix + Alt + p / n` | 이전 / 다음 활성 AI 에이전트로 포커스 이동 |
| **AI 에이전트 번호 점프** | `prefix + Alt + 1..9` | 1~9번 AI 에이전트로 바로 점프 |

