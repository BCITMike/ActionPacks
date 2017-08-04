﻿#Requires -Modules MSOnline

<#
    .SYNOPSIS
        Connect to MS Online and modifies a user in Azure Active Directory.
        Only parameters with value are set
        Requirements 
        64-bit OS for all Modules 
        Microsoft Online Sign-In Assistant for IT Professionals  
        Azure Active Directory Powershell Module v1
    
    .DESCRIPTION  

    .NOTES
        This PowerShell script was developed and optimized for ScriptRunner. The use of the scripts requires ScriptRunner. 
        The customer or user is authorized to copy the script from the repository and use them in ScriptRunner. 
        The terms of use for ScriptRunner do not apply to this script. In particular, AppSphere AG assumes no liability for the function, 
        the use and the consequences of the use of this freely available script.
        PowerShell is a product of Microsoft Corporation. ScriptRunner is a product of AppSphere AG.
        © AppSphere AG

    .Parameter O365Account
        Specifies the credential to use to connect to Azure Active Directory
    
    .Parameter UserObjectId
        Specifies the unique ID of the user from which to set properties

    .Parameter UserName
        Specifies the Display name, Sign-In Name or user principal name of the user from which to set properties

    .Parameter DisplayName
        Specifies the display name of the user

    .Parameter FirstName
        Specifies the first name of the user

    .Parameter LastName
        Specifies the last name of the user

    .Parameter PostalCode
        Specifies the postal code of the user

    .Parameter City
        Specifies the city of the user

    .Parameter Street
        Specifies the street address of the user

    .Parameter PhoneNumber
        Specifies the phone number of the user

    .Parameter MobilePhone
        Specifies the mobile phone number of the user

    .Parameter Office
        Specifies the office of the user

    .Parameter Department
        Specifies the department of the user

    .Parameter PasswordNeverExpires
        Specifies whether the user password expires periodically

    .Parameter Enabled
        Specifies whether the user is able to log on using their user ID

    .Parameter TenantId
        Specifies the unique ID of the tenant on which to perform the operation
#>

param(
<#   
    [Parameter(Mandatory = $true,ParameterSetName = "User name")]
    [Parameter(Mandatory = $true,ParameterSetName = "User object id")]
    [PSCredential]$O365Account,
#>
    [Parameter(Mandatory = $true,ParameterSetName = "User object id")]
    [guid]$UserObjectId,
    [Parameter(Mandatory = $true,ParameterSetName = "User name")]
    [string]$UserName,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [string]$DisplayName,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [string]$FirstName,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [string]$LastName,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [string]$PostalCode,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [string]$City,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [string]$Street,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [string]$PhoneNumber,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [string]$MobilePhone,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [string]$Office,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [string]$Department,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [switch]$ForceChangePassword,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [switch]$PasswordNeverExpires,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [switch]$Enabled,
    [Parameter(ParameterSetName = "User name")]
    [Parameter(ParameterSetName = "User object id")]    
    [guid]$TenantId
)

# Import-Module MSOnline

#Clear
# $ErrorActionPreference='Stop'

# Connect-MsolService -Credential $O365Account 

if($PSCmdlet.ParameterSetName  -eq "User object id"){
    $Script:User = Get-MsolUser -ObjectId $UserObjectId -TenantId $TenantId  | Select-Object ObjectID
}
else{
    $Script:User = Get-MsolUser -TenantId $TenantId | `
    Where-Object {($_.DisplayName -eq $UserName) -or ($_.SignInName -eq $UserName) -or ($_.UserPrincipalName -eq $UserName)} | `
    Select-Object ObjectID,DisplayName
}
if($null -ne $Script:User){
    if(-not [System.String]::IsNullOrWhiteSpace($DisplayName)){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -DisplayName $DisplayName
    }
    if(-not [System.String]::IsNullOrWhiteSpace($FirstName)){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -FirstName $FirstName
    }
    if(-not [System.String]::IsNullOrWhiteSpace($LastName)){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -LastName $LastName
    }
    if(-not [System.String]::IsNullOrWhiteSpace($PostalCode)){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -PostalCode $PostalCode
    }
    if(-not [System.String]::IsNullOrWhiteSpace($City)){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -City $City
    }
    if(-not [System.String]::IsNullOrWhiteSpace($Street)){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -StreetAddress $Street
    }
    if(-not [System.String]::IsNullOrWhiteSpace($PhoneNumber)){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -PhoneNumber $PhoneNumber
    }
    if(-not [System.String]::IsNullOrWhiteSpace($MobilePhone)){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -MobilePhone $MobilePhone
    }
    if(-not [System.String]::IsNullOrWhiteSpace($Office)){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -Office $Office
    }
    if(-not [System.String]::IsNullOrWhiteSpace($Department)){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -Department $Department
    }
    if($PSBoundParameters.ContainsKey('PasswordNeverExpires') -eq $true ){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -PasswordNeverExpires $PasswordNeverExpires.ToBool()
    }
    if($PSBoundParameters.ContainsKey('Enabled') -eq $true ){
        Set-MsolUser -TenantId $TenantId -ObjectId $Script:User.ObjectId -BlockCredential (-not $Enabled)
    }
    $Script:User = Get-MsolUser -ObjectId $Script:User.ObjectId -TenantId $TenantId  | Select-Object *
    if($SRXEnv) {
        $SRXEnv.ResultMessage = $Script:User
    } 
    else{
        Write-Output $Script:User 
    }
}
else{
    if($SRXEnv) {
        $SRXEnv.ResultMessage = "User not found"
    }    
    Throw "User not found"
}