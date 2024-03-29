
       	sr = 48000
	ksmps = 256
	nchnls = 4

      gkmute1 init 1
      gkmute2 init 1
      gkmute3 init 1
      gkmute4 init 1

;zakinit 20,20

;massign 1,1

;turnon 1,0
;maxalloc 1,1


FLcolor	180,200,199
FLpanel 	"Mixer",200,300
    istarttim = 0
    idropi = 666
    idur = 1
    ;ibox0  FLbox  "FM Synth (abram)", 1, 6, 12, 300, 20, 0, 0
    ;FLsetFont   7, ibox0
                
    gkamp1,    iknob1 FLknob  "AMP1", 0.0001, 8, -1,1, -1, 50, 0,0
    gkamp2,    iknob2 FLknob  "AMP2", 0.0001, 8, -1,1, -1, 50, 50,0
    gkamp3,    iknob3 FLknob  "AMP3", 0.0001, 8, -1,1, -1, 50, 100,0
    gkamp4,    iknob4 FLknob  "AMP4", 0.0001, 8, -1,1, -1, 50, 150,0
    ;                                      ionioffitype
    gkmute1,    gimute1 FLbutton  "Mute1", 1, 0, 22, 50, 50, 0  ,100, -1
    gkmute2,    gimute2 FLbutton  "Mute2", 1, 0, 22, 50, 50, 50 ,100, -1
    gkmute3,    gimute3 FLbutton  "Mute3", 1, 0, 22, 50, 50, 100,100, -1
    gkmute4,    gimute4 FLbutton  "Mute4", 1, 0, 22, 50, 50, 150,100, -1
    
    gkdrop1,    ibutton4 FLbutton  "Drop 12->34", 0, 0, 1, 100, 50, 0,   200, 0, idropi, istarttim, idur, 0
    gkdrop2,    ibutton4 FLbutton  "Drop 34->12", 0, 0, 1, 100, 50, 100, 200, 0, idropi, istarttim, idur, 1
    
    
    
    FLsetVal_i   1.0, iknob1
    FLsetVal_i   1.0, iknob2
    FLsetVal_i   1.0, iknob3
    FLsetVal_i   1.0, iknob4
    
    FLsetVal_i   1.0, gimute1
    FLsetVal_i   1.0, gimute2
    FLsetVal_i   1.0, gimute3
    FLsetVal_i   1.0, gimute4
    
    
FLpanel_end	;***** end of container

FLrun		;***** runs the widget thread 


      gkamp1 init 1
      gkamp2 init 1
      gkamp3 init 1
      gkamp4 init 1

      gkmute1 init 1
      gkmute2 init 1
      gkmute3 init 1
      gkmute4 init 1



; the mixer
        instr 1
	a1,a2,a3,a4 inq
	aa1 = a1 * gkamp1 * gkmute1
	aa2 = a2 * gkamp2 * gkmute2
	aa3 = a3 * gkamp3 * gkmute3
        aa4 = a4 * gkamp4 * gkmute4
        aa1 clip aa1, 0, 32000
        aa1 dcblock2 aa1
        aa2 clip aa2, 0, 32000
        aa2 dcblock2 aa2
        aa3 clip aa3, 0, 32000
        aa3 dcblock2 aa3
        aa4 clip aa4, 0, 32000
        aa4 dcblock2 aa4
        outq aa1,aa2,aa3,aa4
        endin   

; the dropper
; the dropper will save state of p4
; and then set p4 (the amp) to the envelope * p4
; and then set p3 (the amp) to the (1-envelope) * p3
; p3 - from 
; p4 - to
; we'll just do 1&2 to 3&4
;
        instr 666
        idur = p3
        idir = p4 ; direction 0  
        print idur, idir
        ; get the envelope
        ;kenv oscili 1, 1/idur, 666
        ;kenv expseg   0.0001, idur, 1.0001
        ;kenv = kenv - 0.0001
        kenv linseg 0, idur, 1
        krenv linseg 1, idur, 0
        gkmute1 = ((idir>0)?kenv:krenv)
        gkmute2 = ((idir>0)?kenv:krenv)
        gkmute3 = ((idir>0)?krenv:kenv)
        gkmute4 = ((idir>0)?krenv:kenv)
        ;FLsetVal 1,gkmute1,gimute1
        ;FLsetVal 1,gkmute2,gimute2
        ;FLsetVal 1,gkmute3,gimute3
        ;FLsetVal 1,gkmute4,gimute4
        endin
