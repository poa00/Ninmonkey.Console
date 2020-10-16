﻿function Get-NinCommandSyntax {
    <#
    .synopsis
        an easier to read version of Get-Command -Syntax
    .description
        Syntax is formatted using a regex, it does not use intraspection
    .notes
        the original was based on: <https://powershellone.wordpress.com/2018/07/25/powershell-get-command-syntax-output-explained/>

    .example
        PS> Get-NinCommandSyntax Select-String

    #>
    param (
        [Parameter(
            Mandatory, Position = 0,
            HelpMessage = "Name of Command")]
        [string]$Name
    )
    $cmd = Get-Command -Syntax $Name
    $cmd -split ' (?=\[*-)' -replace '^[\[-]', '   $0'
}
