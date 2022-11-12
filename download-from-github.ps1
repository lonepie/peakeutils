param(
  [string] $Url,
  [string] $Path,
  [string] $Token,
  [switch] $Run,
  [string] $Params
)

function Download-From-Github {
  param(
    [string] $Url,
    [string] $Path,
    [string] $Token
  )
  if (($Path -eq "") -and ($Url -eq "")) {
    "Please specify a file path or Url"
  }
  elseif ($Token -eq "") {
    "Please specify a GitHub Token"
  }
  else {
    if ($Url -eq "") {
      $Url = "https://raw.githubusercontent.com/$Path"
    }
    $headers = [System.Net.WebHeaderCollection]::new()
    $headers.Add("Authorization", "token $token")
    Download-File -Url $Url -Headers $headers
  }
}

function Download-File {
    param(
      [Parameter(Mandatory=$true)]
      [string] $Url,
      [System.Net.WebHeaderCollection] $Headers
    )

    $wc = [System.Net.WebClient]::new()
    if ($Headers.Count -gt 0) {
        $wc.Headers.Add($Headers)
      }
    $content = $wc.DownloadString($url)
    return $content
}

if ($Url -ne "" -and $Token -eq "") {
    $fc = Download-File -Url $Url
}
else {
  if ($Path -ne "") {
    $fc = Download-From-Github -Path $Path -Token $Token
  }
  elseif ($Url -ne "") {
    $fc = Download-From-Github -Url $Url -Token $Token
  }
}
if ($Run) { 
  $scriptBlockContent = "&{ $fc }"
  if ($Params) {
    $formattedParams = &{ $Params } @params
    $scriptBlockContent += " $formattedParams"
  }
  $scriptblock = [ScriptBlock]::Create($scriptBlockContent)
  icm -ScriptBlock $scriptblock
}
else { $fc }
