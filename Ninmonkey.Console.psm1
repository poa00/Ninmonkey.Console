﻿<#
    section: seeminglyScience Private
#>

# . 'C:\Users\cppmo_000\Documents\2020\powershell\MyModules_Github\Ninmonkey.Console\private\refactor to csharp\EncodingCompletion.ps1'

$private_seeminglySci = @(
    'seeminglySci_import'
    'NamespaceAwareCompletion'
    'Get-SciEnumInfo'
    # 'EncodingCompletion'
)
if ($psEditor) {
    Write-Debug 'loading namespaceAwareCompletions'
    # see: <https://github.com/SeeminglyScience/dotfiles/b lob/a7a9bcf3624efe5be4988922ba2e35e8ff2fcfd8/PowerShell%2Fprofile.ps1#L147>
    #  $private_seeminglySci.Remove('NamespaceAwareCompletion')
    $private_seeminglySci = $private_seeminglySci -ne 'NamespaceAwareCompletion'
}
foreach ($file in $private_seeminglySci) {
    Write-Warning "file: seeminglySci -> : $File"
    if (Test-Path ("{0}\private\seeminglySci\{1}.ps1" -f $psscriptroot, $file)) {
    } else {
        Write-Error "Import: failed: private_seeminglySci: private: $File"
    }
    . ("{0}\private\seeminglySci\{1}.ps1" -f $psscriptroot, $file)
}

<#
    section: Private
#>
$private = @(
    'Toast-LogTestNetResult'
)

foreach ($file in $private) {
    if (Test-Path ("{0}\private\{1}.ps1" -f $psscriptroot, $file)) {
    } else {
        Write-Error "Import: private: failed: private: $File"
    }
    . ("{0}\private\{1}.ps1" -f $psscriptroot, $file)
}

<#
    section: native apps
#>

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

<#
    section: Completers
#>
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
    'Write-ConsoleLabel'
    'Write-ConsoleHeader'
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
    'Format-Predent'
    'Sort-Hashtable'
    'Format-ControlChar'
    'Get-NinTypeData'
    # 'Get-NinFormatData'
    'Set-NinLocation'
    'Set-ConsoleEncoding'
    'Start-LogTestNet'
    'Test-Net'
    # 'Get-EnumInfo'
    'Format-FileSize'
    'Format-NullText'
    'ConvertTo-PropertyList'
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

<#
    section: public
#>
foreach ($file in $public) {
    if (Test-Path ("{0}\public\{1}.ps1" -f $psscriptroot, $file)) {
    } else {
        Write-Error "Import: failed: public: $File"
    }
    . ("{0}\public\{1}.ps1" -f $psscriptroot, $file)
}

$functionsToExport = @(
    'Write-ConsoleLabel'
    'Write-ConsoleHeader'
    'Format-TypeName'
    'Format-GenericTypeName'
    'Format-Hashtable'
    'Edit-GitConfig'
    'Export-PlatformFolderPath'
    'Get-NinNewestItem'
    'Format-Predent'
    'Test-UserIsAdmin'
    'Sort-Hashtable'
    'Invoke-Explorer'
    'Get-NinAppxPackage'
    'ConvertTo-PropertyList'
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
    'Get-SciEnumInfo'
    # 'Get-EnumInfo'
    'Get-NinModule'
    'Invoke-IPython'
    'Invoke-RipGrepChildItem'
    'Set-ConsoleEncoding'
    'Start-LogTestNet'
    'Test-Net'
    # seemingly-sci
    'ConvertTo-BitString'
    'ConvertTo-Number'
    'ConvertTo-HexString'
    'ConvertTo-Base64String'
)
Export-ModuleMember -Function $functionsToExport

<#
    section: FormatData
#>
$formatData = @(
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

if ($true) {
    # toggle auto importing of aliases', otherwise only use new-alias
    New-Alias -ea 'Ignore' 'Docs' -Value 'Get-Docs' -Description 'Jump to docs by language'
    New-Alias -ea 'Ignore' 'IPython' -Value 'Invoke-IPython' -Description 'ipython.exe defaults using my profile'

    # now set as an alias: New-Alias -ea 'Ignore' 'Goto' -Value Set-NinLocation -Description 'a more flexible version of Set-Location / cd'
    New-Alias -ea 'Ignore' 'Get-ObjectProperty' -Value Get-NinObjectProperty -Description 'Inspect object properties'
    New-Alias -ea 'Ignore' 'Here' -Value Invoke-Explorer -Description 'Open paths in explorer'
    New-Alias -ea 'Ignore' 'Prop' -Value Get-NinObjectProperty -Description 'Inspect object properties'
    New-Alias -ea 'Ignore' 'Type' -Value Get-ObjectType -Description 'Get type info'


    New-Alias 'Cd' -Value 'Set-NinLocation' #todo:  make this opt in

    # class-explorer
    New-Alias -ea 'Ignore' 'Fm' -Value 'Find-Member' -Description 'uses ClassExplorer'
    New-Alias -ea 'Ignore' 'Type' -Value Get-ObjectType -Description 'Get type info'
    New-Alias -ea 'Ignore' -Name 'Get-EnumInfo' -Value 'Get-SciEnumInfo'

    $aliasesToExport = @(
        'H1'
        'Format-Indent'
        'Get-EnumInfo'
        'Goto' # [Alias()] seems to still require export
        'nLs' # Get-NinChildItem
        'Cd'
        'Docs'
        'Get-ObjectProperty'
        'Here'
        'IPython'
        'Label'
        'Prop'
        'Fm'
        'Type'

        ## seemingly sci
        'Default'
        'Convert'
        'NameOf'
        'Base64'
        'Hex'
        'Number'
        'Bits'
    )

    Export-ModuleMember -Alias $aliasesToExport
}