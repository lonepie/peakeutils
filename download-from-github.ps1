param(
  [string] $Url,
  [string] $Path,
  [string] $Token,
  [switch] $Run
)

function Download-From-Github {
  param(
    [string] $Path,
    [string] $Token
  )
  if ($Path -eq "") {
    "Please specify a file path"
  }
  elseif ($Token -eq "") {
    "Please specify a GitHub Token"
  }
  else {
    # $wc = New-Object -TypeName System.Net.WebClient
    # $wc.Headers.Add("Authorization", "token $token")
    $url = "https://raw.githubusercontent.com/$Path"
    # $content = $wc.DownloadString($url)
    #
    # return $content
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

if ($Url -ne "") {
    $fc = Download-File -Url $Url
}
else {
  $fc = Download-From-Github -Path $Path -Token $Token
}
if ($Run) { & $fc; }
else { $fc }
