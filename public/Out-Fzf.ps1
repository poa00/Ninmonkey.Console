﻿function Out-Fzf {
    <#
    .synopsis
        uses commandline app 'fzf' similar to 'out-gridview'
    .description
        a simple multi-item selection for the console without the extra features of 'Out-ConsoleGridView'
    .notes
        selected items are returned **in-order** that they are selected in 'fzf'

        'fzf' is documented here:

        - [wiki of fzf examples](https://github.com/junegunn/fzf/wiki/examples)
        - [keybinding and their related ENV vars](https://github.com/junegunn/fzf#key-bindings-for-command-line)
        - [Youtube: Vim universe. fzf - command line fuzzy finder](https://youtu.be/qgG5Jhi_Els)
        - [integrating with 'fd'](https://github.com/junegunn/fzf#respecting-gitignore)
            # Setting fd as the default source for fzf
            export FZF_DEFAULT_COMMAND='fd --type f'
        - [args: preview Window](https://github.com/junegunn/fzf#preview-window)
        - [execute external programs](https://github.com/junegunn/fzf#executing-external-programs)
        - [automatically reloading list](https://github.com/junegunn/fzf#reloading-the-candidate-list)
        - [preview modes](https://github.com/junegunn/fzf#preview-window)
        - [regex-like syntax](https://github.com/junegunn/fzf#search-syntax)
            space delimited like:
                ^music .mp3$ sbtrkt !fire

    env vars:
        main:
            FZF_DEFAULT_COMMAND
            FZF_DEFAULT_OPTS

        hotkey related:
            [hotkey binding docs](https://github.com/junegunn/fzf#key-bindings-for-command-line)
            [hotkey binding wiki](https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings)

            FZF_ALT_C_COMMAND
            FZF_ALT_C_OPTS
            FZF_CTRL_R_OPTS
            FZF_CTRL_T_COMMAND
            FZF_CTRL_T_OPTS

    .example
        PS>
    .notes
        .
    #>
    param (
        # show help
        [Parameter()][switch]$Help,

        # Multi select
        [Parameter()][switch]$MultiSelect,

        # Prompt title
        [Parameter()]
        [String]$PromptText,


        # main piped input
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]$InputText,

        # fzf's default is 'reverse'
        [Parameter()]
        [ValidateSet('default', 'reverse', 'reverse-list')]
        [string]$Layout


        # Optional args as raw text as the final parameter
        # [Parameter()]
        # [string]$FinalArgs

        # [1] Future: param -Property
        # [2] future: support PSObjects with property '.Name' or ToString


        # future: Maximum selection: --multi[=max]
        # [Parameter()][int]$MaxMultiSelect
    )

    begin {
        $debugMeta = @{}

        if ($Help) {
            '<https://github.com/junegunn/fzf#tips> and ''fzf --help'''
            break
        }
        # to: refactor /w Get-NativeCommand
        $binFzf = Get-Command 'fzf' -CommandType Application
        $fzfArgs = @()
        $inputList = [list[string]]::New()

        if ( ! [String]::IsNullOrWhiteSpace(  $PromptText  ) ) {
            $fzfArgs += ("--prompt={0}" -f $PromptText)
        }

        if ($MultiSelect) {
            $fzfArgs += '--multi'
        }
        if($Layout) {
            $fzfArgs += "--layout=$Layout"
        }

        $debugMeta.FzfArgs = $fzfArgs
    }
    process {
        foreach ($Line in $InputText) {
            $inputList.add( $Line )
        }
    }

    end {
        $Selection = $inputList | & $binFzf @fzfArgs
        $Selection

        # style 1]
        # $debugMeta.InputListCount = $inputList.Count
        # $debugMeta.SelectionCount = $Selection.Count
        # $debugMeta.Selection = $Selection | Join-String -sep ', ' -SingleQuote | Label 'Selection'

        # style 2]
        # style wise, this looks cleaner, but throws on duplicate key names
        $debugMeta += @{
            InputListCount = $inputList.Count
            SelectionCount = $Selection.Count
            Selection      = $Selection | Join-String -sep ', ' -SingleQuote | Label  'Selection'

        }
        $debugMeta | Format-HashTable -Title '@debugMeta' | Write-Debug
        $debugMeta.SelectionCount | Label 'Num Selected' | Write-Debug
        $Selection | Join-String -sep ', ' -SingleQuote | Label  'Selection' | Write-Debug

        $fzfArgs | Join-String -sep "`n-" -SingleQuote | Label 'FzfArgs' | Write-Debug
    }
}

if ($false) {
    Goto $nin_paths.GithubDownloads
    <# examples
        Out-Fzf -Debug -Help
        Out-Fzf -Debug -PromptText 'cat' -Help
        # $x = Out-Fzf
        #>

    Get-ChildItem | Select-Object -First 3
    | Out-Fzf -Debug

    # Get-ChildItem -Name | Out-Fzf -MultiSelect -Debug
}
