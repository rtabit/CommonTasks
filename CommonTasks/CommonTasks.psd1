@{
    ModuleVersion        = '0.0.2'

    GUID                 = 'b095161b-ceef-4856-89a3-2c4af3f81c4d'

    Author               = 'NA'

    CompanyName          = 'NA'

    RequiredModules      = @('PSDesiredStateConfiguration')

    DscResourcesToExport = @('CommonTasks')

    Description          = 'DSC composite resource for https://github.com/AutomatedLab/DscWorkshop'

    PrivateData          = @{

        PSData = @{

            Tags = @('DSC', 'Configuration', 'Composite', 'Resource')

            ExternalModuleDependencies = @('PSDesiredStateConfiguration')

        }

    }

}