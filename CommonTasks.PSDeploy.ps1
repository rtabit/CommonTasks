if (
    (Join-Path -Path $ENV:BHProjectPath -ChildPath $ENV:BHProjectName) -and
    $env:BHBuildSystem -ne 'Unknown' -and
    $env:BHBranchName -eq "master"
) {
    Deploy Module {
        By PSGalleryModule {
            FromSource (Join-Path -Path $ENV:BHProjectPath -ChildPath $ENV:BHProjectName)
            To PSGallery
            WithOptions @{
                ApiKey = $ENV:NugetApiKey
            }
        }
    }
}
else {
    "Skipping deployment: To deploy, ensure that...`n" +
    "`t* You are in a known build system (Current: $ENV:BHBuildSystem)`n" +
    "`t* You are committing to the master branch (Current: $ENV:BHBranchName) `n" +
    "`t* Module path is valid (Current: $(Join-Path $ENV:BHProjectPath $ENV:BHProjectName))" |
        Write-Host
}

# Publish to AppVeyor if we're in AppVeyor
if (
    (Join-Path -Path $ENV:BHProjectPath -ChildPath $ENV:BHProjectName) -and
    $env:BHBuildSystem -eq 'AppVeyor'
) {
    Deploy DeveloperBuild {
        By AppVeyorModule {
            FromSource (Join-Path -Path $ENV:BHProjectPath -ChildPath $ENV:BHProjectName)
            To AppVeyor
            WithOptions @{
                Version = $env:APPVEYOR_BUILD_VERSION
            }
        }
    }
}