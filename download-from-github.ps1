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

    try {
      $wc = [System.Net.WebClient]::new()
      if ($Headers.Count -gt 0) {
        $wc.Headers.Add($Headers)
      }
      $content = $wc.DownloadString($url)
      return $content
    }
    catch {
      Write-Host "Error downloading from Url $Url"
      Write-Host $_
    }
}

if ($Token -eq "") {
  if ($Url -ne "") {
    $fc = Download-File -Url $Url
  }
  elseif ($Path -ne "") {
    $fc = Download-File -Url "https://raw.githubusercontent.com/$Path"
  }
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
  try {
    $scriptBlockContent = "&{ $fc }"
    if ($Params) {
      $formattedParams = &{ $Params } @params
      $scriptBlockContent += " $formattedParams"
    }
    $scriptblock = [ScriptBlock]::Create($scriptBlockContent)
    icm -ScriptBlock $scriptblock
  }
  catch {
    Write-Host "An error occurred running the downloaded file:"
    Write-Host $_
  }
}
else { $fc }
