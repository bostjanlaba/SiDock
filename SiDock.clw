   PROGRAM


NetTalk:TemplateVersion equate('11.33')
ActivateNetTalk   EQUATE(1)
  include('NetCrit.inc'),once
  include('NetAll.inc'),once
  include('NetMap.inc'),once
  include('NetTalk.inc'),once
  include('NetSimp.inc'),once
  include('NetFtp.inc'),once
  include('NetHttp.inc'),once
  include('NetWww.inc'),once
  include('NetSync.inc'),once
  include('NetWeb.inc'),once
  include('NetWebSocketClient.inc'),once
  include('NetWebSocketServer.inc'),once
  include('NetWebM.inc'),once
  include('NetWSDL.inc'),once
  include('NetEmail.inc'),once
  include('NetFile.inc'),once
  include('NetWebSms.inc'),once
  Include('NetOauth.inc'),once
  Include('NetLDAP.inc'),once
  Include('NetMaps.inc'),once
  Include('NetDrive.inc'),once
  Include('NetSms.inc'),once
StringTheory:TemplateVersion equate('3.21')
Cryptonite:TemplateVersion   equate('1.98')
OddJob:TemplateVersion equate('1.43')
HyperActive:TemplateVersion equate('2.28')
_ezHelpDisabled           equate(1)
WinEvent:TemplateVersion      equate('5.29')

   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ACTIVEIMAGE.INC'),ONCE
   INCLUDE('CSIDL.EQU'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('EASYHTMLEX.INC'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('SPECIALFOLDER.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
  include('StringTheory.Inc'),ONCE
  include('Cryptonite.inc'),Once
  include('CsBlowfish.Inc'),Once
  include('cwsynchc.inc'),once  ! added by NetTalk
  include('OddJob.Inc'),ONCE
   include('Hyper.Inc'),ONCE
    Include('WinEvent.Inc'),Once

   MAP
     MODULE('SIDOCK_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('SIDOCK001.CLW')
Main                   PROCEDURE   !
     END
         MODULE('vuFT4.dll')
      vuAnimateCloseBlend(LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuAnimateCloseBlend')
      vuAnimateCloseCenter(LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuAnimateCloseCenter')
      vuAnimateCloseRoll(LONG,LONG,LONG,LONG,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuAnimateCloseRoll')
      vuAnimateCloseSlide(LONG,LONG,LONG,LONG,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuAnimateCloseSlide')
      vuAnimateOpenBlend(LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuAnimateOpenBlend')
      vuAnimateOpenCenter(LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuAnimateOpenCenter')
      vuAnimateOpenRoll(LONG,LONG,LONG,LONG,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuAnimateOpenRoll')
      vuAnimateOpenSlide(LONG,LONG,LONG,LONG,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuAnimateOpenSlide')
      vuBatteryLife(),LONG,PROC,Pascal,Raw,Name('vuBatteryLife')
      vuBinary(Long),CSTRING,PROC,Pascal,Raw,Name('vuBinary')
      vuBIOSSerialNo(),CSTRING,PROC,Pascal,Raw,Name('vuBIOSSerialNo')
      vuCenterWindow(Long),Signed,PROC,Pascal,Raw,Name('vuCenterWindow')
      vuChangeDisplay(LONG,LONG,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuChangeDisplay')
      vuCleanBoot(),Signed,PROC,Pascal,Raw,Name('vuCleanBoot')
      vuClearRecentDocs(),Signed,PROC,Pascal,Raw,Name('vuClearRecentDocs')
      vuClientHeight(),Long,PROC,Pascal,Raw,Name('vuClientHeight')
      vuClientWidth(),Long,PROC,Pascal,Raw,Name('vuClientWidth')
      vuCloseDisable(LONG),Signed,PROC,Pascal,Raw,Name('vuCloseDisable')
      vuCompress(*CSTRING,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuCompress')
      vuComputerName(),CSTRING,PROC,Pascal,Raw,Name('vuComputerName')
      vuCopy(*CSTRING,*CSTRING,LONG),Signed,PROC,Pascal,Raw,Name('vuCopy')
      vuCPUMake(),CSTRING,PROC,Pascal,Raw,Name('vuCPUMake')
      vuCPUSerialNo(),CSTRING,PROC,Pascal,Raw,Name('vuCPUSerialNo')
      vuCPUSpeed(),Long,PROC,Pascal,Raw,Name('vuCPUSpeed')
      vuCPUusage(),Signed,PROC,Pascal,Raw,Name('vuCPUusage')
      vuCRC32(*CSTRING),LONG,PROC,Pascal,Raw,Name('vuCRC32')
      vuCreateDirectory(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuCreateDirectory')
      vuCreateLink(LONG,*CSTRING,*CSTRING,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuCreateLink')
      vuCreateLinkEx(LONG,*CSTRING,*CSTRING,*CSTRING,*CSTRING,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuCreateLinkEx')
      vuCurrentPath(),CSTRING,PROC,Pascal,Raw,Name('vuCurrentPath')
      vuDelete(*CSTRING,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuDelete')
      vuDesktopIcons(LONG),Signed,PROC,Pascal,Raw,Name('vuDesktopIcons')
      vuDisableOthers(*CSTRING,LONG),Signed,PROC,Pascal,Raw,Name('vuDisableOthers')
      vuDiskLabel(),CSTRING,PROC,Pascal,Raw,Name('vuDiskLabel')
      vuDiskSerialNo(),Long,PROC,Pascal,Raw,Name('vuDiskSerialNo')
      vuDiskSpace(*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuDiskSpace')
      vuDriveType(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuDriveType')
      vuEMailClient(),CSTRING,PROC,Pascal,Raw,Name('vuEMailClient')
      vuExtractFileName(*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuExtractFileName')
      vuExtractFilePath(*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuExtractFilePath')
      vuEZRegGet(LONG,*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuEZRegGet')
      vuEZRegPut(LONG,*CSTRING,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuEZRegPut')
      vuFadeIn(Long),Signed,PROC,Pascal,Raw,Name('vuFadeIn')
      vuFadeInOthers(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuFadeInOthers')
      vuFadeOut(Long),Signed,PROC,Pascal,Raw,Name('vuFadeOut')
      vuFadeOutOthers(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuFadeOutOthers')
      vuFileCount(*CSTRING),Long,PROC,Pascal,Raw,Name('vuFileCount')
      vuFileDate(*CSTRING,LONG),LONG,PROC,Pascal,Raw,Name('vuFileDate')
      vuFileSize(*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuFileSize')
      vuFileTime(*CSTRING,LONG),Long,PROC,Pascal,Raw,Name('vuFileTime')
      vuFileType(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuFileType')
      vuFindFile(*CSTRING,*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuFindFile')
      vuFlashWindow(Long,Long),Signed,PROC,Pascal,Raw,Name('vuFlashWindow')
      vuFolderDate(*CSTRING),Long,PROC,Pascal,Raw,Name('vuFolderDate')
      vuFolderExists(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuFolderExists')
      vuFolderTime(*CSTRING),Long,PROC,Pascal,Raw,Name('vuFolderTime')
      vuFolderWatchCheck(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuFolderWatchCheck')
      vuFolderWatchStart(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuFolderWatchStart')
      vuFolderWatchStop(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuFolderWatchStop')
      vuFolderWatchStopAll(),Signed,PROC,Pascal,Raw,Name('vuFolderWatchStopAll')
      vuFolderWatchCount(),Signed,PROC,Pascal,Raw,Name('vuFolderWatchCount') 
      vuFontDirectory(),CSTRING,PROC,Pascal,Raw,Name('vuFontDirectory')
      vuFontLoad(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuFontLoad')
      vuFontUnload(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuFontUnload')
      vuFreeSpace(*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuFreeSpace')
      vuGetAttributes(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuGetAttributes')
      vuGetDefaultPrinter(),CSTRING,PROC,Pascal,Raw,Name('vuGetDefaultPrinter')
      vuHexadecimal(Long),CSTRING,PROC,Pascal,Raw,Name('vuHexadecimal')
      vuHideStartButton(LONG),Signed,PROC,Pascal,Raw,Name('vuHideStartButton')
      vuIdleTime(),Long,PROC,Pascal,Raw,Name('vuIdleTime')
      vuIPAddress(LONG),CSTRING,PROC,Pascal,Raw,Name('vuIPAddress')
      vuIPAddressCount(),LONG,PROC,Pascal,Raw,Name('vuIPAddressCount')
      vuIsAdmin(),Signed,PROC,Pascal,Raw,Name('vuIsAdmin')
      vuIsDriveReady(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuIsDriveReady')
      vuIsOS64(),Long,PROC,Pascal,Raw,Name('vuIsOS64')
      vuIsRunning(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuIsRunning')
      vuIsRunningCheck(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuIsRunningCheck')
      vuKeepChars(*CSTRING,*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuKeepChars')
      vuMACAddress(Long),CSTRING,PROC,Pascal,Raw,Name('vuMACAddress')
      vuMACCount(),LONG,PROC,Pascal,Raw,Name('vuMACCount')
      vuMACDesc(Long),CSTRING,PROC,Pascal,Raw,Name('vuMACDesc')
      vuMACType(Long),CSTRING,PROC,Pascal,Raw,Name('vuMACType')
      vuMailSlotCheck(*CSTRING,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuMailSlotCheck')
      vuMailSlotCreate(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuMailSlotCreate')
      vuMailSlotDestroy(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuMailSlotDestroy')
      vuMailSlotDestroyAll(),Signed,PROC,Pascal,Raw,Name('vuMailSlotDestroyAll')
      vuMailSlotSend(*CSTRING,*CSTRING,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuMailSlotSend')
      vuMapped2UNC(*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuMapped2UNC')
      vuMaximizeDisable(LONG),Signed,PROC,Pascal,Raw,Name('vuMaximizeDisable')
      vuMCISend(*CSTRING),Long,PROC,Pascal,Raw,Name('vuMCISend')
      vuMemoryFree(),REAL,PROC,Pascal,Raw,Name('vuMemoryFree')
      vuMemoryPercentUsed(),LONG,PROC,Pascal,Raw,Name('vuMemoryPercentUsed')
      vuMemoryTotal(),REAL,PROC,Pascal,Raw,Name('vuMemoryTotal')
      vuMinimizePrograms(LONG),Signed,PROC,Pascal,Raw,Name('vuMinimizePrograms')
      vuMove(*CSTRING,*CSTRING,LONG),Signed,PROC,Pascal,Raw,Name('vuMove')
      vuMoveDisable(LONG),Signed,PROC,Pascal,Raw,Name('vuMoveDisable')
      vuNetworkPresent(),Signed,PROC,Pascal,Raw,Name('vuNetworkPresent')
      vuNetworkUser(),CSTRING,PROC,Pascal,Raw,Name('vuNetworkUser')
      vuNumber2String(LONG),CSTRING,PROC,Pascal,Raw,Name('vuNumber2String')
      vuOctal(Long),CSTRING,PROC,Pascal,Raw,Name('vuOctal')
      vuOSVersion(),Signed,PROC,Pascal,Raw,Name('vuOSVersion')
      vuPack(*CSTRING,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuPack')
      vuPlayWav(*CSTRING,LONG),Signed,PROC,Pascal,Raw,Name('vuPlayWav')
      vuPrinterCount(),Long,PROC,Pascal,Raw,Name('vuPrinterCount')
      vuPrinterName(LONG),CSTRING,PROC,Pascal,Raw,Name('vuPrinterName')
      vuPrintScreen(),Signed,PROC,Pascal,Raw,Name('vuPrintScreen')
      vuPrintTextFile(*CSTRING,LONG),Signed,PROC,Pascal,Raw,Name('vuPrintTextFile') 
      vuPrintWindow(),Signed,PROC,Pascal,Raw,Name('vuprintWindow')
      vuProcessorCount(),LONG,PROC,Pascal,Raw,Name('vuProcessorCount')
      vuQuotes(*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuQuotes')
      vuRecordWav(LONG,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuRecordWav')
      vuRemoveChars(*CSTRING,*CSTRING,Long),CSTRING,PROC,Pascal,Raw,Name('vuRemoveChars')
      vuReplaceChars(*CSTRING, *CSTRING, *CSTRING),Long,PROC,Pascal,Raw,Name('vuReplaceChars')
      vuReplaceCharsInFile(*CSTRING, *CSTRING, *CSTRING),Long,PROC,Pascal,Raw,Name('vuReplaceCharsInFile')
      vuRun(*CSTRING,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuRun')
      vuRunOnReboot(LONG),Signed,PROC,Pascal,Raw,Name('vuRunOnReboot')
      vuSayText(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuSayText')
      vuScreen2Bmp(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuScreen2Bmp')
      vuScreenDensity(),Long,PROC,Pascal,Raw,Name('vuScreenDensity')
      vuScreenHeight(),Long,PROC,Pascal,Raw,Name('vuScreenHeight')
      vuScreenWidth(),Long,PROC,Pascal,Raw,Name('vuScreenWidth')
      vuSelfDelete(),Long,PROC,Pascal,Raw,Name('vuSelfDelete')
      vuServerDate(*CSTRING),LONG,PROC,Pascal,Raw,Name('vuServerDate')
      vuServerTime(*CSTRING),LONG,PROC,Pascal,Raw,Name('vuServerTime')
      vuServerTZOffset(*CSTRING),LONG,PROC,Pascal,Raw,Name('vuServerTZOffset')
      vuServiceStatus(*CSTRING,*CSTRING),Long,PROC,Pascal,Raw,Name('vuServiceStatus')
      vuSetAttributes(*CSTRING,LONG,LONG,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuSetAttributes')
      vuSetDefaultPrinter(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuSetDefaultPrinter')
      vuSetFileDate(*CSTRING,LONG,LONG,LONG,LONG,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuSetFileDate')
      vuSetFolderDate(*CSTRING,Long,Long,Long,Long,Long,Long),Signed,PROC,Pascal,Raw,Name('vuSetFolderDate')
      vuShell(*CSTRING),Long,PROC,Pascal,Raw,Name('vuShell')
      vuShutdown(LONG),Signed,PROC,Pascal,Raw,Name('vuShutdown')
      vuStartEmail(*CSTRING,*CSTRING,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuStartEmail')
      vuStringParse(*CSTRING, *CSTRING, LONG),CSTRING,PROC,Pascal,Raw,Name('vuStringParse')
      vuSystemDirectory(),CSTRING,PROC,Pascal,Raw,Name('vuSystemDirectory')
      vuTaskBar(LONG),Signed,PROC,Pascal,Raw,Name('vuTaskBar')
      vuTempPath(),CSTRING,PROC,Pascal,Raw,Name('vuTempPath')
      vuTerminateOthers(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuTerminateOthers')
      vuToolWindow(LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuToolWindow')
      vuTransparent(LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuTransparent')
      vuTransparentColorKey(LONG,LONG,LONG,LONG),Signed,PROC,Pascal,Raw,Name('vuTransparentColorKey')
      vuTransparentOthers(*CSTRING,LONG),Signed,PROC,Pascal,Raw,Name('vuTransparentOthers')
      vuUncompress(*CSTRING,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuUncompress')
      vuUnPack(*CSTRING,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuUnPack')
      vuUserName(),CSTRING,PROC,Pascal,Raw,Name('vuUserName')
      vuVirtualkeys(*CSTRING),Pascal,Raw,Name('vuVirtualkeys')
      vuVolumeLabel(*CSTRING),CSTRING,PROC,Pascal,Raw,Name('vuVolumeLabel')
      vuVolumeSerialNo(*CSTRING),LONG,PROC,Pascal,Raw,Name('vuVolumeSerialNo')
      vuWindow2Bmp(*CSTRING),Signed,PROC,Pascal,Raw,Name('vuWindow2Bmp')
      vuWindow2BmpEx(LONG,*CSTRING),Signed,PROC,Pascal,Raw,Name('vuWindow2BmpEx')
      vuWindow2Clipboard(),Signed,PROC,Pascal,Raw,Name('vuWindow2Clipboard')
      vuWindow2Front(LONG),Signed,PROC,Pascal,Raw,Name('vuWindow2Front')
      vuWindowHandle(*CSTRING),Long,PROC,Pascal,Raw,Name('vuWindowHandle')
      vuWindowMove(Long,Long,Long,Long,Long,Long),Signed,PROC,Pascal,Raw,Name('vuWindowMove')
      vuWindowNotOnTop(LONG),Signed,PROC,Pascal,Raw,Name('vuWindowNotOnTop')
      vuWindowOnTop(LONG),Signed,PROC,Pascal,Raw,Name('vuWindowOnTop')
      vuWindowsDirectory(),CSTRING,PROC,Pascal,Raw,Name('vuWindowsDirectory')
      vuWindowsKey(LONG),Signed,PROC,Pascal,Raw,Name('vuWindowsKey')
         END
     MODULE('LSZFUNC.CLW')                                                ! LSZip Function Library
           ZConvert_CMethod( USHORT, USHORT ),STRING                      ! Convert compression index into readable string
           ZConvert_Time( USHORT ),LONG                                   ! Convert DOS time to Clarion time
           ZConvert_Date( USHORT ),LONG                                   ! Convert DOS date to Clarion date
           ZConvert_CRC32( ULONG ),STRING                                 ! Convert ulong CRC-32 into readable string
           ZConvert_S_To_H( STRING ),STRING                               ! Convert string to hex (used by Convert_CRC32)
           ZConvert_Attrb( ULONG ),STRING                                 ! Convert file attribute to readable string
           Calculate_Ratio( LONG,LONG ),REAL                              ! Calculate compression ratio
     END
     
     
       MyOKToEndSessionHandler(long pLogoff),long,pascal
       MyEndSessionHandler(long pLogoff),pascal
   END

  include('StringTheory.Inc'),ONCE
glo:CPUThreadCount   LONG
glo:AllowScreenSaver BYTE
GLO:ScreenSaverOpen  LONG
glo:MachineId        STRING(16)
tMsg                 CSTRING(100),DIM(100)
tTitle               CSTRING(100),DIM(100)
Glo:language         STRING(2)
glo:version          LONG
DataPAth             CSTRING(500)
Job                  CSTRING(1000)
glo:AutoRepeatDocking BYTE
SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

   INCLUDE( 'ALSZCLA.INC' ),ONCE

   INCLUDE( 'ALSUZCLA.INC' ),ONCE

 INCLUDE( 'LSZIP.LIC' ),ONCE
!region File Declaration
!endregion

WE::MustClose       long
WE::CantCloseNow    long

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               CLASS(INIClass)                       ! Global non-volatile storage manager
Fetch                  PROCEDURE(),DERIVED
Update                 PROCEDURE(),DERIVED
                     END

svSpecialFolder        SpecialFolder
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  svSpecialFolder.CreateDirIn(SV:CSIDL_COMMON_APPDATA, 'SiDock' & '\' & '' )
  INIMgr.Init(svSpecialFolder.GetDir(SV:CSIDL_COMMON_APPDATA, 'SiDock' & '\' & '') & '\' & 'SiDock.INI', NVD_INI)
  SYSTEM{PROP:DataPath} = svSpecialFolder.GetDir(SV:CSIDL_COMMON_APPDATA, 'SiDock' & '\' & '')
  DctInit()
                             ! Begin Generated by NetTalk Extension Template
    if ~command ('/netnolog') and (command ('/nettalklog') or command ('/nettalklogerrors') or command ('/neterrors') or command ('/netall'))
      NetDebugTrace ('[Nettalk Template] NetTalk Template version 11.33')
      NetDebugTrace ('[Nettalk Template] NetTalk Template using Clarion ' & 11000)
      NetDebugTrace ('[Nettalk Template] NetTalk Object version ' & NETTALK:VERSION )
      NetDebugTrace ('[Nettalk Template] ABC Template Chain')
    end
                             ! End Generated by Extension Template
  SYSTEM{PROP:Icon} = 'media-burn-1.ico'
    ds_SetOKToEndSessionHandler(address(MyOKToEndSessionHandler))
    ds_SetEndSessionHandler(address(MyEndSessionHandler))
  Main
  INIMgr.Update
                             ! Begin Generated by NetTalk Extension Template
    NetCloseCallBackWindow() ! Tell NetTalk DLL to shutdown it's WinSock Call Back Window
  
    if ~command ('/netnolog') and (command ('/nettalklog') or command ('/nettalklogerrors') or command ('/neterrors') or command ('/netall'))
      NetDebugTrace ('[Nettalk Template] NetTalk Template version 11.33')
      NetDebugTrace ('[Nettalk Template] NetTalk Template using Clarion ' & 11000)
      NetDebugTrace ('[Nettalk Template] Closing Down NetTalk (Object) version ' & NETTALK:VERSION)
    end
                             ! End Generated by Extension Template
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher
    
! ------ winevent -------------------------------------------------------------------
MyOKToEndSessionHandler procedure(long pLogoff)
OKToEndSession    long(TRUE)
! Setting the return value OKToEndSession = FALSE
! will tell windows not to shutdown / logoff now.
! If parameter pLogoff = TRUE if the user is logging off.

  code
  return(OKToEndSession)

! ------ winevent -------------------------------------------------------------------
MyEndSessionHandler procedure(long pLogoff)
! If parameter pLogoff = TRUE if the user is logging off.

  code


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()


INIMgr.Fetch PROCEDURE

  CODE
  glo:CPUThreadCount = SELF.TryFetch('Preserved','glo:CPUThreadCount') ! Resore ' preserved variable' from non-volatile store
  glo:AutoRepeatDocking = SELF.TryFetch('Preserved','glo:AutoRepeatDocking') ! Resore ' preserved variable' from non-volatile store
  Glo:language = SELF.TryFetch('Preserved','Glo:language') ! Resore ' preserved variable' from non-volatile store
  glo:AllowScreenSaver = SELF.TryFetch('Preserved','glo:AllowScreenSaver') ! Resore ' preserved variable' from non-volatile store
  PARENT.Fetch


INIMgr.Update PROCEDURE

  CODE
  PARENT.Update
  SELF.Update('Preserved','glo:CPUThreadCount',glo:CPUThreadCount) ! Save 'preserved variable' in non-volatile store
  SELF.Update('Preserved','glo:AutoRepeatDocking',glo:AutoRepeatDocking) ! Save 'preserved variable' in non-volatile store
  SELF.Update('Preserved','Glo:language',Glo:language)     ! Save 'preserved variable' in non-volatile store
  SELF.Update('Preserved','glo:AllowScreenSaver',glo:AllowScreenSaver) ! Save 'preserved variable' in non-volatile store

