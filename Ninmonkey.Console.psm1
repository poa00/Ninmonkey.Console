﻿$formatData = @(
    'System.RuntimeType'
    'Microsoft.PowerShell.Commands.TestConnectionCommand'
)

foreach ($typeName in $formatData) {
    $FileName = ("{0}\public\FormatData\nin-{1}.ps1xml" -f $psscriptroot, $typeName)
    if (Test-Path $FileName ) {
        Update-FormatData -PrependPath $FileName
        Write-Verbose "Imported: FormatData: [$TypeName] $FileName"
    } else {
        Write-Error "Import: failed: FormatData: [$TypeName]  $FileName"
    }
}

$private = @(
    'Toast-LogTestNetResult'
)

foreach ($file in $private) {
    if (Test-Path ("{0}\private\{1}.ps1" -f $psscriptroot, $file)) {
    } else {
        Write-Error "Import: failed: private: $File"
    }
    . ("{0}\private\{1}.ps1" -f $psscriptroot, $file)
}

$public_NativeWrapper = @(
    'Invoke-IPython'
    # 'Invoke-RipGrepChildItem'
)
foreach ($file in $public_NativeWrapper) {
    if (Test-Path ("{0}\public\native_wrapper\{1}.ps1" -f $psscriptroot, $file)) {
    } else {
        Write-Error "Import: failed: public\native_wrapper: $File"
    }
    . ("{0}\public\native_wrapper\{1}.ps1" -f $psscriptroot, $file)

}

Export-ModuleMember -Function $public_NativeWrapper

$completer = @(
    'Completer-dotnet'
    'Completer-RipGrep'
    'Completer-gh'
)

foreach ($file in $completer) {
    if (Test-Path ("{0}\public\completer\{1}.ps1" -f $psscriptroot, $file)) {
    } else {
        Write-Error "Import: failed: completer: $File"
    }
    . ("{0}\public\completer\{1}.ps1" -f $psscriptroot, $file)
}

Export-ModuleMember -Function $completer

$public = @(
    'Edit-GitConfig'
    'Export-PlatformFolderPath'
    'Format-Hashtable'
    'Format-History'
    'Format-MeasureCommand'
    'Format-TestConnection'
    'Get-ConsoleEncoding'
    'Get-Docs'
    'Test-UserIsAdmin'
    'Write-AnsiHyperlink'
    'Get-NinModule'
    'Trace-NinCommand'
    'Format-ControlChar'
    'Get-NinTypeData'
    # 'Get-NinFormatData'
    'Set-NinLocation'
    'Set-ConsoleEncoding'
    'Start-LogTestNet'
    'Test-Net'
    'Get-EnumInfo'
    'Format-FileSize'
    'Format-NullText'
    'Test-IsDirectory'
    'Get-NinCommandSyntax'
    'Format-TypeName'
    'Format-GenericTypeName'
    'Get-NinObjectProperty'
    'Test-NullArg'
    'Get-NinChildItem'
    'Get-ObjectType'
    'Get-NinAppxPackage'
    'Invoke-Explorer'
    'Get-TerminalName'
    'Get-NinNewestItem'
)

foreach ($file in $public) {
    if (Test-Path ("{0}\public\{1}.ps1" -f $psscriptroot, $file)) {
    } else {
        Write-Error "Import: failed: public: $File"
    }
    . ("{0}\public\{1}.ps1" -f $psscriptroot, $file)
}

$functionsToExport = @(
    'Edit-GitConfig'
    'Export-PlatformFolderPath'
    'Format-Hashtable'
    'Get-NinNewestItem'
    'Test-UserIsAdmin'
    'Invoke-Explorer'
    'Get-NinAppxPackage'
    'Format-TypeName'
    'Format-GenericTypeName'
    'Format-NullText'
    'Test-NullArg'
    'Get-NinObjectProperty'
    'Get-ObjectType'
    'Format-FileSize'
    'Format-ControlChar'
    'Trace-NinCommand'
    'Test-IsDirectory'
    'Set-NinLocation'
    'Get-NinCommandSyntax'
    'Get-NinTypeData'
    # 'Get-NinFormatData'
    'Format-History'
    'Get-TerminalName'
    'Write-AnsiHyperlink'
    'Get-NinChildItem'
    'Format-MeasureCommand'
    'Format-TestConnection'
    'Get-ConsoleEncoding'
    'Get-Docs'
    'Get-EnumInfo'
    'Get-NinModule'
    'Invoke-IPython'
    'Invoke-RipGrepChildItem'
    'Set-ConsoleEncoding'
    'Start-LogTestNet'
    'Test-Net'
)
Export-ModuleMember -Function $functionsToExport

if ($true) {
    # toggle auto importing of aliases', otherwise only use new-alias
    New-Alias -ea 'Ignore' 'Docs' -Value 'Get-Docs' -Description 'Jump to docs by language'
    New-Alias -ea 'Ignore' 'IPython' -Value 'Invoke-IPython' -Description 'ipython.exe defaults using my profile'

    # now set as an alias: New-Alias -ea 'Ignore' 'Goto' -Value Set-NinLocation -Description 'a more flexible version of Set-Location / cd'
    New-Alias -ea 'Ignore' 'Here' -Value Invoke-Explorer -Description 'Open paths in explorer'
    New-Alias -ea 'Ignore' 'Get-ObjectProperty' -Value Get-NinObjectProperty -Description 'Inspect object properties'
    New-Alias -ea 'Ignore' 'Prop' -Value Get-NinObjectProperty -Description 'Inspect object properties'
    New-Alias -ea 'Ignore' 'Type' -Value Get-ObjectType -Description 'Get type info'


    New-Alias 'Cd' -Value 'Set-NinLocation' #todo:  make this opt in


    $aliasesToExport = @(
        'Goto' # [Alias()] seems to still require export
        'nLs' # Get-NinChildItem
        'Docs'
        'IPython'
        'Cd'
        'Here'
        'Get-ObjectProperty'
        'Prop'
    )

    Export-ModuleMember -Alias $aliasesToExport
}