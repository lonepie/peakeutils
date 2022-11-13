param([string]$name = "world", [switch]$getdate)
"hello $name"
if ($getdate) {
  Get-Date
}
