

   MEMBER('SiDock.clw')                                    ! This is a MEMBER module


   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('NetWww.inc'),ONCE

                     MAP
                       INCLUDE('SIDOCK001.INC'),ONCE        !Local module procedure declarations
                     END




!!! <summary>
!!! Generated from procedure template - Frame
!!! </summary>
Main PROCEDURE 

retval               LONG                                  ! 
ncode                LONG                                  ! 
RetryCreateIcon         long
WE::MouseRightPopup     Class(PopupClass)
                    end
AppFrame             APPLICATION('SiDock'),AT(,,446,263),FONT('Segoe UI',9),CENTER,ICON('media-burn-1.ico'),MASK, |
  MAX,STATUS(-1,80,120,45),SYSTEM,IMM
                       MENUBAR,USE(?Menubar)
                       END
                     END

    omit('***',WE::CantCloseNowSetHereDone=1)  !Getting Nested omit compile error, then uncheck the "Check for duplicate CantCloseNowSetHere variable declaration" in the WinEvent local template
WE::CantCloseNowSetHereDone equate(1)
WE::CantCloseNowSetHere     long
    !***
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeNotify             PROCEDURE(UNSIGNED NotifyCode,SIGNED Thread,LONG Parameter),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
! ----- st --------------------------------------------------------------------------
st                   Class(StringTheory)
                     End  ! st
! ----- end st -----------------------------------------------------------------------

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
Load_Translations   ROUTINE
    st.loadfile('Sidock.'&Glo:language&'.trn')
    st.split(chr(13)&chr(10))
    loop e#=1 to st.records()
        st.setvalue(st.getline(e#))
        num#=st.between('[',']')
        if st.sub(1,3)='Msg'                        
            tMsg[num#]=st.between('=','')          
        END        
        if st.sub(1,5)='Title'          
            tTitle[num#]=st.between('=','')
        END        
    END
Menu::Menubar ROUTINE                                      ! Code for menu items on ?Menubar

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.Open(AppFrame)                                      ! Open window
  WinAlert(WE::WM_WTSSESSION_CHANGE)
  post(event:WinEventTaskbarLoadIcon)
  Do DefineListboxStyle
  Alert(AltKeyPressed)  ! WinEvent : These keys cause a program to crash on Windows 7 and Windows 10.
  Alert(F10Key)         !
  Alert(CtrlF10)        !
  Alert(ShiftF10)       !
  Alert(CtrlShiftF10)   !
  Alert(AltSpace)       !
  WinAlertMouseZoom()
  WinAlert(WE::WM_QueryEndSession,,Return1+PostUser)
    WE::MouseRightPopup.Init()
        WE::MouseRightPopup.AddItem('Show','ShowSelected')
        WE::MouseRightPopup.AddItem('Hide','HideSelected')
        WE::MouseRightPopup.AddItem('-','weSeparator')
        WE::MouseRightPopup.AddItem('Exit','CloseSelected')
  ds_SetApplicationWindow(AppFrame)
  SELF.SetAlerts()
      AppFrame{PROP:TabBarVisible}  = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  If self.opened then winTaskbarRemoveIcon().
  If self.opened Then WinAlert().
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
    WE::MouseRightPopup.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    ELSE
      DO Menu::Menubar                                     ! Process menu items on ?Menubar menu
    END
  ReturnValue = PARENT.TakeAccepted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeEvent()
  case Event() - WinMessageEvent
  of 5501 ! refresh icon
    winTaskbarChangeIcon(,'media-burn-1.ico','SiDock',)
  of 5510 ! load icon
    winTaskbarAddIcon('media-burn-1.ico','SiDock',,)
  of 5512 ! mouse move
  of 5513 ! mouseleft down
  of 5514 ! mouseleft up
      ds_ShowWindow()
  of 5515 ! double left click
  of 5516 ! mouseright down
  of 5517 ! mouseright up
      case WE::MouseRightPopup.Ask()
      of 'ShowSelected'
        ds_ShowWindow()
      of 'HideSelected'
        ds_HideWindow
      of 'CloseSelected'
        post(event:closewindow)
        post(event:closedown)
      end
  of 6026 ! balloon opened
  of 6027 ! balloon closed
  of 6028 ! balloon timeout, closed
  of 6029 ! balloon clicked, closed
  end ! case
  If event() = event:VisibleOnDesktop !or event() = event:moved
    ds_VisibleOnDesktop()
  end
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeNotify PROCEDURE(UNSIGNED NotifyCode,SIGNED Thread,LONG Parameter)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeNotify(NotifyCode,Thread,Parameter)
  if NOTIFICATION(ncode,,retval)
      case ncode
          of 1
              post(event:closedown)
          of 2
              do load_translations
              notify(1,retval)
      END
  END
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
        of EVENT:Iconized
          ds_HideWindow
    OF EVENT:CloseDown
      if WE::CantCloseNow
        WE::MustClose = 1
        cycle
      else
        self.CancelAction = cancel:cancel
        self.response = requestcancelled
      end
    OF EVENT:OpenWindow
      st.setvalue(ds_GetFileVersionInfo())
      st.split('.')
      glo:version=st.getline(4)
      st.freelines()
      st.free()
      0{prop:text}=0{prop:text}&' - v'&ds_GetFileVersionInfo()
      if glo:language='' then glo:language='en'.
      do load_translations
      
      ! Check for GUID
      glo:MachineId=getreg(REG_CURRENT_USER,'Software\SiDock','MachineID')
      if ~glo:MachineId
          glo:MachineId=st.MakeGuid()
          putreg(REG_CURRENT_USER,'Software\SiDock','MachineID',glo:machineid)
      END
      
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
      CheckUpdate('http://www.neolink.si/files/','SiDockSetup',1)
      START(MainMenu, 25000)
        post(event:visibleondesktop)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue



!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
MainMenu PROCEDURE 

CPUUsage             LONG                                  ! 
UnlimitedCounter     REAL                                  ! 
InitiateVersionCheck BYTE                                  ! 
RemainingPackagesOnServer STRING(20)                       ! 
PacketStart          REAL                                  ! 
FileQueue            QUEUE(File:queue),PRE(FQ)             ! 
                     END                                   ! 
IdleTime             LONG                                  ! 
ncode                LONG                                  ! 
retval               LONG                                  ! 
LangIconToShow       CSTRING(100)                          ! 
LangIconToShowPressed CSTRING(100)                         ! 
PacketRunning        REAL                                  ! 
PacketRunningString  STRING(10)                            ! 
klic                 BYTE                                  ! 
ProgramRunningTimeString STRING(20)                        ! 
Restart              BYTE                                  ! 
EngineStatus         STRING(30)                            ! 
rotator              BYTE                                  ! 
OutputReady          BYTE                                  ! 
AllPacketsDone       LONG                                  ! 
Log                  QUEUE,PRE(L)                          ! 
oPIS                 STRING(50)                            ! 
                     END                                   ! 
tarca                LONG                                  ! 
URL                  CSTRING(100)                          ! 
rezultat             LONG                                  ! 
paket                LONG                                  ! 
izhodnipodatki       CSTRING(10000)                        ! 
started              BYTE                                  ! 
RunningTimeTotal     REAL                                  ! 
StartTotal           REAL                                  ! 
ActiveThreadsQueue   QUEUE,PRE(ATQ)                        ! 
ThreadNo             BYTE                                  ! 
PID                  LONG                                  ! 
                     END                                   ! 
PacketFilename       CSTRING(50)                           ! 
ProcessQ             QUEUE,PRE(ProcessQ)                   ! 
dwSize               ULONG                                 ! 
cntUsage             ULONG                                 ! 
th32ProcessID        ULONG                                 ! 
th32DefaultHeapID    ULONG                                 ! 
th32ModuleID         ULONG                                 ! 
cntThreads           ULONG                                 ! 
th32ParentProcessID  ULONG                                 ! 
pcPriClassBase       LONG                                  ! 
dwFlags              ULONG                                 ! 
szExeFile            STRING(260)                           ! 
ProgramName          STRING(100)                           ! 
                     END                                   ! 
dwSize               ULONG                                 ! 
cntUsage             ULONG                                 ! 
th32ProcessID        ULONG                                 ! 
th32DefaultHeapID    ULONG                                 ! 
th32ModuleID         ULONG                                 ! 
cntThreads           ULONG                                 ! 
th32ParentProcessID  ULONG                                 ! 
pcPriClassBase       LONG                                  ! 
dwFlags              ULONG                                 ! 
szExeFile            STRING(260)                           ! 
ProgramName          STRING(100)                           ! 
JobInfo              GROUP,PRE(JobInfo)                    ! 
TotalUserTime        REAL                                  ! 
TotalKernelTime      REAL                                  ! 
ThisPeriodTotalUserTime REAL                               ! 
ThisPeriodTotalKernelTime REAL                             ! 
TotalPageFaultCount  ULONG                                 ! 
TotalProcesses       ULONG                                 ! 
ActiveProcesses      ULONG                                 ! 
TotalTerminatedProcesses ULONG                             ! 
                     END                                   ! 
TotalUserTime        REAL                                  ! 
TotalKernelTime      REAL                                  ! 
ThisPeriodTotalUserTime REAL                               ! 
ThisPeriodTotalKernelTime REAL                             ! 
TotalPageFaultCount  ULONG                                 ! 
TotalProcesses       ULONG                                 ! 
ActiveProcesses      ULONG                                 ! 
TotalTerminatedProcesses ULONG                             ! 
TestData             STRING(65355)                         ! 
Parameters           STRING('? {251}')                     ! 
FileToRun            STRING('copy.bat {244}')              ! 
timeCompleted        TIME                                  ! 
SaveToFile           STRING('output.txt {242}')            ! 
Executable           STRING(280)                           ! 
siPath               STRING(280)                           ! 
show                 LONG                                  ! 
outputData           STRING(16000)                         ! 
DrivesQ              QUEUE,PRE(dq)                         ! 
drive                STRING(4)                             ! 
deviceName           STRING(1024)                          ! 
                     END                                   ! 
drive                STRING(4)                             ! 
deviceName           STRING(1024)                          ! 
ExitValueOfTheProcess LONG,DIM(128)                        ! 
!jobsQ                queue(JobProcessQ), pre(JOQ)
!                     end
procData             StringTheory
PathOfFileToRun      string(252)
qIP          QUEUE(Net:IpInfoQType),PRE()
             END
Window               WINDOW,AT(,,438,237),FONT('Segoe UI',10,,,CHARSET:EASTEUROPE),MAXIMIZE,COLOR(00F0F0F0h),MDI, |
  TIMER(10)
                       BOX,AT(126,203,52,30),USE(?BOX2:4),COLOR(COLOR:Black),LINEWIDTH(1)
                       BOX,AT(246,25,186,91),USE(?back:2),COLOR(COLOR:Gray),LINEWIDTH(1)
                       BOX,AT(11,13,86,12),USE(?BOX1:2),COLOR(00FF8080h),FILL(00FFC0C0h),LINEWIDTH(1)
                       BOX,AT(11,203,52,30),USE(?BOX2),COLOR(COLOR:Black),LINEWIDTH(1)
                       BOX,AT(246,119,79,12),USE(?BOX1),COLOR(00FF8080h),FILL(00FFC0C0h),LINEWIDTH(1)
                       BOX,AT(184,203,52,30),USE(?BOX2:3),COLOR(COLOR:Black),LINEWIDTH(1)
                       BOX,AT(69,203,52,30),USE(?BOX2:2),COLOR(COLOR:Black),LINEWIDTH(1)
                       STRING('Detected CPU threads:'),AT(15,30),USE(?CpuDetect),FONT(,,,FONT:bold),TRN
                       IMAGE('covid.si.logo.back.png'),AT(5,26,225,173),USE(?IMAGE3),CENTERED
                       BOX,AT(11,25,225,175),USE(?back),COLOR(COLOR:Gray),LINEWIDTH(1)
                       PROMPT('Use CPU Threads:'),AT(15,46),USE(?t4),TRN
                       CHECK('Auto-Repeat Docking?'),AT(15,61,151),USE(glo:AutoRepeatDocking),LEFT,TRN,VALUE('1', |
  '0')
                       BUTTON,AT(11,203,52,30),USE(?button),ICON('ico\button-circle-play-filled.ico'),FLAT
                       BUTTON,AT(184,203,52,30),USE(?BUTTON1),ICON('ico\exitnew.ico'),FLAT
                       STRING('Active threads:'),AT(100,15,75,10),USE(?ACtiveThreads),FONT(,,,FONT:bold),HIDE
                       PROMPT('Package Docking Time:'),AT(15,94),USE(?RunningTimePacket:Prompt),TRN
                       ENTRY(@s10),AT(158,92,77,10),USE(PacketRunningString),FONT(,,,FONT:regular),LEFT,FLAT,READONLY, |
  SKIP,TRN
                       PROMPT('Program Running Time:'),AT(15,176,88),USE(?RunningTimeTotal:Prompt),TRN
                       ENTRY(@s20),AT(158,174,77,10),USE(ProgramRunningTimeString),FONT(,,,FONT:regular),LEFT,FLAT, |
  READONLY,SKIP,TRN
                       LIST,AT(247,131,185,102),USE(?LIST1),VSCROLL,GRID(COLOR:White),FORMAT('350L(4)|@s50@E(,' & |
  '00FFFFFFH,,)'),FROM(Log)
                       PROMPT('Operation log'),AT(252,120),USE(?t2),TRN
                       PROMPT('Packages Docked Total:'),AT(15,110),USE(?AllPacketsDone:Prompt),TRN
                       ENTRY(@n10`0),AT(158,108,77,10),USE(AllPacketsDone),FONT(,,,FONT:regular),LEFT,FLAT,READONLY, |
  SKIP,TRN
                       BUTTON,AT(69,203,52,30),USE(?button:2),ICON('ico\button-circle-stop-filled.ico'),FLAT
                       IMAGE('ico\loading3-animation-01.ico'),AT(105,92,57,43),USE(?IMAGE1),CENTERED,HIDE
                       PROMPT('Docking Engine Status:'),AT(15,127),USE(?enginestatus),TRN
                       ENTRY(@s30),AT(110,126,121,10),USE(EngineStatus,,?EngineStatus:2),FONT(,,,FONT:regular),FLAT, |
  READONLY,SKIP,TRN
                       ENTRY(@n3),AT(203,148,27,10),USE(glo:CPUThreadCount,,?glo:CPUThreadCount:2),FONT(,7),RIGHT, |
  READONLY,SKIP,TRN
                       PROGRESS,AT(110,143,118),USE(?PROGRESS1),RANGE(0,100),SMOOTH,TRN
                       PROMPT('Currently Active Threads:'),AT(15,143),USE(?enginestatus:3),TRN
                       PROMPT('0'),AT(110,150),USE(?enginestatus:4),FONT(,7),TRN
                       PROMPT('Settings and Statistics'),AT(16,15),USE(?t1),FONT(,,COLOR:BTNTEXT),TRN
                       BUTTON,AT(126,203,52,30),USE(?about),ICON('ico\button-info-user-filled.ico'),FLAT
                       PROMPT('EN'),AT(197,15),USE(?PROMPT1)
                       PROMPT('SI'),AT(230,15),USE(?PROMPT1:2),COLOR(00F0F0F0h)
                       IMAGE,AT(206,11,25,16),USE(?IMAGE2),CENTERED
                       BUTTON('FlipLang'),AT(49,1,34,13),USE(?FlipLang),FONT(,8),FLAT,SKIP,TRN
                       IMAGE('partners.png'),AT(246,25,186,91),USE(?IMAGE4),CENTERED
                       BOX,AT(246,13,79,12),USE(?BOX1:3),COLOR(00FF8080h),FILL(00FFC0C0h),LINEWIDTH(1)
                       PROMPT('Beautiful image'),AT(252,15),USE(?t10),COLOR(00F0F0F0h),TRN
                       BUTTON('openImg'),AT(11,0,34,13),USE(?FlipLang:2),FONT(,8),COLOR(00F0F0F0h),FLAT,HIDE,SKIP, |
  TRN
                       PROMPT('covid.si'),AT(407,14),USE(?covidlink)
                       CHECK('Display screen saver?'),AT(15,77,151),USE(glo:AllowScreenSaver),LEFT,TRN,VALUE('1', |
  '0')
                       BUTTON('Update available'),AT(11,1,422,11),USE(?UpdateAvailable),FONT(,,COLOR:Red),FLAT,HIDE, |
  TRN
                       PROMPT('Remaining packages on server:'),AT(15,190,137),USE(?TargetStat),COLOR(00F0F0F0h),TRN
                       ENTRY(@s20),AT(158,189,60,10),USE(RemainingPackagesOnServer),LEFT,READONLY,SKIP,TRN
                       PROMPT('CPU Utilization'),AT(15,160),USE(?CpuUtil),COLOR(00F0F0F0h),TRN
                       PROGRESS,AT(110,160,118),USE(?PROGRESS2),RANGE(0,100),SMOOTH,TRN
                       PROMPT('0'),AT(110,167),USE(?enginestatus:5),FONT(,7),COLOR(00F0F0F0h),TRN
                       PROMPT('100'),AT(220,167),USE(?enginestatus:6),FONT(,7),COLOR(00F0F0F0h),TRN
                       PROMPT('0 %'),AT(165,161),USE(?cpupercent),FONT(,7,COLOR:HIGHLIGHTTEXT),TRN
                       SLIDER,AT(110,45,118,16),USE(glo:CPUThreadCount),RANGE(1,100),STEP(1),NOTICKS,TRN
                       PROMPT('0 %'),AT(115,40),USE(?enginestatus:7),FONT(,7),COLOR(00F0F0F0h),TRN
                       PROMPT('100 %'),AT(217,40,16),USE(?enginestatus:8),FONT(,7),COLOR(00F0F0F0h),TRN
                       PROMPT('50 %'),AT(163,40,16),USE(?enginestatus:9),FONT(,7),COLOR(00F0F0F0h),TRN
                     END

    omit('***',WE::CantCloseNowSetHereDone=1)  !Getting Nested omit compile error, then uncheck the "Check for duplicate CantCloseNowSetHere variable declaration" in the WinEvent local template
WE::CantCloseNowSetHereDone equate(1)
WE::CantCloseNowSetHere     long
    !***
langbutton    ActiveImage
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeNotify             PROCEDURE(UNSIGNED NotifyCode,SIGNED Thread,LONG Parameter),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
! ----- ThisHyperActive --------------------------------------------------------------------------
ThisHyperActive      Class(csHyperActiveClass)
    ! derived method declarations
GetListURL             PROCEDURE (LONG HyperControl,STRING HyperURL,<STRING FirstEmailName>,<STRING LastEmailName>),STRING ,VIRTUAL
                     End  ! ThisHyperActive
! ----- end ThisHyperActive -----------------------------------------------------------------------
! ----- oj --------------------------------------------------------------------------
oj                   Class(JobObject)
    ! derived method declarations
ErrorTrap              PROCEDURE (string desc, long err, <string fnName>), virtual
                     End  ! oj
! ----- end oj -----------------------------------------------------------------------
! ----- st --------------------------------------------------------------------------
st                   Class(StringTheory)
                     End  ! st
! ----- end st -----------------------------------------------------------------------
! ----- stout --------------------------------------------------------------------------
stout                Class(StringTheory)
                     End  ! stout
! ----- end stout -----------------------------------------------------------------------
! ----- ux --------------------------------------------------------------------------
ux                   Class(UnixDate)
                     End  ! ux
! ----- end ux -----------------------------------------------------------------------

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
translation         ROUTINE
    ?t1{prop:text}=tTitle[1]
    ?t2{prop:text}=tTitle[2]
    ?t10{prop:text}=tTitle[14]
    ?CpuDetect{prop:text}=tTitle[3]
    ?t4{prop:text}=tTitle[4]
    ?glo:AutoRepeatDocking{prop:text}=tTitle[5]
    ?RunningTimePacket:Prompt{prop:text}=tTitle[6]
    ?RunningTimeTotal:Prompt{prop:text}=tTitle[7]
    ?AllPacketsDone:Prompt{prop:text}=tTitle[8]
    ?enginestatus{prop:text}=tTitle[9]
    ?enginestatus:3{prop:text}=tTitle[10]
    ?glo:AllowScreenSaver{prop:text}=tTitle[15]
    ?TargetStat{prop:text}=tMsg[48]
    ?cpuutil{prop:text}=tTitle[16]
    if ~numeric(RemainingPackagesOnServer)
        RemainingPackagesOnServer=tMsg[49] 
    END
    
    UPDATE
    display()
    
PACKET_SPLIT        ROUTINE
    
    PacketFilename='packet.sdf'
    st.loadfile(system{PROP:DataPath}&'\packet\'&PacketFilename)
    PartsPerFile#=st.count('$$$$')/glo:CPUThreadCount
    RemainingPart#=st.count('$$$$')%glo:CPUThreadCount 
    st.FreeLines()
    st.split('$$$$')
    save#=0
    st.free()
    chunk#=1        
    loop z#=1 to st.records()
        save#+=1
        if save#=1
            st.setvalue(st.getvalue()&st.getline(z#))
        else
            st.setvalue(st.getvalue()&'$$$$'&st.getline(z#))
        END               
            if save#=PartsPerFile# and chunk#<glo:CPUThreadCount
                st.setvalue(st.getvalue()&'$$$$')
                st.savefile(system{PROP:DataPath}&'\packet\'&PacketFilename&'_'&chunk#)
                st.free()
                chunk#+=1
                save#=0
            END        
    END        
    !if RemainingPart#>0
        !st.setvalue(st.getvalue()&'$$$$')
        st.savefile(system{PROP:DataPath}&'\packet\'&PacketFilename&'_'&chunk#)
        st.free()
    !END
    
DOCKING             ROUTINE
    PacketStart=ux.ClarionToUnixDate(today(),clock())
    oj.init('SiDocking')
    DataPath=system{PROP:DataPath}
    if glo:CPUThreadCount=1
        !SETCLIPBOARD('lib\rxdock\builddir-win64\rbdock.exe -r '&DataPath&'\target\target_10.prm -p dock.prm -f '&DataPath&'\target\htvs.ptc -i '&DataPath&'\packet\packet.sdf -o '&DataPath&'\packet\packet_out')
        !run('lib\rxdock\builddir-win64\rbdock.exe -r '&DataPath&'\target\target_10.prm -p dock.prm -f '&DataPath&'\target\htvs.ptc -i '&DataPath&'\packet\packet.sdf -o '&DataPath&'\packet\packet_out >nul')
        job='lib\rxdock\builddir-win64\rbdock.exe -r '&DataPath&'target_'&tarca&'.prm -p '&datapath&'data\scripts\dock.prm -f '&DataPath&'htvs.ptc -i '&DataPath&'packet\packet.sdf -o '&DataPath&'packet\packet_out -n 1'
        SETCLIPBOARD(job)
        oj.CreateProcess(job,jo:SW_hide,0,datapath,,,,,1,1)
    else
        loop rxdock#=1 to glo:CPUThreadCount                                                
        !run('lib\rxdock\builddir-win64\rbdock.exe -r '&DataPath&'target\target_10.prm -p dock.prm -f '&DataPath&'target\htvs.ptc -i '&DataPath&'packet\packet.sdf_'&rxdock#&' -o '&DataPath&'packet\packet_out_'&rxdock#&' >nul')
        !job='lib\rxdock\builddir-win64\rbdock.exe -r '&DataPath&'target\target_10.prm -p dock.prm -f '&DataPath&'target\htvs.ptc -i '&DataPath&'packet\packet.sdf_'&rxdock#&' -o '&DataPath&'packet\packet_out_'&rxdock#
        job='lib\rxdock\builddir-win64\rbdock.exe -r '&DataPath&'target_'&tarca&'.prm -p '&datapath&'data\scripts\dock.prm -f '&DataPath&'htvs.ptc -i '&DataPath&'packet\packet.sdf_'&rxdock#&' -o '&DataPath&'packet\packet_out_'&rxdock#&' -n 1'
        !job='FOR %F in ('&DataPath&'packet\packet.sdf_*) do start /b c:\clarion11\apps\sidock\lib\rxdock\builddir-win64\rbdock.exe -r '&DataPath&'target_'&tarca&'.prm -p '&datapath&'data\scripts\dock.prm -f '&DataPath&'htvs.ptc -i %F -o %F_out -n 1'
        !SETCLIPBOARD(clip(job))
        if oj.CreateProcess(job,jo:SW_hide,0,datapath,,,,,1,1) !job running           
            started=1
            !RUN(JOB)
        END
            
        END
    END    
    do show_active_threads
show_active_threads ROUTINE
    
    free(ActiveThreadsQueue)
    clear(ActiveThreadsQueue)
    free(ProcessQ)
    update
    display()
    oj.ListProcesses(ProcessQ)
    loop v#=1 to records(processq)
        get(processq,v#)
        if instring('rbdock',ProcessQ.ProgramName,1,1)
            ATQ:ThreadNo+=1
            ATQ:PID=ProcessQ.th32ProcessID
            add(ActiveThreadsQueue)
        END    
    END
    ?ACtiveThreads{prop:text}='Active threads: '&records(ActiveThreadsQueue)
    ?PROGRESS1{prop:progress}=records(ActiveThreadsQueue)
    if PacketStart>0 and started=1       
        PacketRunning=ux.ClarionToUnixDate(today(),clock())-PacketStart
        Hours#=0;Minutes#=0       
        if PacketRunning=>3600 !we have at least one hour
            Hours#=PacketRunning/3600
            PacketRunning=PacketRunning%3600
        END
        if PacketRunning=>60 !we have at least one minute
            Minutes#=PacketRunning/60
            PacketRunning=PacketRunning%60
        END        
        PacketRunningString=hours#&'H '&Minutes#&'M '&PacketRunning&'S'
    END
    
    
    UPDATE
    display()

show_total_time     ROUTINE
    if StartTotal>0
        Days#=0;Hours#=0;Minutes#=0
        runningtimetotal=ux.ClarionToUnixDate(today(),clock())-StartTotal !clock()-StartTimeTotal              
        if runningtimetotal=>86400 !we have at least one day
            Days#=runningtimetotal/86400
            Runningtimetotal=runningtimetotal%86400
        END
        if runningtimetotal=>3600 !we have at least one hour
            Hours#=runningtimetotal/3600
            Runningtimetotal=runningtimetotal%3600
        END
        if runningtimetotal=>60 !we have at least one minute
            Minutes#=runningtimetotal/60
            Runningtimetotal=runningtimetotal%60
        END        
        ProgramRunningTimeString=days#&'D '&hours#&'H '&Minutes#&'M '&runningtimetotal&'S'!st.FormatTime(runningtimetotal,'@t4UZ')
    END    
    update(ProgramRunningTimeString)
    display(ProgramRunningTimeString)
    if runningtimetotal>0 and runningtimetotal%21600=0 !time to do version check
        InitiateVersionCheck=true
    END
    
assemble_packet     ROUTINE
    st.freelines()
    st.free()
    stout.free()
    izhodnipodatki=datapath&'packet\*.sd'           
    loop i#=1 to vuFileCount(izhodnipodatki)
        st.LoadFile(datapath&'packet\packet_out_'&i#&'.sd')
        stout.setvalue(stout.getvalue()&st.getvalue())
    END
    stout.savefile(datapath&'packet\OUT_T'&tarca&'_'&paket&'.sdf')
    L:Opis=tmsg[15]&paket
    add(log);update;display;select(?list1,pointer(log));select(?list1,pointer(log))
    OutputReady=0
    izhodnipodatki=datapath&'packet\OUT_T'&tarca&'_'&paket&'.sdf'
    if vuFileSize(izhodnipodatki)
        izhodnipodatki=datapath&'packet\packet*.*'        
        vudelete(izhodnipodatki,0,0)        
        izhodnipodatki=datapath&'target*.*'
        vudelete(izhodnipodatki,0,0)        
        izhodnipodatki=datapath&'htvs.ptc'
        vudelete(izhodnipodatki,0,0)             
        OutputReady=1
    ELSE
        OutputReady=0
        !message('Napaka pri ustvarjanju izhodne datoteke')
        L:Opis=tmsg[16]
        add(log);update;display;select(?list1,pointer(log));select(?list1,pointer(log))
        vudelete(izhodnipodatki,0,0)
    END
    L:Opis=tMsg[17]
    add(log);update;display;select(?list1,pointer(log));select(?list1,pointer(log))
    
Upload_results      ROUTINE    
    L:Opis=tmsg[18]&paket
    add(log);update;display;select(?list1,pointer(log));select(?list1,pointer(log))    
    URL='https://api.covid.si/'&tarca&'/file/'&paket
    klic=5
     EngineStatus"=enginestatus
     enginestatus=tMsg[19]
    rezultat=TalkToServer(URL,klic,datapath&'packet\OUT_T'&tarca&'_'&paket&'.sdf') !vsebina paketa
     EngineStatus=enginestatus"
    if rezultat=1005
        L:Opis=tmsg[20]
        add(log);update;display;select(?list1,pointer(log));select(?list1,pointer(log))
        izhodnipodatki=datapath&'packet\OUT_T'&tarca&'_'&paket&'.sdf'    
        vudelete(izhodnipodatki,0,0)     
    ELSE
        if glo:AutoRepeatDocking=false
            L:Opis=tmsg[21]
            add(log);update;display;select(?list1,pointer(log));select(?list1,pointer(log))            
        ELSE
            L:Opis=tmsg[22]
            add(log);update;display;select(?list1,pointer(log))
            Restart=true
        END
    END
    
clean_start         ROUTINE
    st.free()
    st.freelines()
    stout.free()
    stout.freelines()
    OutputReady=0
    started=0
    rezultat=0
    paket=0
    tarca=0
    PacketFilename=''
    post(EVENT:Accepted,?button)
    

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('MainMenu')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?BOX2:4
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  langbutton.Init(Window,?IMAGE2,FALSE,?FlipLang)
  langbutton.SetImage(LangIconToSHow,,,)
  if Glo:language='en'
      LangIconToShow='ico\toggle-on-filled-left.ico'
      LangIconToShowPressed='ico\toggle-on-filled.ico'
  ELSE
      LangIconToShow='ico\toggle-on-filled.ico'
      LangIconToShowPressed='ico\toggle-on-filled-left.ico'
  END
  !get machine ip info
  !NetGetIPInfo (qIP, 0)
  !loop r#=1 to records(qip)
  !    get(qip,r#)
  !END
  SELF.Open(Window)                                        ! Open window
  AllPacketsDone=getini('Stats','PacketsDone',,system{prop:datapath}&'Sidock.ini')
  update
  0{prop:buffer}=1
  Do DefineListboxStyle
  Alert(AltKeyPressed)  ! WinEvent : These keys cause a program to crash on Windows 7 and Windows 10.
  Alert(F10Key)         !
  Alert(CtrlF10)        !
  Alert(ShiftF10)       !
  Alert(CtrlShiftF10)   !
  Alert(AltSpace)       !
  WinAlertMouseZoom()
  WinAlert(WE::WM_QueryEndSession,,Return1+PostUser)
                   ! Start of HyperActive Init Code
  ThisHyperActive.HandCursorToUse = 'hand2.cur'
  ThisHyperActive.HandCursorToUse = '~' & ThisHyperActive.HandCursorToUse
  ThisHyperActive.Init(event:Timer )
  ThisHyperActive.LimitURL=-1
  ThisHyperActive.ItemQ.SkypeFunction = 0
  ThisHyperActive.AddString(?covidlink,'http://covid.si',16711680,16711680,8592,400)
  ThisHyperActive.Refresh()
                   ! End of HyperActive Init Code
  SELF.SetAlerts()
  ?LIST1{PROP:LineHeight}=11
  alert(EscKey)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  If self.opened Then WinAlert().
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  notify(1,1)
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?button
      if glo:CPUThreadCount>vuProcessorCount() or glo:CPUThreadCount=0
          message(tmsg[27]&vuProcessorCount()&'!')
          cycle
      END
      
      ?PROGRESS1{PROP:RangeHigh}=glo:CPUThreadCount
      !cleanup'
      izhodnipodatki=datapath&'packet\packet*.*'        
      vudelete(izhodnipodatki,0,0)
      izhodnipodatki=datapath&'target*.*'        
      vudelete(izhodnipodatki,0,0)
      izhodnipodatki=datapath&'packet\OUT_T*.sdf'    
      vudelete(izhodnipodatki,0,0)     
      
      L:opis=tmsg[28]
      add(log);update;display;select(?list1,pointer(log))
      URL='https://api.covid.si/target'
      klic=1
      EngineStatus"=enginestatus
      enginestatus=tmsg[19]
      tarca=TalkToServer(URL,klic) !id tarèe
      EngineStatus=enginestatus"
      if tarca<1
          !message('Nobene tarèe ni na voljo, prekinjam delo!')
          if glo:AutoRepeatDocking=false
              L:oPIS=tMsg[29]
              add(log);update;display;select(?list1,pointer(log))
              cycle
          ELSE
              L:oPIS=tmsg[30]
              add(log);update;display;select(?list1,pointer(log))
              Restart=true
              cycle
          END
      ELSE
          L:Opis=tmsg[31]&tarca
          add(log);update;display;select(?list1,pointer(log))
          ! check statistics for this target
          
          L:opis=tmsg[47]
          add(log);update;display;select(?list1,pointer(log))
          URL='https://api.covid.si/current'
          klic=6
          EngineStatus"=enginestatus
          enginestatus=tmsg[19]
          RemainingPackagesOnServer=TalkToServer(URL,klic,,tarca,1) !id tarèe    
          EngineStatus=enginestatus"
          if RemainingPackagesOnServer>99999 
              RemainingPackagesOnServer=tMsg[49]
          ELSE
              RemainingPackagesOnServer=13890-RemainingPackagesOnServer
          END    
          UPDATE
          display
          !statistics end
      END
      
      URL='https://api.covid.si/'&tarca&'/file/target/archive'
      klic=2
      EngineStatus"=enginestatus
      enginestatus=tmsg[19]
      rezultat=TalkToServer(URL,klic) !vsebina tarèe
      EngineStatus=enginestatus"
      if rezultat<1
          !message('Prenos tarèe s strežnika ni uspel, prekinjam delo!')    
          if glo:AutoRepeatDocking=false
              L:oPIS=tmsg[32]
              add(log);update;display;select(?list1,pointer(log))
              cycle
          ELSE
              L:oPIS=tmsg[33]
              add(log);update;display;select(?list1,pointer(log))
              Restart=true
              cycle
          END
      ELSE
          L:Opis=tmsg[34]
          add(log);update;display;select(?list1,pointer(log))
      END
      if rezultat=1002 !imamo tarèo, gremo po paket
          URL='https://api.covid.si/'&tarca&'/counter'
          klic=3
          EngineStatus"=enginestatus
          enginestatus=tmsg[19]
          paket=TalkToServer(URL,klic) !id paketa
          EngineStatus"=enginestatus
      END
      if paket<1
          !message('Ni paketov! Prekinjam delo.')
          if glo:AutoRepeatDocking=false
              L:oPIS=tmsg[35]
              add(log);update;display;select(?list1,pointer(log))
              cycle
          ELSE
              L:oPIS=tmsg[36]
              add(log);update;display;select(?list1,pointer(log))
              Restart=true
              cycle
          END 
      ELSE
          L:Opis=tmsg[37]&paket
          add(log);update;display;select(?list1,pointer(log))
          URL='https://api.covid.si/'&tarca&'/file/down/'&paket
          klic=4
          EngineStatus"=enginestatus
          enginestatus=tmsg[19]
          rezultat=TalkToServer(URL,klic) !vsebina paketa
          EngineStatus=enginestatus"
      END
      if rezultat<1
          !message('Prenos paketa s strežnika ni uspel. Prekinjam delo.')
          if glo:AutoRepeatDocking=false
              L:oPIS=tmsg[38]
              add(log);update;display;select(?list1,pointer(log))
              cycle
          ELSE
              L:oPIS=tMsg[39]
              add(log);update;display;select(?list1,pointer(log))
              Restart=true
              cycle
          END
      ELSE
          L:Opis=tMsg[40]
          add(log);update;display;select(?list1,pointer(log))
      END
      
      if glo:CPUThreadCount>1 and glo:CPUThreadCount<=vuProcessorCount()
          DO packet_split
          L:Opis=tMsg[41]
          add(log);update;display;select(?list1,pointer(log))
      END
      L:Opis=tMsg[42]&paket
      add(log);update;display;select(?list1,pointer(log))
      do docking
      
      
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BUTTON1
      ThisWindow.Update()
       POST(EVENT:CloseWindow)
    OF ?button:2
      ThisWindow.Update()
      started=0
      oj.CloseAll()
      L:opis='Job stopped!'
      add(log);update;display;select(?list1,pointer(log))
              izhodnipodatki=datapath&'packet\packet*.*'        
              vudelete(izhodnipodatki,0,0)        
              izhodnipodatki=datapath&'target*.*'
              vudelete(izhodnipodatki,0,0)        
              izhodnipodatki=datapath&'htvs.ptc'
              vudelete(izhodnipodatki,0,0)    
      L:opis='Post operation cleanup done!'
      add(log);update;display;select(?list1,pointer(log))
      L:opis='Ready for new target/package!'
      add(log);update;display;select(?list1,pointer(log))
    OF ?about
      ThisWindow.Update()
      START(ABOUT, 25000)
      ThisWindow.Reset
    OF ?FlipLang
      ThisWindow.Update()
      if Glo:language='si' 
          Glo:language='en'
      ELSE
          Glo:language='si'
      END
      if Glo:language='en'
          LangIconToShow='ico\toggle-on-filled-left.ico'
         ! LangIconToShowPressed='ico\toggle-on-filled.ico'
      ELSE
          LangIconToShow='ico\toggle-on-filled.ico'
         ! LangIconToShowPressed='ico\toggle-on-filled-left.ico'
      END
      notify(2,1,thread())
    OF ?FlipLang:2
      ThisWindow.Update()
      GLO:ScreenSaverOpen = START(ShowBigImage, 25000)
      ThisWindow.Reset
    OF ?UpdateAvailable
      ThisWindow.Update()
      CheckUpdate('http://www.neolink.si/files/','SiDockSetup',0)
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    ThisHyperActive.TakeEvent()                      !HyperActive Code
  ReturnValue = PARENT.TakeEvent()
  case keycode()
      of EscKey
          CYCLE
  END
  If event() = event:VisibleOnDesktop !or event() = event:moved
    ds_VisibleOnDesktop()
  end
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeNotify PROCEDURE(UNSIGNED NotifyCode,SIGNED Thread,LONG Parameter)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeNotify(NotifyCode,Thread,Parameter)
  case NOTIFICATION(ncode,,retval)
      of 1
          do translation
          ?CpuDetect{prop:text}=tTitle[3]&vuProcessorCount()
          
      of 2
          ?updateavailable{prop:hide}=FALSE
          ?updateavailable{prop:text}=tmsg[46]
  END
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
    OF EVENT:CloseDown
      if WE::CantCloseNow
        WE::MustClose = 1
        cycle
      else
        self.CancelAction = cancel:cancel
        self.response = requestcancelled
      end
    OF EVENT:OpenWindow
      do translation
      ?CpuDetect{prop:text}=tTitle[3]&vuProcessorCount()
      ?progress1{PROP:RangeHigh}=vuProcessorCount()
      ?glo:CPUThreadCount{PROP:RangeHigh}=vuProcessorCount()
      ?glo:CPUThreadCount{PROP:RangeLow}=1
      if glo:CPUThreadCount=0 then glo:CPUThreadCount=1;update;DIsplay.
      StartTotal=ux.ClarionToUnixDate(today(),clock())
      !StartTotal=ux.ClarionToUnixDate(deformat('01.09.2019',@d6.),deformat('12:15:12',@t4))  !test
      L:oPIS=tMsg[44]&glo:machineId
      add(log);select(?list1,pointer(log))
      
      DIRECTORY(filequeue,system{PROP:DataPath}&'ssimage*.jpg',ff_:NORMAL)
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
      ThisHyperActive.Refresh()
        post(event:visibleondesktop)
    OF EVENT:Timer
      if records(FileQueue)
          IdleTime=vuIdleTime()
          if IdleTime>300 and glo:screensaverOpen=0 and GLO:allowScreenSaver=true then  GLO:ScreenSaverOpen=start(ShowBigImage,25000). !open screensaver
          if IdleTime=0 and glo:ScreenSaverOpen>0 then notify(1,glo:screensaveropen). !close screensaver
      END
      
      UnlimitedCounter+=1
      if UnlimitedCounter%10=0
          CPUUsage=vuCPUusage()
          ?progress2{prop:progress}=CPUUsage
          ?cpupercent{prop:text}=CPUUsage&'%'
      END
      
      if InitiateVersionCheck
          InitiateVersionCheck=0
          CheckUpdate('http://www.neolink.si/files/','SiDockSetup',2, thread())
      END
      
      if records(ActiveThreadsQueue)=0 and ?button{prop:disable}=TRUE
          ?button{prop:disable}=FALSE
      END
      if records(ActiveThreadsQueue)>0 and ?button{prop:disable}=false
          ?button{prop:disable}=true
      END
      do show_total_time
      
      if restart=100 !10 sek
          restart=0
          do clean_start
      END
          
      if restart>0    
          restart+=1
          EngineStatus=tMsg[45];update(EngineStatus);display(EngineStatus)
          CYCLE
      END
      izhodnipodatki=stout.getvalue()
      UPDATE
      display()
      do show_active_threads
      if records(ActiveThreadsQueue)=0 and StartTotal<>0 and started=1
          started=0
          L:Opis=tMsg[23]
          add(log);update;display;select(?list1,pointer(log))
          do assemble_packet
          if outputready=1
              outputready=0
              do Upload_results
          END    
          L:Opis=tMsg[24]
          add(log);update;display;select(?list1,pointer(log))
          select(?list1,pointer(log))
          putini('Stats','PacketsDone',getini('Stats','PacketsDone',,system{prop:datapath}&'Sidock.ini')+1,system{prop:datapath}&'Sidock.ini')    
          AllPacketsDone=getini('Stats','PacketsDone',,system{prop:datapath}&'Sidock.ini')
              oj.CloseAll()
          update
          if glo:AutoRepeatDocking
              do clean_start
          END
          
          !message('Packet done')
      END
      
      !rotator
      if started=1
          EngineStatus=tMsg[25];Update();display()    
          rotator+=1
          if rotator=13 then rotator=1.!;select(?list1,pointer(log)).
          ?image1{prop:hide}=false
          ?image1{prop:text}='ico\loading3-animation-'&FORMAT(ROTATOR,@N02)&'.ico'    
      ELSE
          ?image1{prop:hide}=true
          EngineStatus=tmsg[26];Update();display()    
      END
      UPDATE
      display()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!----------------------------------------------------
ThisHyperActive.GetListURL   PROCEDURE (LONG HyperControl,STRING HyperURL,<STRING FirstEmailName>,<STRING LastEmailName>)
ReturnValue   any
HATempVar                 long
  CODE
  Return ReturnValue
  ReturnValue = PARENT.GetListURL (HyperControl,HyperURL,FirstEmailName,LastEmailName)
    Return ReturnValue
!----------------------------------------------------
oj.ErrorTrap   PROCEDURE (string desc, long err, <string fnName>)
  CODE
 stop(tmsg[43])
  PARENT.ErrorTrap (desc,err,fnName)


!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
TalkToServer PROCEDURE (String URL, byte Klic, <STRING OutputData>,<Long Tarca>,<Byte Method>)

api_key              CSTRING(200)                          ! 
retval               LONG                                  ! 
Window               WINDOW,AT(,,165,40),FONT('Segoe UI',10,,,CHARSET:EASTEUROPE),NOFRAME,CENTER,COLOR(00F0F0F0h), |
  MDI
                       BOX,AT(0,0,165,40),USE(?BOX1),COLOR(COLOR:Black),LINEWIDTH(1)
                       BOX,AT(0,0,101,12),USE(?BOX1:2),COLOR(COLOR:Black),FILL(00FFC0C0h),LINEWIDTH(1)
                       PROMPT('Server communication'),AT(7,2),USE(?PROMPT1),FONT(,10),TRN
                       PROMPT('Server data exchange...please wait...'),AT(2,21,162),USE(?PROMPT1:2),FONT(,10),CENTER, |
  COLOR(00F0F0F0h),TRN
                     END

    omit('***',WE::CantCloseNowSetHereDone=1)  !Getting Nested omit compile error, then uncheck the "Check for duplicate CantCloseNowSetHere variable declaration" in the WinEvent local template
WE::CantCloseNowSetHereDone equate(1)
WE::CantCloseNowSetHere     long
    !***
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
! ----- st --------------------------------------------------------------------------
st                   Class(StringTheory)
                     End  ! st
! ----- end st -----------------------------------------------------------------------
!Local Data Classes
nt                   CLASS(NetWebClient)                   ! Generated by NetTalk Extension (Class Definition)
ErrorTrap              PROCEDURE(string errorStr,string functionName),DERIVED
PageReceived           PROCEDURE(),DERIVED

                     END

Res         LONG

Unzip       UnzipClassType
UnzipFilesQ UnzipResultType

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop
  RETURN(retval)

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('TalkToServer')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?BOX1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.Open(Window)                                        ! Open window
                                               ! Generated by NetTalk Extension (Start)
  nt.SuppressErrorMsg = 1         ! No Object Generated Error Messages ! Generated by NetTalk Extension
  nt.init()
  if nt.error <> 0
    ! Put code in here to handle if the object does not initialise properly
  end
  Do DefineListboxStyle
  Alert(AltKeyPressed)  ! WinEvent : These keys cause a program to crash on Windows 7 and Windows 10.
  Alert(F10Key)         !
  Alert(CtrlF10)        !
  Alert(ShiftF10)       !
  Alert(CtrlShiftF10)   !
  Alert(AltSpace)       !
  WinAlertMouseZoom()
  WinAlert(WE::WM_QueryEndSession,,Return1+PostUser)
  SELF.SetAlerts()
  ?PROMPT1:2{prop:text}=tTitle[12]
  ?PROMPT1{prop:text}=tTitle[13]
  api_key=REPLACE_WITH_RIGHT_API_KEY
  nt.SetAllHeadersDefault()
  nt.ProxyConnectionKeepAlive = 0  ! Close the connection after each transaction
  nt.ConnectionKeepAlive = 0  ! Close the connection after each transaction
  nt.CanUseProxy = 1  ! Can use Internet Explorer Proxy settings
  nt.Pragma_ = 'No-Cache'     ! Force any proxies to not use their cache. Uses more bandwidth but will contact the webserver directly which is what we want.
  nt.CacheControl = 'No-Cache'! Force any proxies to not use their cache. Uses more bandwidth but will contact the webserver directly which is what we want.
  nt.AsyncOpenTimeOut=1000
  nt.InActiveTimeout=1500
  nt.CanUseProxy=1    
  !nt.FormEncodeType('multipart/form-data')
  nt.SetContentType('form')
  nt.SSLCertificateOptions.DontVerifyRemoteCertificateCommonName=1
  nt.SSLCertificateOptions.DontVerifyRemoteCertificateWithCARoot=1    
  nt.setvalue('apikey',REPLACE_WITH_RIGHT_APIKEY)
  if outputdata    
      nt.setvalue('data',outputdata,true)    
  END
  if glo:CPUThreadCount
      nt.setvalue('ThreadCount',glo:CPUThreadCount)
      nt.setvalue('ClientGUID',glo:MachineId)
  END
  if method=0
      nt.post(url)    
  ELSE
      nt.get(url)
  END
  
      
      
      
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  nt.Kill()                              ! Generated by NetTalk Extension
  If self.opened Then WinAlert().
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    nt.TakeEvent()                 ! Generated by NetTalk Extension
  ReturnValue = PARENT.TakeEvent()
  If event() = event:VisibleOnDesktop !or event() = event:moved
    ds_VisibleOnDesktop()
  end
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
    OF EVENT:CloseDown
      if WE::CantCloseNow
        WE::MustClose = 1
        cycle
      else
        self.CancelAction = cancel:cancel
        self.response = requestcancelled
      end
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
        post(event:visibleondesktop)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


nt.ErrorTrap PROCEDURE(string errorStr,string functionName)


  CODE
  PARENT.ErrorTrap(errorStr,functionName)
  retval=-1
  !message('Napaka: '&errorstr)
  post(event:closewindow)


nt.PageReceived PROCEDURE


  CODE
  PARENT.PageReceived
  if klic=1
      nt.RemoveHeader()
      retval=nt.ThisPage.GetValue()
      if retval<0
          retval=0
      END    
      post(EVENT:CloseWindow)
  END
  
  if klic=2
      nt.RemoveHeader()    
      nt.SavePage(system{proP:datapath}&'TARGET.zip')
      unzip.init(,,,,,,LIC:UserName, LIC:UserPin)
      ! Define the zip archive name
      Res = Unzip.SetArchiveName( system{proP:datapath}&'TARGET.zip' )
  
  ! Define all files to be unzipped
      Unzip.DefineFileSpec( '*' )
  
  ! Define the target path
      Res = Unzip.ExtractTo( system{proP:datapath} )
  
  ! Add flag
      Unzip.AddFlag( UZ_QUIET_FLAG )
      Unzip.AddFlag( UZ_OVERWRITE_FLAG )
  
  ! Execute unzip command
      Res = Unzip.LSZExecute( uzm_EXTRACT )
      retval=1002
      post(EVENT:CloseWindow)
  END
  
  if klic=3
      nt.RemoveHeader()
      retval=nt.ThisPage.GetValue()
      post(EVENT:CloseWindow)
  END
  
  if klic=4
      nt.RemoveHeader()
      nt.SavePage(system{proP:datapath}&'packet\packet.sdf')
      retval=1004
      post(EVENT:CloseWindow)
  END
  
  if klic=5
      nt.RemoveHeader()    
      if instring('200',nt.ThisPage.getvalue(),1,1) and instring('OK',nt.ThisPage.getvalue(),1,1)
          retval=1005
      ELSE
          retval=0
      END    
      post(EVENT:CloseWindow)
  END
  
  if klic=6
      retval=100000 
      nt.RemoveHeader()
      SETCLIPBOARD(nt.thispage.getvalue())
      st.setvalue(nt.thispage.getvalue())
      st.split(chr(10)) 
      if st.Records()
          loop z#=1 to st.Records()
              st.SetValue(st.GetLine(Z#))             
              retval=st.Between('',':')            
              if retval=tarca
                  retval=st.between(':','')
                  if retval>=13890 then retval=100000.
                  break
              END            
          END        
      END        
      st.FreeLines()
      post(EVENT:CloseWindow)
  END



!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
CheckUpdate PROCEDURE (string UpdateURL,string PROGName,BYTE AutoCheck,<LONG CallingThread>)

RV                   LONG                                  ! 
newversion           LONG                                  ! 
korak                BYTE                                  ! 
Window               WINDOW('Update check'),AT(,,278,91),FONT('Segoe UI',10,,FONT:regular,CHARSET:EASTEUROPE),CENTER, |
  IMM,SYSTEM
                       BOX,AT(5,59,93,28),USE(?BOX1:2),COLOR(COLOR:BTNTEXT),LINEWIDTH(1)
                       BOX,AT(181,59,93,28),USE(?BOX1:3),COLOR(COLOR:BTNTEXT),LINEWIDTH(1)
                       BOX,AT(4,1,270,54),USE(?BOX1),COLOR(COLOR:BTNTEXT),LINEWIDTH(1)
                       PROMPT(''),AT(13,7,233,44),USE(?info),FONT('Segoe UI',12,COLOR:BTNTEXT,,CHARSET:EASTEUROPE), |
  TRN
                       PROGRESS,AT(255,6,14,45),USE(?PROGRESS1),HIDE,RANGE(0,100),SMOOTH,VERTICAL
                       BUTTON('Update'),AT(5,59,93,28),USE(?posodobi),FONT(,14),LEFT,ICON('ico\button-circle-p' & |
  'lay-filled.ico'),DISABLE,FLAT
                       BUTTON('&Cancel'),AT(181,59,93,28),USE(?zapri),FONT(,14),LEFT,ICON('ico\button-circle-s' & |
  'top-filled.ico'),DISABLE,FLAT,STD(STD:Close)
                     END

    omit('***',WE::CantCloseNowSetHereDone=1)  !Getting Nested omit compile error, then uncheck the "Check for duplicate CantCloseNowSetHere variable declaration" in the WinEvent local template
WE::CantCloseNowSetHereDone equate(1)
WE::CantCloseNowSetHere     long
    !***
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
! ----- st --------------------------------------------------------------------------
st                   Class(StringTheory)
                     End  ! st
! ----- end st -----------------------------------------------------------------------
!Local Data Classes
nt                   CLASS(NetWebClient)                   ! Generated by NetTalk Extension (Class Definition)
ErrorTrap              PROCEDURE(string errorStr,string functionName),DERIVED
PageReceived           PROCEDURE(),DERIVED
SavePage               PROCEDURE(string p_FileName),DERIVED

                     END

Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
posodobi_verzijo    ROUTINE
DATA

CODE
    nt.SetAllHeadersDefault()     ! We recomment you call this before Fetch()
    nt.ProxyConnectionKeepAlive = 0  ! Close the connection after each transaction
    nt.ConnectionKeepAlive = 0  ! Close the connection after each transaction
    nt.AsyncOpenTimeOut = 1200    ! 12 seconds
    nt.InActiveTimeout = 9000     ! 90 seconds
    nt.CanUseProxy = 1  ! Can use Internet Explorer Proxy settings
    nt.Pragma_ = 'No-Cache'     ! Force any proxies to not use their cache. Uses more bandwidth but will contact the webserver directly which is what we want.
    nt.CacheControl = 'No-Cache'! Force any proxies to not use their cache. Uses more bandwidth but will contact the webserver directly which is what we want.
    nt.SSLCertificateOptions.DontVerifyRemoteCertificateCommonName = 1
    nt.SSLCertificateOptions.DontVerifyRemoteCertificateWithCARoot = 1
    nt.HTTPVersion='HTTP/1.1'
    ?info{prop:text}=?info{prop:text}&'<13,10>'&tMsg[14]
    ?progress1{prop:progress}=0
    nt.progresscontrol=?progress1
    disable(?posodobi)    
    korak=2
    nt.get(clip(updateurl)&clip(PROGName)&'.exe')     
   
    

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('CheckUpdate')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?BOX1:2
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.Open(Window)                                        ! Open window
                                               ! Generated by NetTalk Extension (Start)
  nt.SuppressErrorMsg = 1         ! No Object Generated Error Messages ! Generated by NetTalk Extension
  nt.init()
  if nt.error <> 0
    ! Put code in here to handle if the object does not initialise properly
  end
  Do DefineListboxStyle
  Alert(AltKeyPressed)  ! WinEvent : These keys cause a program to crash on Windows 7 and Windows 10.
  Alert(F10Key)         !
  Alert(CtrlF10)        !
  Alert(ShiftF10)       !
  Alert(CtrlShiftF10)   !
  Alert(AltSpace)       !
  WinAlertMouseZoom()
  WinAlert(WE::WM_QueryEndSession,,Return1+PostUser)
  Resizer.Init(AppStrategy:Resize)                         ! Controls will change size as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  SELF.SetAlerts()
  0{prop:text}=tMsg[1]
  ?posodobi{prop:text}=tMsg[2]
  ?zapri{prop:text}=tMsg[3]
  nt.SetAllHeadersDefault()     ! We recomment you call this before Fetch()
  !nt.ProxyConnectionKeepAlive = 1  ! Close the connection after each transaction
  !nt.ConnectionKeepAlive = 1  ! Close the connection after each transaction
  nt.AsyncOpenTimeOut = 1000    ! 12 seconds
  nt.InActiveTimeout = 1500     ! 30 seconds
  nt.CanUseProxy = 1  ! Can use Internet Explorer Proxy settings
  nt.Pragma_ = 'No-Cache'     ! Force any proxies to not use their cache. Uses more bandwidth but will contact the webserver directly which is what we want.
  nt.CacheControl = 'No-Cache'! Force any proxies to not use their cache. Uses more bandwidth but will contact the webserver directly which is what we want.
  nt.SSLCertificateOptions.DontVerifyRemoteCertificateCommonName = 1
  nt.SSLCertificateOptions.DontVerifyRemoteCertificateWithCARoot = 1
  nt.HTTPVersion='HTTP/1.1'
  nt.SSLCertificateOptions.CARootFile='caroot.pem'
  if glo:version='' then message('Trenutna verzija ni znana.');return level:fatal.
  if exists(system{PROP:DataPath}&clip(PROGName)&'.exe')
      remove(system{PROP:DataPath}&clip(PROGName)&'.exe')
  END
  ?info{prop:text}=tMsg[4]!'Preverjam verzijo...poèakajte...'
  korak=1
  nt.get(clip(updateurl)&clip(PROGName)&'.upd')
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  nt.Kill()                              ! Generated by NetTalk Extension
  If self.opened Then WinAlert().
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?posodobi
      ?PROGRESS1{PROP:hide}=false
      do posodobi_Verzijo
    END
  ReturnValue = PARENT.TakeAccepted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    nt.TakeEvent()                 ! Generated by NetTalk Extension
  ReturnValue = PARENT.TakeEvent()
  If event() = event:VisibleOnDesktop !or event() = event:moved
    ds_VisibleOnDesktop()
  end
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
    OF EVENT:CloseDown
      if WE::CantCloseNow
        WE::MustClose = 1
        cycle
      else
        self.CancelAction = cancel:cancel
        self.response = requestcancelled
      end
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
        post(event:visibleondesktop)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


nt.ErrorTrap PROCEDURE(string errorStr,string functionName)


  CODE
  PARENT.ErrorTrap(errorStr,functionName)
  if nt.Error=-57
      ?info{prop:text}=tMsg[5]!'Server unavailable.<13,10,13,10>Update failed!'    
  else
      ?info{prop:text}=tMsg[6]&clip(nt.ErrorString)!'Error checking version:<13,10>'&clip(nt.ErrorString)
  END
  enable(?zapri)
  disable(?posodobi)


nt.PageReceived PROCEDURE


  CODE
  PARENT.PageReceived
  if korak=1 and nt.ThisPage.len()>0
  !preverjanje verzije
      nt.removeheader()          
      nt.thispage.split('.')    
      if nt.thispage.Records()<>4    
          ?info{prop:text}=tMsg[7]!'Error checking version. Updating not possible.'
          enable(?zapri)
      else                
          newversion=nt.thispage.getline(4)
          nt.thispage.FreeLines()
          if newversion>glo:version            
              ?info{prop:text}=tMsg[8]&' '&clip(ds_GetFileVersionInfo())&'.<13,10>'&tMsg[9]&' '&clip(nt.thispage.getvalue())&'.<13,10>'&tMsg[10]
              ?progress1{prop:progress}=100     
              enable(?posodobi)
              enable(?zapri)
              notify(2,callingthread)
              if autocheck=2 then post(event:closewindow).
          ELSE
              ?info{prop:text}=tMsg[11]&'<13,10,13,10>'&tMsg[12]
              ?progress1{prop:progress}=100            
              enable(?zapri)
              select(?zapri)
              UPDATE
              display
              if autocheck=1 then post(event:closewindow).
          END
      end
  END
  if korak=2 and nt.ThisPage.len()>0
      !prenos posodobitve
      ?progress1{prop:progress}=100
      nt.savepage(system{PROP:DataPath}&clip(PROGName)&'.exe')    
  END
  


nt.SavePage PROCEDURE(string p_FileName)


  CODE
  PARENT.SavePage(p_FileName)
  if korak=2
      ?info{prop:text}=?info{prop:text}&tMsg[13]
      run(system{PROP:DataPath}&clip(PROGName)&'.exe')    
      halt(0)
   !   post(EVENT:Closewindow)
      RV=1    
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window



!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
ABOUT PROCEDURE 

disclaimer           CSTRING(20000)                        ! 
Window               WINDOW('About'),AT(,,357,220),FONT('Segoe UI',10,,,CHARSET:EASTEUROPE),CENTER,COLOR(00F0F0F0h), |
  MDI,SYSTEM
                       TEXT,AT(8,7,339,206),USE(disclaimer),FONT('Courier New'),VSCROLL,COLOR(COLOR:White)
                     END

    omit('***',WE::CantCloseNowSetHereDone=1)  !Getting Nested omit compile error, then uncheck the "Check for duplicate CantCloseNowSetHere variable declaration" in the WinEvent local template
WE::CantCloseNowSetHereDone equate(1)
WE::CantCloseNowSetHere     long
    !***
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
! ----- st --------------------------------------------------------------------------
st                   Class(StringTheory)
                     End  ! st
! ----- end st -----------------------------------------------------------------------

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('ABOUT')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?disclaimer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  st.loadfile('sidock.disclaimer')
  disclaimer=st.getvalue()
  st.loadfile('sidock.changelog')
  disclaimer=disclaimer&'<13,10,13,10>'&st.getvalue()
  !change(?TEXT1,st.getvalue())
  UPDATE
  display()
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  Alert(AltKeyPressed)  ! WinEvent : These keys cause a program to crash on Windows 7 and Windows 10.
  Alert(F10Key)         !
  Alert(CtrlF10)        !
  Alert(ShiftF10)       !
  Alert(CtrlShiftF10)   !
  Alert(AltSpace)       !
  WinAlertMouseZoom()
  WinAlert(WE::WM_QueryEndSession,,Return1+PostUser)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  If self.opened Then WinAlert().
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeEvent()
  If event() = event:VisibleOnDesktop !or event() = event:moved
    ds_VisibleOnDesktop()
  end
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
    OF EVENT:CloseDown
      if WE::CantCloseNow
        WE::MustClose = 1
        cycle
      else
        self.CancelAction = cancel:cancel
        self.response = requestcancelled
      end
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
      0{prop:text}=tTitle[11]
        post(event:visibleondesktop)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue



!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
ShowBigImage PROCEDURE 

ImageNumber          LONG                                  ! 
ncode                LONG                                  ! 
FileQueue            QUEUE(file:queue),PRE(FQ)             ! 
                     END                                   ! 
retval               LONG                                  ! 
Window               WINDOW,AT(,,577,367),FONT('Segoe UI',9),NOFRAME,CENTER,GRAY,SYSTEM,TIMER(1000)
                       IMAGE,AT(0,0,577,367),USE(?IMAGE1)
                     END

    omit('***',WE::CantCloseNowSetHereDone=1)  !Getting Nested omit compile error, then uncheck the "Check for duplicate CantCloseNowSetHere variable declaration" in the WinEvent local template
WE::CantCloseNowSetHereDone equate(1)
WE::CantCloseNowSetHere     long
    !***
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeNotify             PROCEDURE(UNSIGNED NotifyCode,SIGNED Thread,LONG Parameter),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('ShowBigImage')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?IMAGE1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  Alert(AltKeyPressed)  ! WinEvent : These keys cause a program to crash on Windows 7 and Windows 10.
  Alert(F10Key)         !
  Alert(CtrlF10)        !
  Alert(ShiftF10)       !
  Alert(CtrlShiftF10)   !
  Alert(AltSpace)       !
  WinAlertMouseZoom()
  WinAlert(WE::WM_QueryEndSession,,Return1+PostUser)
  Resizer.Init(AppStrategy:Resize)                         ! Controls will change size as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  If self.opened Then WinAlert().
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeEvent()
  If event() = event:VisibleOnDesktop !or event() = event:moved
    ds_VisibleOnDesktop()
  end
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeNotify PROCEDURE(UNSIGNED NotifyCode,SIGNED Thread,LONG Parameter)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeNotify(NotifyCode,Thread,Parameter)
  case notification(ncode,retval)
      of 1
          post(event:closewindow)
  END
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
    OF EVENT:CloseDown
      if WE::CantCloseNow
        WE::MustClose = 1
        cycle
      else
        self.CancelAction = cancel:cancel
        self.response = requestcancelled
      end
    OF EVENT:CloseWindow
      glo:screensaveropen=0
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
      DIRECTORY(FileQueue,system{PROP:DataPath}&'ScreenSaver\*.jpg',ff_:NORMAL)
      if records(filequeue)   
          get(filequeue,1)
          ?image1{prop:text}=system{PROP:DataPath}&'ScreenSaver\'&Filequeue:name!   clip('img1.jpg')
          0{PROP:Maximize}=true
      ELSE
          return level:fatal
      END
      ImageNumber=1
      !0{prop:text}=tTitle[15]
        post(event:visibleondesktop)
    OF EVENT:Timer
      ImageNumber+=1
      if imagenumber>records(filequeue) then imagenumber=1.
      get(filequeue,ImageNumber)
      ?image1{prop:text}=system{PROP:DataPath}&'ScreenSaver\'&Filequeue:name
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

