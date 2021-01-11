
function Format-HashTableList {
    <#
    .synopsis
        pretty prints a list of hashtables as single lines
    .description
        expects a [hashtable[]]
    .notes
        refactor to a list of any type with nested expansion ?


    #>
    param(
        # List of [Hashtable]
        [Parameter(Mandatory, ValueFromPipeline)]
        # [hashtable[]]$InputList
        [hashtable[]]$InputList
    )

    begin {
        $Depth = 1
        $SpacesPerIndent = 4
        $IndentString = (' ' * $SpacesPerIndent) -join ''
    }
    process {
        # foreach ($element in $InputList) {
        $NestedIndentString = $IndentString * $Depth
        $PrefixTypeName = TypeOf -InputObject $InputList
        $joinStringSplat = @{
            OutputPrefix = "${PrefixTypeName} = @(`n${NestedIndentString}"
            Separator    = "`n${NestedIndentString}"
            OutputSuffix = "`n)"
        }

        $InputList | ForEach-Object {
            $_ | Format-HashTable SingleLine
        } | Join-String @joinStringSplat
        # }
    }
}
