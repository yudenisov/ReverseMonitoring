$ErrorActionPreference = "Stop"

function RunConsole($scriptBlock)
{
    # Популярное решение "устранения" ошибки: Exception setting "OutputEncoding": "The handle is invalid."
    & cmd /c ver | Out-Null

    $encoding = [Console]::OutputEncoding 
    [Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("cp866")
    try
    {
        &$scriptBlock
    }
    finally
    {
        [Console]::OutputEncoding = $encoding
    }
}

RunConsole {
    & $PSScriptRoot\ConsoleApp1.exe
}