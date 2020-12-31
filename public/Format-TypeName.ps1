﻿function Format-TypeName {
    <#
    .synopsis
        Formats type names to be more readable, removes common prefixes
    .example
        # $cat is a [pscustomobject] with PSTypeName = 'Nin.Animal'
        PS> $cat.pstypenames | Format-TypeName | join-string -sep ', ' { "[$_]" }

            [Selected.System.Management.Automation.PSCustomObject], [Nin.Animal], [PSCustomObject], [Object]
    .notes
    see also:
        [ParameterMetadata](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.parametermetadata?view=powershellsdk-7.0.0)]

        [https://docs.microsoft.com/en-us/dotnet/api/system.reflection.typeinfo?view=netcore-3.1#properties]
    #>
    param(
        # list of types as strings
        [Parameter(ParameterSetName = "paramTypeAsString", Mandatory, ValueFromPipeline)]
        [string]$TypeName,

        # list of types / type instances
        [Parameter(ParameterSetName = "paramTypeAsInstance", ValueFromPipeline)]
        [System.Reflection.TypeInfo]$TypeInstance,

        # A List of Namespaces or prefixes to ignore: -IgnoreNamespace
        [Parameter()][Alias('WithoutPrefix')]
        [string[]]$IgnorePrefix = @(),

        # A list of Namespaces to include (overriding defaults)
        [Parameter()][Alias('WithPrefix')]
        [string[]]$IncludePrefix = @(),

        # surround type names with '[]' ?
        [Alias('Brackets')]
        [Parameter()][switch]$WithBrackets


        # [Alias('WithoutBrackets')]
        # [Parameter()][switch]$NoBrackets
    )
    begin {
        $DefaultIgnorePrefix = @(
            'System.Collections.Generic'
            'System.Collections'
            'System.Management.Automation'
            'System.Runtime.CompilerServices'
            'System.Text'
            'System'
        )
        # Sorting by longest regex simplifies namespace collisions when handling  removal
        $DefaultIgnorePrefix | Join-String -sep ', ' | Label 'IgnoreDefault' | Write-Debug
        $IgnorePrefix | Join-String -sep ', ' | Label 'IgnorePrefix' | Write-Debug

        $IgnorePrefix += $DefaultIgnorePrefix
        $IgnorePrefix = $IgnorePrefix | Sort-Object -Property Length -Descending
        $IgnorePrefix | Join-String -sep ', ' | Label 'IgnoreCombined' | Write-Debug


        # Write-Warning 'Ignore prefix is not working?'

        if ( $IncludePrefix.Count -gt 0) {
            throw "Prefix include list NYI"
        }
    }

    Process {
        <#
        refactor:
            attempt 'typenameString' -as 'type' before other parsing
        #>

        switch ( $PSCmdlet.ParameterSetName ) {
            'paramTypeAsString' {
                Write-Debug "Original: $TypeName"
                $TypeAsString = $TypeName
                Write-Verbose 'Nyi: Regex (Format-TypeName)'
                # throw "NYI: get regex: NYI"
                break
            }
            'paramTypeAsInstance' {
                if ($TypeInstance.IsGenericType) {
                    Write-Debug 'IsGenericType: True'
                    $TypeInstance | Format-GenericTypeName -WithBrackets:$WithBrackets
                    return # full exit
                }

                Write-Debug "Instance: $TypeInstance"
                $TypeAsString = $TypeInstance.FullName
                break
            }
            default { throw "not implemented parameter set: $switch" }
        }

        $filteredName = $TypeAsString
        foreach ($prefix in $IgnorePrefix) {
            $Pattern = '^{0}\.' -f [regex]::Escape( $prefix )
            $filteredName = $filteredName -replace $Pattern, ''
            continue
        }
        if (! $WithBrackets) {
            $filteredName
        } else {
            '[', $filteredName, ']' -join ''
        }
    }

}


function NestedOrNot( [type]$TypeInfo ) {
    H1 'nestedOrNot'
    $isNested = $typeInfo.IsNested
    Label 'Nested' $isNested
    @{
        IsNested = $typeInfo.Name
        Name     = $typeInfo.Name
    } | Format-HashTable

    if ($false) {
        ( $typeInfo.IsNested ) ? $typeInfo.DeclaringType : $typeInfo.Name
        $true -eq $typeinfo.IsNested | Label 'IsNested?: '
        $nestedTypeName = $typeinfo.DeclaringType.Name, $typeinfo.Name -join '+'
        ( $typeinfo.namespace), $nestedTypeName -join '.'
    }

}

& {
    if ($false -or 'quick test') {
        $typeName = 'System.Collections.Generic.Dictionary`2+KeyCollection[[System.String],[System.Management.Automation.ParameterMetadata]]'
        $TypeInfo = $typeName -as 'type'
        NestedOrNot 'dsf'.GetType()
        #| label 'string '
        NestedOrNot $typeinfo
        #| Label 'typeinfo '

    }
} | Write-Debug