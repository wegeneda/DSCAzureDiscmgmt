Configuration hpcnode {
 
    #Module Import
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"
    Import-DSCResource -ModuleName "xStorage"
    Import-DscResource -ModuleName "cMoveAzureTempDrive"

    Node Standard {
        
        cMoveAzureTempDrive cMoveAzureTempDrive
        {
            TempDriveLetter = 'T'
            Name = 'temp'
        }

        # create Data Disk
        xWaitforDisk DataDisk {
            dependsON        = "[cMoveAzureTempDrive]cMoveAzureTempDrive"
            DiskId           = "2"
            RetryIntervalSec = 60
            RetryCount       = 60
        }
        xDisk VolumeM {
            DiskId      = "2"
            DriveLetter = "D"
            FSLabel     = "Data01"
            DependsOn   = "[xWaitforDisk]DataDisk"
        }
    }        
}
