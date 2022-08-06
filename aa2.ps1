function hoggingCpu(){
 Get-Process | `
 Sort-Object -property CPU -descending | `
 Select-Object -first 2
}
 $key=Get-ItemProperty $f
