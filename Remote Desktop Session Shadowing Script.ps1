function Select-TextItem 
{ 
PARAM  
( 
    [Parameter(Mandatory=$true)] 
    $options, 
    $displayProperty 
) 
 
    [int]$optionPrefix = 1 
    # Create menu list 
    foreach ($option in $options) 
    { 
        if ($displayProperty -eq $null) 
        { 
            Write-Host ("{0,3}: {1}" -f $optionPrefix,$option) 
        } 
        else 
        { 
            Write-Host ("{0,3}: {1}" -f $optionPrefix,$option.$displayProperty) 
        } 
        $optionPrefix++ 
    } 
    Write-Host ("{0,3}: {1}" -f 0,"To cancel")  
    [int]$response = Read-Host "Select which server to Shadow" 
    $val = $null 
    if ($response -gt 0 -and $response -le $options.Count) 
    { 
        $val = $options[$response-1] 
    } 
    return $val 
}    
 
 
$values = "SRV01.contoso.com","SRV02.contoso.com","SRV03.contoso.com","Other"
$val = Select-TextItem $values 
$val 
    
    if ($val -eq "Other")
    { 
        [string]$response = Read-Host "Insert the name of computer" 
        $val = $response 
        query.exe session /server:$val
        $sessionid=Read-Host -Prompt "Select the Session Number"
        Mstsc.exe /V:$val /shadow:$sessionid /control
         
    }
    else
    {
        query.exe session /server:$val
        $sessionid=Read-Host -Prompt "Select the Session Number"
        Mstsc.exe /V:$val /shadow:$sessionid /control /noConsentPrompt
    }