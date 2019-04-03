Function New-HTMLPanel {
    [alias('New-HTMLColumn')]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0)][ValidateNotNull()][ScriptBlock] $Content = $(Throw "Open curly brace with Content"),
        [alias('ColumnCount', 'Columns')][ValidateSet('1', '2', '3', '4', '5 ', '6', '7', '8', '9', '10', '11', '12')][string] $Count = 1,
        [alias('BackgroundShade')][RGBColors]$BackgroundColor,
        [switch] $Invisible,
        [int] $Height
    )
    if ($Height -ne 0) { 
        $StyleHeight = "height: $($Height)px" 
    }    
    $StyleWidth = "width: calc(100% / $Count - 10px)"

    if ($null -ne $BackgroundColor) {
        $BackGroundColorFromRGB = ConvertFrom-Color -Color $BackgroundColor
        $DivColumnStyle = "background-color:$BackGroundColorFromRGB; $StyleWidth; $StyleHeight;"
    } else {
        $DivColumnStyle = "$StyleWidth; $StyleHeight;"
    }
    if ($Invisible) {
        $DivColumnStyle = "$DivColumnStyle box-shadow: unset !important;"
    }
    New-HTMLTag -Tag 'div' -Attributes @{ class = "defaultPanel defaultCard"; style = $DivColumnStyle } {
        Invoke-Command -ScriptBlock $Content
    }
}