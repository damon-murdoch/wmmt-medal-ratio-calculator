Param(
  # Number of gold medals
  [Alias('g')][Parameter(Mandatory=$True)][String]$Gold, 

  # Number of silver medals
  [Alias('s')][Parameter(Mandatory=$True)][String]$Silver, 

  # Number of bronze medals
  [Alias('b')][Parameter(Mandatory=$True)][String]$Bronze, 

  # Number of black medals
  [Alias('p')][Parameter(Mandatory=$True)][String]$Plain,

  # Decimal Precision
  [Alias('d')][Parameter(Mandatory=$False)][Int]$Decimals = 2,

  # Verbose switch
  [Alias('c')][Parameter(Mandatory=$False)][Switch]$ValueOnly = $False
);

Try
{
  # Add the gold and silver medals together
  $TopHalf = $Gold + $Silver;

  # Add the bronze and black medals together
  $BottomHalf = $Bronze + $Plain;

  # If bottom half is equal to zero
  If (-Not $BottomHalf)
  {
    # Prevent divide by zero
    $BottomHalf = 1;
  }

  # Calculate the medal ratio (Round to precision decimals)
  $Ratio = [Math]::Round($TopHalf/$BottomHalf, $Decimals);

  # Verbose switch is set
  If (-Not $ValueOnly)
  {
    # Write the calculation to the output stream
    Write-Output "($Gold + $Silver) / ($Bronze + $Plain) = $($Ratio):1";
  }
  Else # Verbose switch not set
  {
    # Write the number to the output
    Write-Output $Ratio;
  }
}
Catch # Failed to calculate medal ratio
{
  Write-Output "Calculation failed: $($_.Exception.Message)";
}