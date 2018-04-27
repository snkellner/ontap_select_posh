function Get-SDSCluster{
###############################
#.SYNOPSIS
#Short description
#
#.DESCRIPTION
#Long description
#
#.PARAMETER DeployServer
#Parameter description
#
#.EXAMPLE
#An example
#
#.NOTES
#General notes
##############################

    param(
        [Parameter(Mandatory=$false)]
        [string]$DeployServer

        ) 
    # actual code for the function goes here see the end of the topic for the complete code sample
    
    if ($global:SDSDeploy){
        $DeployServer = $variable:SDSDeploy.deploy_ipv4

        $Credential = $variable:SDSDeploy.Credential
        try {
            $_request_ = (Invoke-WebRequest -Uri "https://$($DeployServer)/api/v2/clusters" -SkipCertificateCheck -Method GET -ContentType JSON -Credential $Credential).content | ConvertFrom-Json
            return $_request_
        }
        catch {
            throw "Error connecting to ONTAP Select Deployment. Error Message: $($_.Exception.Message)" 
        }
        
    }else{
        write-host -foregroundcolor yellow "Not Connected to the Deployment Server. Please run ""Connect-SDSDeploy"" !`n"
    }

}



Export-ModuleMember Get-SDSCluster