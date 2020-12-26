$datetime = get-date
[System.Collections.ArrayList]$al = @()

 #If Day is Monday then backup these files

  if ($datetime.DayOfWeek -eq "Monday")
 {      
     #Replace the $filename array with your file location i.e. $filename = @('X:\readme.txt','report.xlsx','report2.xlsx')
     $filename = @('file location','file 2 location')
   for ($i = 0; $i -lt $filename.count ; $i++)
         {
         $awsquery = aws s3 cp $filename[$i] s3://com.example.backup/local_backups/ --cli-connect-timeout 6000 2>&1
         $al.Add(@($lastexitcode, $awsquery | Select-Object SyncRoot)) 
         }
 } 
 #If Day is Tuesday then backup these files
 if ($datetime.DayOfWeek -eq "Tuesday")
 {      
     #Replace the $filename array with your file location i.e. $filename = @('X:\readme2.txt','report2.xlsx','report23.xlsx')
     $filename = @('file location 3','file 4 location')
   for ($i = 0; $i -lt $filename.count ; $i++)
         {
         $awsquery = aws s3 cp $filename[$i] s3://com.example.backup/local_backups2/ --cli-connect-timeout 6000 2>&1
         $al.Add(@($lastexitcode, $awsquery | Select-Object SyncRoot)) 
         }
 }  
 
 # Send an email report using SMTP (Recommended to not to save passsword in clear text)
$EmailFrom = “from@example.com” 
$EmailTo = “from@example.com”
$Subject = “Daily backup report”
$Body = ($al | Out-String)
$SMTPServer = “mail.example.com”
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 1025)
$SMTPClient.EnableSsl = $false
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential(“mail@example.com”, “Password”);
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
    
 
