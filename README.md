# peakeutils
custom scripts that aid in productivity

## connectwise-manage-tab-title.user.js
A userscript that dynamically sets the browser tab title based on the current page heading in Connectwise Manage

Install with a userscript extension like TamperMonkey or ViolentMonkey. Set the @match variable to the base Url of your Manage instance. Ex: `@match https://manage.mydomain.tld`

## lp-fzf
Filter LastPass entries through FZF on the commandline, then copy password to clipboard. 1000% faster than using the web ui.

Requires: WSL/Linux/Mac, [lastpass-cli](https://github.com/lastpass/lastpass-cli), [fzf](https://github.com/junegunn/fzf)

## download-from-github.ps1
Powershell script to download (and optionally, run) other powershell scripts from any URL or private GitHub repo

Usage:
```powershell
.\download-from-github.ps1 [-Url "https://domain.tld/file.ps1"] | ([-Path "user/repo/branch/file.ps1"] [-Token "github_token"]) [-Run] [-Params "-Arguments 'to pass to' -Downloaded 'script'"]
```
Example:

```powershell
.\download-from-github.ps1 -Path "PEAKE-Technology-Partners/peakeutils/test.ps1" -Token "ghp_xxxxxxxxxxxxxxxxxx" -Run -Params "-Name Jon"
```

Output:
`Hello, Jon`

### Bonus
Here's a ridiculous looking one-liner that will download & run the `download-from-github.ps1` script, which in turn downloads and runs the `test.ps1` script and passes arguments to it -- all without touching the filesystem:
```powershell
icm -ScriptBlock ([scriptblock]::create("&{ $(iwr "https://raw.githubusercontent.com/PEAKE-Technology-Partners/peakeutils/main/download-from-github.ps1") } -Url 'https://raw.githubusercontent.com/PEAKE-Technology-Partners/peakeutils/main/test.ps1' -Run -Params '-Name `"PEAKE Technology Partners`" -GetDate'"))
```

Output:
```
hello PEAKE Technology Partners

Saturday, November 12, 2022 7:27:10 PM
```
