  MEMBER('SiDock.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('SiDock_BC0.CLW')
SiDock_BC0:DctInit             PROCEDURE()
SiDock_BC0:DctKill             PROCEDURE()
SiDock_BC0:FilesInit           PROCEDURE()
    END
  END

DctInit PROCEDURE()
  CODE
  SiDock_BC0:DctInit
  SiDock_BC0:FilesInit


DctKill PROCEDURE()
  CODE
  SiDock_BC0:DctKill

