   10ONERRORGOTOc1%
   20MODE0:PROCX:PROCY:PROCZ:PROCG(Y):IFX$=""ELSEIFFN3PROCG(Z)
   80PROCH:y1%=TRUE:IFFN4PROCF
  110PROCJ:PROC8:PROC9:PROC2:IFFN0(-1,0,0)
  150VDU26:IF`0%PROC0
  170PROCF
  180.c1%:IF(INKEY-1ANDERR=17)ORINKEY-65MODE0:REPORT:PRINT" at line ";ERL:END
  200IFy1%=FALSERUN
  210PROC0:PROCF
  230DEFPROCZ:VDU19,0,4|19,1,7|:CLOSE#OPENIN("ECONET:"):ENDPROC
  280DEFPROCF:REPEAT:`0%=FALSE:REPEAT:PROC_:UNTIL`0%:ONERRORGOTOc1%
  350PROC0:UNTILFALSE
  370DEFPROC_:A%=FN0(100,0,0):PROC2:PROC4:IF`0%ENDPROC
  410IFA%>=128+14ANDA%<=128+15PROC`:PROCK:PROC2:ENDPROC
  420IFA%=m2%ORA%=13PROCB(_%):ENDPROC
  430IFA%=n2%PROCa:ENDPROC
  440IFA%=o2%PROCM(""):PROCC:PROC9:ENDPROC
  450IFA%=p2%PROCb:ENDPROC
  460IFA%=q2%PROCc:ENDPROC
  470IFA%=r2%PROCD(FALSE)
  480IFA%=s2%PROCD(TRUE)
  490IFA%=@ECPHON%_%=y%:PROCB(y%):ENDPROC
  500IFA%=@ECCALC%_%=k%:PROCB(k%):ENDPROC
  510IFA%=@ECCOMP%_%=n%:PROCB(n%):ENDPROC
  520IFA%=@ECSTOP%`0%=TRUE:ENDPROC
  530IFA%=@ECHELP%a0%=1:PROC@HELP:`0%=TRUE:ENDPROC
  540ENDPROC
  560DEFPROCH:LOCALd1%,e1%,z$,`%:d1%=FALSE:e1%=FALSE:_%=1:`%=1:$G=STRING$(p0%," "):$G="BASIC":CALLb0%:IF@C%PROC@("no BASIC module found","",0)ELSEz1%=@BHA%
  650REPEAT:$G=M$(`%):CALLb0%:IF@C%GOTOT
  690IF(_%>c%)GOTOt2%
  700Z$=LEFT$($G,INSTR($G+" "," ")-1):_$=FN@(Z$):G$(_%)=Z$:o%(_%)=@BHA%:CALLq0%:IF(@A%AND@MHCMEN%)ELSEGOTOT
  780z%(_%)=@A%:d1%=TRUE:PROCI(_%):IF_$="CALCULATOR"k%=_%
  820IF_$="PHONE"y%=_%
  830IF_$="CONFIGURE"i0%=_%
  850_%=_%+1
  860.T:`%=`%+1:IF`%>c%e1%=TRUE
  880.k:UNTILe1%:IFd1%=TRUEGOTO_
  910PROC@("The main menu configure file does not contain any valid Modules.","Please use Configure to change the main menu task selection.",2):M$(1)="BASIC":M$(2)="Configure":PROCH:ENDPROC
  950._:b%=_%-1:_%=1:ENDPROC
 1000.t2%:PROC@("Too many tasks.","The maximum number of tasks allowed is: "+c%,1):b%=c%:_%=1:ENDPROC
 1050DEFPROCI(d%):IF$G=""PROC@("Error - won't allocate space","Module is without a name",1):ENDPROC
 1070IF(z%(d%)AND@MHCBAS%)A%=0:X%=u2%:CALLo%(d%):r%(d%)=@BHA%:o%(d%)=z1%
 1080IFFN@(G$(d%))="BASIC"u%(d%)=&C000ELSEu%(d%)=&4000
 1100ENDPROC
 1110DEFPROCd:IF$G=""ENDPROC
 1130IFb%=c%ENDPROC
 1140CALLb0%:IF@C%PROC@("Unable to find task "+$G+" in module table","",1):ENDPROC
 1160o%(b%+1)=@BHA%:CALLq0%:IF(@A%AND@MHCMEN%)ELSEPROC@("task "+$G+" is not permitted to appear on the task list","",1):ENDPROC
 1190z%(b%+1)=@A%:b%=b%+1:e%(b%)=0:f%(b%)=0:a%(b%)=0:h%(b%)=0:r%(b%)=0:u%(b%)=0:s%(b%)=0:G$(b%)=$G:PROCI(b%):ENDPROC
 1320DEFFN3:LOCALv%:v%=FALSE:IFX$=""GOTOU
 1350OSCLI("LOGON "+X$):IF@ERC%GOTOU
 1370v%=TRUE
 1380.U:PROC2:PROC4:=v%
 1420DEFFN4:LOCAL`%,v%:IFS$=""GOTO`
 1450`%=1:v%=FALSE:_%=0:S$=FN@(S$):REPEAT:IFS$=FN@(G$(`%))_%=`%:PROCE(`%,Q):v%=TRUEELSE`%=`%+1
 1490UNTILv%OR`%>b%:IFv%THEN=TRUE
 1510.`:_%=1:=FALSE
 1560DEFPROCG(f1%):LOCALa%,c0%,Q$,r0%:IFf1%a%=OPENIN("ram:!c.main")ELSEa%=OPENIN("ram:c.main")
 1590IFa%=0ANDf1%ELSEGOTOa
 1600PROC@("The main menu configure file has not been found in the CMOS memory.","Please use Configure to create the main menu task selection.",2):M$(1)="BASIC":M$(2)="Configure":ENDPROC
 1630.a:IFa%=0ANDNOTf1%ENDPROC
 1650c0%=0:r0%=0:REPEAT:c0%=c0%+1:Q$=GET$#a%:IFLEFT$(Q$,1)="W"X$=MID$(Q$,2):GOTOR
 1710IFLEFT$(Q$,1)="X"S$=MID$(Q$,2):GOTOR
 1720IFc0%>c%GOTOR
 1740M$(c0%)=MID$(Q$,2,p0%):r0%=c0%
 1750.R:UNTILEOF#a%:LOCALg1%:IFr0%<c%FORg1%=r0%+1TOc%:M$(g1%)="":NEXTg1%
 1790CLOSE#a%:ENDPROC
 1820DEFPROCa:LOCAL`%:IFb%=c%PROC@("The task list is full - you must first delete a task from the list","before adding a new task. Press KILL to delete a task",1):GOTOH
 1850IF(FN@(G$(_%))="CONFIGURE")PROC@("Only one Configure task can be started.","Please use start to run it.",1):GOTOH
 1860IF(FN@(G$(_%))="CAROUSEL")PROC@("Only one Carousel task can be started.","Please use start to run it.",1):GOTOH
 1870IF(FN@(G$(_%))="PHONE")PROC@("Only one Phone task can be started.","Please use start to run it.",1):GOTOH
 1880IFFN2PROCLELSEGOTOH
 1890_%=_%+1:b%=b%+1:FOR`%=b%TO_%STEP-1:G$(`%)=G$(`%-1):o%(`%)=o%(`%-1):r%(`%)=r%(`%-1):u%(`%)=u%(`%-1):e%(`%)=e%(`%-1):z%(`%)=z%(`%-1):f%(`%)=f%(`%-1):a%(`%)=a%(`%-1):h%(`%)=h%(`%-1):s%(`%)=s%(`%-1):IFn%=`%-1n%=`%
 2030IFy%=`%-1y%=`%
 2040IFk%=`%-1k%=`%
 2050IFi0%=`%-1i0%=`%
 2060NEXT`%:r%(_%)=0:e%(_%)=0:f%(_%)=0:a%(_%)=0:h%(_%)=FALSE:s%(_%)=0:$G=G$(_%):CALLb0%:IF@C%PROC@("Unable to create a duplicate task ","",1):GOTOH
 2170o%(_%)=@BHA%:PROCI(_%):IFFN@(G$(_%))="CALCULATOR"k%=_%ELSEn%=_%
 2200PROCE(_%,Q)
 2210.H:ENDPROC
 2240DEFPROCM(e$):LOCAL`%,Z$,K:K=TRUE:IF_%=1GOTOb
 2280IFFN@(G$(_%))=FN@(G$(_%-1))K=FALSE:GOTOV
 2290.b:IF_%=b%GOTOV
 2310IFFN@(G$(_%))=FN@(G$(_%+1))K=FALSE
 2320.V:IFNOTKELSEIFh%(_%)PROCN(_%,e$):ENDPROCELSEPROC@("There is no "+G$(_%)+" task active.","Please use the START key to start a task.",1):ENDPROC
 2340PROCN(_%,e$):b%=b%-1:IF_%=(b%+1)GOTOc
 2370FOR`%=_%TOb%:G$(`%)=G$(`%+1):o%(`%)=o%(`%+1):r%(`%)=r%(`%+1):u%(`%)=u%(`%+1):e%(`%)=e%(`%+1):z%(`%)=z%(`%+1):f%(`%)=f%(`%+1):a%(`%)=a%(`%+1):h%(`%)=h%(`%+1):s%(`%)=s%(`%+1):IFk%=`%+1k%=`%
 2490IFn%=`%+1n%=`%
 2500IFy%=`%+1y%=`%
 2510IFi0%=`%+1i0%=`%
 2520NEXT`%
 2530.c:IFk%=_%PROCe
 2550IF_%<>1_%=_%-1ELSEIFb%=0_%=0
 2560ENDPROC
 2580DEFPROCe:LOCALd0%:d0%=1:REPEAT:IFFN@(G$(d0%))="CALCULATOR"k%=d0%:UNTILTRUE:ENDPROC
 2620d0%=d0%+1:UNTILd0%>b%:PROC@("The last calculator task has just been killed","The machine will have to be switched off and on before the calculator can be used again",1):ENDPROC
 2670DEFFN5(I%):LOCALT$:T$=o$+"Use KILL to delete tasks":IF(FN@(G$(I%))="CONFIGURE")ANDa%(I%)PROC@("Only one Configure task can be started.","Please use start to run it.",1):=&FF
 2700IF(FN@(G$(I%))="CAROUSEL")ANDa%(I%)PROC@("Only one Carousel task can be started.","Please use start to run it.",1):=&FF
 2710IF(FN@(G$(I%))="PHONE")ANDa%(I%)PROC@("Only one Phone task can be started.","Please use start to run it.",1):=&FF
 2720X%=@COCRE%:A%=o%(I%):D%=@SMSTK%:CALL(s0%+@USED%):IF@C%>0PROC@("Coroutine create failed -",G$(I%)+T$,1)ELSEa%(I%)=@Y%:h%(I%)=TRUE
 2760=@C%
 2770DEFPROCN(I%,T$):IFa%(I%)=0ENDPROC
 2790IF(FN@(G$(I%))="PHONE")AND(T$<>"NOKILL")PROC@("You cannot kill the Phone task, once started.","Please select a task and press the appropriate Function key",1):ENDPROC
 2800IFI%=n%n%=0
 2810IFT$="NOKILL"GOTOd
 2820X%=@COKILL%:Y%=a%(I%):CALLs0%:IF@C%PROC@("Cannot kill "+G$(I%),"",1):ENDPROC
 2840.d:X%=@CODEL%:Y%=a%(I%):CALLs0%:a%(I%)=0:Y%=e%(I%):IFY%>0CALLh1%:IF@C%PROC@("Cannot clear context for "+G$(I%),"",1):e%(I%)=0
 2890Y%=f%(I%):IFY%>0CALLt0%:IF@C%PROC@("Cannot clear screen for "+G$(I%),"",1):f%(I%)=0
 2910h%(I%)=FALSE:ENDPROC
 2940DEFPROCB(N%):IFN%=0PROC0:ENDPROC
 2960IFa%(N%)>0PROCE(N%,W)ELSEPROCE(N%,Q)
 2980ENDPROC
 2990DEFPROCE(N%,J):LOCAL_2%,`2%,S,i1%,a2%,u0%,b2%,i%:IFJELSEIF(a%(N%)=0)PROC@("Task "+G$(N%)+" has not been started","",1):ENDPROC
 3020CALL_0%:IF@C%PROC@("Unable to save main menu context - please delete unwanted tasks",1):v0%=p%:ENDPROCELSEv0%=@Y%
 3030j1%=TRUE:OSCLI("FX 229,1"):i%=FALSE:REPEAT:IFJIFNOTFN6 i%=TRUE:GOTOM
 3090IFJIFFN5(N%)>0i%=TRUE:GOTOM
 3100IFNOTJIFNOTFN7 i%=TRUE:GOTOM
 3110PROCf:IF_2%>0PROCL:PROC0:PROC@($S,"",1):PROCM("NOKILL"):PROCC:PROC9:i%=TRUE:GOTOM
 3130PROCg
 3140.M:UNTILi%:PROCO:OSCLI("FX 229,0"):ENDPROC
 3200DEFPROCf:PROC4:IF(FN@(G$(N%))<>"PHONE")AND(FN@(G$(N%))<>"CALCULATOR")AND(FN@(G$(N%))<>"CONFIGURE")n%=N%
 3240IFFN@(G$(N%))="CALCULATOR"k%=N%
 3250X%=@ENINIT%:Y%=a%(N%):$N=STR$~u%(N%):IFr%(N%)<>0$N=$N+" "+STR$~r%(N%)
 3270A%=N:PROC2:IFs%(N%)=1CALLk1%ELSECALLm1%
 3300s%(N%)=@Y%:_2%=@C%:u0%=@X%:`2%=@A%:S=(@BHA%):PROC4:ENDPROC
 3350DEFPROCg:PROCL:CALL_0%:a2%=@C%:b2%=@Y%:CALLw0%:i1%=@C%:IFi1%=0f%(N%)=@Y%
 3410IFi1%>0f%(N%)=0:PROC0:PROC@("No room to save screen for task "+G$(N%)+".","You may resume the task, but the task's screen will not be restored.",1)ELSEPROCh
 3420i%=TRUE:IFu0%=@RCKEY%IF`2%=@ECHELP%PROC2:i%=FN8:J=W
 3450ENDPROC
 3460DEFPROCh:IFa2%>0PROC0:PROC@("Task "+G$(N%),"No room to save context",1):e%(N%)=0ELSEe%(N%)=b2%
 3480IFu0%=@RCER%PROC0:PROC@($S,"",1):ENDPROC
 3490IFu0%<>@RCKEY%PROC0
 3510ENDPROC
 3530DEFPROCO:IFj1%ELSEENDPROC
 3550IFv0%=0Y%=p%ELSEY%=v0%
 3560CALLe0%:j1%=FALSE:ENDPROC
 3600DEFPROC4:LOCALA%:A%=126:CALL@OSB%:A%=124:CALL@OSB%:OSCLI("FX 200"):CALLn1%:ENDPROC
 3680DEFFN6:IFFN2ELSE=FALSE
 3700IF(p%=0)GOTOe
 3710Y%=p%:CALLe0%:CALL_0%:OSCLI("FX 225,1"):p%=@Y%:IF@C%p%=0
 3770.e:CLS:s%(N%)=0:=TRUE
 3820DEFFN7:IF(e%(N%)=0)PROC0:PROC@("There is no context to restore for "+G$(N%),"",1):GOTOO
 3840Y%=e%(N%):CALLe0%:IF@C%PROC0:PROC@("Cannot restore context for "+G$(N%),"",1):GOTOO
 3870IF(f%(N%)=0)PROC0:PROC@("There is no screen to restore for "+G$(N%),"",1):GOTOO
 3880Y%=f%(N%):CALLo1%:IF@C%PROC0:PROC@("Cannot restore screen for "+G$(N%),"",1):GOTOO
 3910.m:f%(N%)=0:e%(N%)=0:=FN2
 3960.O:=FALSE
 3980DEFFN2:p1%=0:CALLw0%:IF@C%PROC0:PROC@("There is not enough memory available to start this task.","To free some memory please KILL unwanted tasks",1):=FALSE
 4020p1%=@Y%:=TRUE
 4050DEFPROCL:Y%=p1%:CALLt0%:IF@C%PROC0:PROC@("Unable to free phantom task screen","",1)
 4100ENDPROC
 4110DEFPROCY:CALL_0%:IF@C%PROC@("Cannot save default context","",0)
 4140p%=@Y%:ENDPROC
 4180DEFFN8:LOCALm%
 4200.f:PROC2:X%=@COHELP%:Y%=a%(_%):CALLs0%:IF@C%PROCi:PROC4:=FALSE
 4260PROC4:m%=INKEY(0):IFm%=@ECHELP%GOTOf
 4290IFm%=-1THEN=FALSE
 4300PROCQ(m%):OSCLI("FX 138,0,"+STR$(m%)):=TRUE
 4340DEFPROCi:Y%=p%:CALLe0%:CALL_0%:OSCLI("FX 229, 1"):IF@C%p%=0ELSEp%=@Y%
 4390OSCLI("FX 225 128"):OSCLI("FX 226 128"):OSCLI("FX 227 160"):a0%=0:q1%=FALSE:PROC@HELP:q1%=TRUE:ENDPROC
10000DEFPROC`:IFA%=128+14_%=_%+1:IF_%>b%_%=1
10020IFA%=128+15_%=_%-1:IF_%<1_%=b%
10030PROCC:ENDPROC
10060DEFPROCC:IFFN@(G$(_%))="PHONE"PROCA(j%ANDNOT2):ENDPROC
10080IFh%(_%)PROCA(j%OR2)ELSEPROCA(j%ANDNOT2)
10100ENDPROC
10110DEFPROC0:ONERRORGOTOc1%
10130PROCO:PROC2:IF_%=0_%=1
10160PROCJ:PROC9:VDU26:PROC8:IFFN0(-1,0,0)
10220ENDPROC
10230DEFPROC9:LOCALd%:FORd%=1TOb%:PROCR(d%):NEXT:IFb%=c%GOTOg
10290FORd%=b%+1TOc%:PROCj(d%):NEXT
10320.g:j0%=0:PROCK:ENDPROC
10360DEFPROCK:VDU26:IFj0%<>_%ANDj0%<>0PROCR(j0%)
10390PROC1(1):PRINTTAB(f0%,g0%-1+_%);" ";G$(_%);" ":IFh%(_%)PRINTTAB(v2%,g0%-1+_%);" ";f$;" "
10420PROC1(0):j0%=_%:ENDPROC
10460DEFPROCR(d%):LOCALY$,g$,c2%:IFh%(d%)Y$=f$ELSEY$=""
10490c2%=LEN(" "+G$(d%)+Y$+" "):g$=" "+G$(d%)+STRING$(x0%-f0%-c2%," ")+Y$+" ":PRINTTAB(f0%,g0%-1+d%);g$:ENDPROC
10540DEFPROCj(d%):PRINTTAB(f0%,g0%-1+d%);STRING$(x0%-f0%," "):ENDPROC
10580DEFPROC8:PROC3(0,"Select the Task you want with the cursor keys, and press the","appropriate Function key.","Press HELP for further information"):ENDPROC
10620DEFPROCJ:PROCk:CLS:OSCLI("FX 4 2"):OSCLI("FX 12 0"):OSCLI("FX 12 3"):OSCLI("FX 225 128"):OSCLI("FX 226 128"):OSCLI("FX 227 160"):PROCm:g3%=j%:PROC1(1):PROCP:PROCA(511):PROCC:PROC5(0):ENDPROC
10780DEFPROCm:PROC5(0):PROCn:IFFN0(-1,0,0)
10820PROC6(0,79,23,27):PROC6(f0%-1,x0%+1,g0%-1,w2%+1):PROCS(1,0):ENDPROC
10870DEFPROCk:COLOUR1:COLOUR128:ENDPROC
10930DEFPROCn:LOCALa%,N$,R$,x2%:x2%=3:a%=OPENIN"ECONET:":IFa%=0ENDPROC
10990BPUT#(a%+1),"?N":N$=MID$(GET$#(a%+1),2):BPUT#(a%+1),"?S":R$=MID$(GET$#(a%+1),2):IFR$="0"GOTOh
11040IFN$="0"N$="   "
11050N$=RIGHT$("   "+N$,3):R$=RIGHT$("000"+R$,3):PROC6(y0%-1,y2%+1,z0%-1,z2%+1):PRINTTAB(y0%-3,z0%-2)"Econet Station":PRINTTAB(y0%,z0%);N$;:IFN$="   "PRINT" "+R$ELSEPRINT".";R$;
11140.h:CLOSE#a%:ENDPROC
11180DEFPROCS(d2%,e2%):LOCALk0%,r1%,K$,s1%:k0%=OPENIN"MAIN:":IFk0%=0ENDPROC
11220r1%=k0%+1:PRINTTAB(d2%,e2%);:BPUT#r1%,"Y":PRINTTAB(d2%,e2%+1);:BPUT#r1%,"Z":s1%=FALSE:REPEAT:K$=GET$#k0%:IF@ERC%s1%=TRUE:GOTOX
11310K$=LEFT$(K$,p0%):K$=LEFT$(K$,INSTR(K$+" "," ")-1):IFK$=""GOTOX
11340$G=K$:PROCd
11360.X:UNTILs1%:CLOSE#k0%:ENDPROC
11410DEFPROCb:LOCALm%,i%:OSCLI("*FX 4"):PROC5(1):VDU28,1,26,78,24,12:PRINT"Please enter your username and password, or just press RETURN ("+p$+") to logoff":PRINT"User name :";:m%=GET
11490IFm%=13OSCLI("BYE"):PROC3(0,"You are now logged off of the local area network","","Press the SPACE BAR to continue"):GOTOi
11510PROCQ(m%):i%=FALSE:REPEAT:VDU28,1,26,78,24,12:PRINTTAB(0,1);:OSCLI("LOGON"):IF@ERC%PROC@($@ERMSG%,"Press ESCAPE to return to the menu",2)ELSEi%=TRUE
11590PROC4:UNTILi%:PROC3(0,"You are now logged on to the local area network","","Press the SPACE BAR to continue")
11620.i:PROC5(0):PROC2:OSCLI("FX 4 2"):REPEAT:A%=GET:UNTIL(A%=ASC" ")OR(A%=@ECSTOP%)OR(A%=@ECPHON%)OR(A%=@ECCOMP%)OR(A%=@ECCALC%):PROC4:PROC8:PROCS(1,0):PROC9:ENDPROC
11750DEFPROCo:LOCALI%:RESTOREj:FORI%=1TO12:READ_1%(I%):NEXT:ENDPROC
11830.j
11840DATA 31,28,31,30,31,30,31,31,30,31,30,31
11850DEFPROCc:LOCALU$,h$:h$="Enter the ":PROC5(1):`1%=FN1("year",1900,2010):IF`1%MOD4=0AND((`1%MOD100<>0)OR(`1%MOD400=0))_1%(2)=29ELSE_1%(2)=28
11900f2%=FN1("month",1,12):_3%=FN1("date",1,_1%(f2%)):`3%=FN1("hour",0,23):a3%=FN1("minute",0,59):PROC5(0):VDU26:TIME$=STR$_3%+"/"+STR$f2%+"/"+STR$`1%+" "+STR$`3%+":"+STR$a3%:PROC8:ENDPROC
12000DEFFN1(q$,g2%,h2%):LOCAL`$:`$=h$+q$+" ("+STR$(g2%)+"-"+STR$(h2%)+")":REPEAT:PROC3(0,"","",""):PROC3(0,"Press ESCAPE to return to menu or -",`$,""):U$=FN9((LEN`$)+5,25,10):A%=VAL(LEFT$(U$,10)):UNTIL(A%>=g2%)AND(A%<=h2%):=A%
12110DEFFNA(N%):LOCALP%:DIMP%-1:IF((P%EOR(P%+N%+1))AND&FF0000)DIMP%&FFFF-(P%AND&FFFF)
12150=N%
12160DEFPROC@(i$,j$,i2%):PROC2:IFi2%=0PROC3(1,i$,j$,"Please reboot"):OSCLI("FX 4"):VDU26:PROC5(1):PROC1(0):REPEATUNTILFALSE
12190PROC3(1,i$,j$,"Press the SPACE BAR to continue"):REPEATA%=GET:UNTIL(A%=ASC" ")OR(A%=@ECSTOP%)OR(A%=@ECPHON%)OR(A%=@ECCOMP%)OR(A%=@ECCALC%):IFi2%=2ELSEPROC8
12230ENDPROC
12240DEFPROCQ(m%):OSCLI("FX 138,0, "+STR$(m%)):ENDPROC
12280DEFPROC5(N%):IFN%=0VDU23,1|ELSEVDU23,1,1|
12310ENDPROC
12320DEFFN@(U$):LOCALa$,C%,I%:FORI%=1TOLENU$:C%=ASCMID$(U$,I%,1):IFC%>=ASC"a"IFC%<=ASC"z"C%=C%AND&DF
12370a$=a$+CHR$C%:NEXT:=a$
12400DEFFN9(X%,Y%,W%):LOCALJ$,C%,J%:J$="":J%=0:VDU23,1,1|:REPEAT:C%=FN0(100,X%+J%,Y%):IFC%<>127ELSEIFJ%=0UNTIL0ELSEJ$=LEFT$(J$,(LENJ$)-1):J%=J%-1:PRINTTAB(X%+J%,Y%);" ":UNTIL0
12470IFC%=13UNTILTRUE:VDU23,1,0|:=J$
12480IFC%=21J%=0:J$="":PRINTTAB(X%,Y%);SPC(W%):UNTIL0
12490IFC%<32ORC%>127UNTIL0
12500IFJ%=W%VDU7:UNTIL0
12510J$=J$+CHR$(C%):PRINTTAB(X%+J%,Y%);CHR$C%;:IFJ%=0PRINT;SPC(W%-1)
12540J%=J%+1:UNTIL0
12560DEFPROCp:y1%=FALSE:c%=19:b%=0:p%=0:v0%=0:j1%=FALSE:w%=129:t1%=161:u2%=&7E:z1%=0:Q=TRUE:W=FALSE:Y=TRUE:Z=FALSE:m2%=w%:o2%=w%+1:h3%=w%+2:i3%=w%+3:p2%=w%+4:q2%=w%+5:r2%=w%+6:j3%=w%+7:n2%=t1%:k3%=t1%+4:s2%=t1%+6:DIM_1%(12):DIMb3%FNA(300):DIMN 256:DIMh%(c%):DIMG$(c%):DIMa%(c%):DIMr%(c%):DIMu%(c%)
12810DIMo%(c%):DIMz%(c%):DIMe%(c%):DIMf%(c%):DIMs%(c%):p1%=0:p0%=20:DIMG p0%:n%=0:i0%=0:y%=0:k%=0:m3%=0:j0%=0:_%=1:f$="Active":S$="":X$="":DIMG0$(8):DIMM$(c%):o$=CHR$10+CHR$13:p$=CHR$&88+CHR$&A6+CHR$&AC:`0%=FALSE:f0%=1:x0%=29:g0%=3:w2%=g0%+c%-1:v2%=x0%-8:y0%=67:y2%=y0%+6:z0%=6:z2%=z0%:PROCo
13140G$(0)="":r$="Menu V1.00":j%=0:a0%=0:x%=0:ENDPROC
13210DEFPROCq:FORPj2%=0TO2STEP2:P%=b3%:[OPTPj2%:WRD&30
13260._0%:COP:EQUB@OPSCX%:RTL
13280.e0%:COP:EQUB@OPRCX%:RTL
13300.w0%:COP:EQUB@OPSSC%:RTL
13320.o1%:COP:EQUB@OPRSC%:RTL
13340.n1%:LDA#@EVPRE%:COP:EQUB@OPAEV%:RTL
13360.t0%:COP:EQUB@OPFSC%:RTL
13380.h1%:COP:EQUB@OPFCX%:RTL
13400.b0%:RSP#&30:WRD&30:PEA#G/&100:PLB:PLB:PEA#(GAND&FFFF):PLA:LDX#0:LDY#0:COP:EQUB@OPRMI%:RTL
13470.q0%:RSP#&30:WRD&30:PEA#G/&100:PLB:PLB:PEA#(GAND&FFFF):PLA:LDX#0:LDY#2:COP:EQUB@OPRMI%:RTL
13540.u1%:COP:EQUB@OPCMD%:EQUS"TXTDMP":BRK:RTL
13580.v1%:COP:EQUB@OPCMD%:EQUS"SCRDMP":BRK:RTL:WRD&30
13640.k1%:PHX:LDX#1:BRAc3%
13680.m1%:PHX:LDX#0
13710.c3%:PHY:PHA:LDA#229:LDY#0:COP:EQUB@OPOSB%:PLA:PLY:PLX:CLC:JSRL@CCO%:PHP:PHX:PHA:LDX#1:LDY#0:LDA#229:COP:EQUB@OPOSB%:PLA:TXY:PLX:PLP:RTL:]:NEXTPj2%:s0%=@CO%+@WRDAM%+@WRDXY%:k1%=k1%+@WRDAM%+@WRDXY%:m1%=m1%+@WRDAM%+@WRDXY%:n3%=@MM%+@WRDAM%+@WRDXY%
14020_0%=_0%+@WRDAM%+@WRDXY%:e0%=e0%+@WRDAM%+@WRDXY%:w0%=w0%+@WRDAM%+@WRDXY%:o1%=o1%+@WRDAM%+@WRDXY%:n1%=n1%+@WRDAM%+@WRDXY%:t0%=t0%+@WRDAM%+@WRDXY%:h1%=h1%+@WRDAM%+@WRDXY%:b0%=b0%+@WRDAM%+@WRDXY%:q0%=q0%+@WRDAM%+@WRDXY%:u1%=u1%+@WRDAM%+@WRDXY%
14120v1%=v1%+@WRDAM%+@WRDXY%:ENDPROC
14160DEFPROCr:DIMa1%(1,1):DIMm0%(1):m0%(0)=0:m0%(1)=1
14230.a1%(0,0)
14240DATA"Please refer to your User Guide"
14250DATA"****"
14260.a1%(1,0)
14270DATA"To select a task           Use the (‹) and (Š) keys.      "
14280DATA" "
14290DATA"To start a task or resume  Select it and press F1 (START)"
14300DATA"a task already active"
14310DATA" "
14320DATA"To delete a task           Select it and press F2 (KILL)"
14330DATA"                                                        "
14340DATA"To set the time            Press F6 (TIME). Type in the information "
14350DATA"                           requested pressing ( ˆ¦¬ ) to enter each"
14360DATA"                           reply."
14370DATA" "
14380DATA"To log on                  (If you are connected to a local area network)"
14390DATA"                           Press F5 (LOGON). Enter your Username and password"
14400DATA" "
14410DATA"To log off                 Press F5 and then press RETURN ( ˆ¦¬) "
14420DATA"****"
14430.a1%(1,1)
14440DATA" "
14450DATA"To create another          Select task to be duplicated and "
14460DATA"copy of a task             press CTRL F1 (NEW TASK)         "
14470DATA" "
14480DATA"                           The extra task will be removed from"
14490DATA"                           the task list when F2 (KILL) is"
14500DATA"                           pressed"
14510DATA"****"
14530ENDPROC
14540DEFPROCs:DIMk2%(0)
14560.k2%(0)
14570DATA"Select the Task you want with the cursor keys, and press the"
14580DATA"appropriate Function key."
14590DATA"Press HELP for further information"
14610ENDPROC
14620DEFPROCt:k$="Press SPACE to continue":ENDPROC
14660DEFPROCu:DIMH$(7):H$(0)=" Start  ":H$(1)="  Kill  ":H$(2)="":H$(3)="":H$(4)=" Logon  ":H$(5)="  Time  ":H$(6)=" Print  ":H$(7)="":ENDPROC
25000DEFPROCv:MODE0:VDU19,0,4|19,1,7|:PRINTTAB(1);:PROC1(1):PRINT"Communicator ";r$;" ";s$;" Acorn Computers Ltd 1986":PROC1(0):IFFN0(-1,0,0)
25070PROC6(0,79,1,22):PROC6(0,79,23,27):ENDPROC
25100DEFPROCA(q%):LOCALI%:PROC1(1):IFq%<0q%=j%ANDq%
25140IFq%AND256ANDNOTj%PROCP
25150t%=1:FORI%=0TO7:IF(q%ANDt%)<>(j%ANDt%)PROCT(I%,q%ANDt%)
25180t%=2*t%:NEXT:PROC1(0):j%=q%:ENDPROC
25230DEFPROCT(I%,d3%):IFH$(I%)=""ENDPROC
25250IFd3%PRINTTAB(g%(I%)+3,29);"F";I%+1;TAB(g%(I%),30);H$(I%);ELSEVDU5:MOVE16*g%(I%),92:PRINTm$;:PLOT0,-128,-32:PRINTm$;:VDU4
25260ENDPROC
25270DEFPROCP:LOCALI%:PROCU:j%=256:t%=1:FORI%=0TO7:IFH$(I%)<>"":PRINTTAB(g%(I%)+3,29);"F";I%+1;TAB(g%(I%),30);H$(I%);:j%=j%+t%
25340t%=t%*2:NEXT:ENDPROC
25370DEFPROCU:PROC6(1,37,28,31):PROC7(10,28,31):PROC7(19,28,31):PROC7(28,28,31):PROC6(42,78,28,31):PROC7(51,28,31):PROC7(60,28,31):PROC7(69,28,31):ENDPROC
25470DEFPROC6(L%,R%,T%,B%):LOCALI%:VDU28,L%,B%,R%,T%,12,26:PRINTTAB(L%,T%);t$;STRING$(R%-L%-1,n$);u$;:FORI%=T%+1TOB%-1:PRINTTAB(L%,I%);b$;TAB(R%,I%);b$;:NEXT:PRINTTAB(L%,B%);v$;STRING$(R%-L%-1,n$);w$;:ENDPROC
25560DEFPROC7(w1%,T%,B%):LOCALI%:PRINTTAB(w1%,T%);x$;:FORI%=T%+1TOB%-1:PRINTTAB(w1%,I%);b$;:NEXT:PRINTTAB(w1%,B%);y$;:ENDPROC
25640DEFFN0(A%,X%,Y%):LOCALC%,J$:REPEAT:IFA%<0C%=-1ELSEPRINTTAB(X%,Y%);:C%=INKEY(A%)
25680IFC%<0J$=LEFT$(TIME$(3)+"  ",21):PRINTTAB(58,0);:PROC1(1):PRINT;J$;:PROC1(0):UNTILA%<0ELSEUNTILTRUE
25690PRINTTAB(X%,Y%);:=C%
25710DEFPROCy(e3%):RESTOREo3%(e3%):READn0%,O$,V$,W$:PROC3(n0%,O$,V$,W$+k$):PROC2:REPEATUNTILFN0(100,0,0)=32:ENDPROC
25780DEFPROCV:IFx%<0PROCw:ENDPROC
25800RESTOREk2%(x%):READO$,V$,W$:PROC3(0,O$,V$,W$):ENDPROC
25840DEFPROCw:IFx%=-1PROC3(0,"","",""):ENDPROC
25860RESTOREb1%(-(x%+2)):READO$:PROC3(0,O$,"Press RETURN to leave help before using function keys","For more details refer to the User guide"):ENDPROC
25900DEFPROC3(n0%,O$,V$,W$):VDU28,1,26,78,24:PROC1(n0%):VDU12,26:PRINTTAB(3,24);O$;TAB(3,25);V$;TAB(3,26);W$:PROC1(0):ENDPROC
25970DEFPROC1(n0%):IFn0%=0COLOUR1:COLOUR128ELSECOLOUR0:COLOUR129
25990ENDPROC
26000DEFPROC2:REPEAT:UNTILINKEY(0)=-1:ENDPROC
26040DEFPROCD(f3%):IFf3%CALLv1%ELSECALLu1%
26060IF@C%PROC3(1,"Print failed because :",$@BHA%,k$):REPEATUNTILFN0(100,0,0)=32:PROCV
26070ENDPROC
26080DEFPROCz:ENDPROC
26090DEFPROC@HELP:x1%=x1%:IFx1%ELSEENDPROC
26120LOCALo0%,q%,x%:PROCv:PROC1(1):IFq1%q%=j%:PROCP:PROCA(q%)ELSEPROCU:PROCT(6,TRUE):PROC1(0)
26160h0%=0:PROCW:PROC2:REPEAT:o0%=FN0(100,0,0):IFo0%=32h0%=h0%+1:PROCW:UNTILFALSE
26220IFo0%=135PROCD(FALSE):UNTILFALSE
26230IFo0%=167PROCD(TRUE):UNTILFALSE
26240UNTILo0%=13:ENDPROC
26260DEFPROCW:LOCALc$:c$="":VDU28,1,21,78,2,12:IFh0%>m0%(a0%)h0%=0
26300RESTOREa1%(a0%,h0%):READd$:REPEAT:PRINTc$;d$;:c$=CHR$13+CHR$10:READd$:UNTILd$="****":IFm0%(a0%)=0x%=-2ELSEIFh0%<m0%(a0%)x%=-3ELSEx%=-4
26380PROCV:VDU26:ENDPROC
26410DEFPROCX:t$=CHR$&B0:u$=CHR$&B1:v$=CHR$&B2:w$=CHR$&B3:n$=CHR$&A6:b$=CHR$&A9:x$=CHR$&A7:y$=CHR$&AE:m$=STRING$(8,CHR$&BF):DIMg%(7):g%(0)=2:g%(1)=11:g%(2)=20:g%(3)=29:g%(4)=43:g%(5)=52:g%(6)=61:g%(7)=70:q1%=TRUE:H0$=CHR$136:J0$=CHR$137:K0$=CHR$138:M0$=CHR$139:s$=CHR$135:PROCp:PROCr:PROCs:PROCx:PROCt:PROCu:PROCq:x1%=TRUE:ENDPROC
26630DEFPROCx:DIMb1%(2)
26650.b1%(0)
26660DATA""
26670.b1%(1)
26680DATA"Press SPACE for more information."
26690.b1%(2)
26700DATA"Press SPACE to return to start of help information."
26710ENDPROC
