$configData = Import-LocalizedData -BaseDirectory $PSScriptRoot\Assets -FileName Config1.psd1 -SupportedCommand New-Object, ConvertTo-SecureString -ErrorAction Stop
$moduleName = $env:BHProjectName

Remove-Module -Name $env:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module -Name $env:BHProjectName -ErrorAction Stop

Import-Module -Name DscBuildHelpers

Describe 'DscLcmMaintenanceWindow DSC Resource compiles' -Tags 'FunctionalQuality' {
    It 'DscLcmMaintenanceWindow Compiles' {
        configuration Config_DscLcmMaintenanceWindow {

            Import-DscResource -ModuleName CommonTasks

            node localhost_DscLcmMaintenanceWindow {
                DscLcmMaintenanceWindow controller {
                    MaintenanceWindow = $ConfigurationData.DscLcmMaintenanceWindow.MaintenanceWindow
                }
            }
        }

        { Config_DscLcmMaintenanceWindow -ConfigurationData $configData -OutputPath $env:BHBuildOutput -ErrorAction Stop } | Should -Not -Throw
    }

    It 'DscLcmMaintenanceWindow should have created a mof file' {
        $mofFile = Get-Item -Path $env:BHBuildOutput\localhost_DscLcmMaintenanceWindow.mof -ErrorAction SilentlyContinue
        $mofFile | Should -BeOfType System.IO.FileInfo
    }
}