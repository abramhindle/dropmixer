
       	sr = 44100
	kr = 441
	ksmps = 100
	nchnls = 4

      gkindex init 1
      gkmodkn init 1
      gkcar init 1
      gkmod init 1


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
                
    gkamp1,    iknob1 FLknob  "AMP1", 0.0001, 2, -1,1, -1, 50, 0,0
    gkamp2,    iknob2 FLknob  "AMP2", 0.0001, 2, -1,1, -1, 50, 50,0
    gkamp3,    iknob3 FLknob  "AMP3", 0.0001, 2, -1,1, -1, 50, 100,0
    gkamp4,    iknob4 FLknob  "AMP4", 0.0001, 2, -1,1, -1, 50, 150,0
    ;                                      ionioffitype
    gkmute1,    ibutton1 FLbutton  "Mute1", 1, 0, 22, 50, 50, 0  ,100, -1
    gkmute2,    ibutton2 FLbutton  "Mute2", 1, 0, 22, 50, 50, 50 ,100, -1
    gkmute3,    ibutton3 FLbutton  "Mute3", 1, 0, 22, 50, 50, 100,100, -1
    gkmute4,    ibutton4 FLbutton  "Mute4", 1, 0, 22, 50, 50, 150,100, -1
    
    gkdrop1,    ibutton4 FLbutton  "Drop 12->34", 0, 0, 1, 100, 50, 0,   200, 0, idropi, istarttim, idur, 0
    gkdrop2,    ibutton4 FLbutton  "Drop 34->12", 0, 0, 1, 100, 50, 100, 200, 0, idropi, istarttim, idur, 1
    
    
    
    FLsetVal_i   1.0, iknob1
    FLsetVal_i   1.0, iknob2
    FLsetVal_i   1.0, iknob3
    FLsetVal_i   1.0, iknob4
    
    FLsetVal_i   1.0, ibutton1
    FLsetVal_i   1.0, ibutton2
    FLsetVal_i   1.0, ibutton3
    FLsetVal_i   1.0, ibutton4
    
    
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
        ; initial amp values
        itoamp1  = i(gkamp1)
        itoamp2  = i(gkamp2)
        itoamp3  = i(gkamp3)
        itoamp4  = i(gkamp4)
        ; no muting during drop
        gkmute1 = 1
        gkmute2 = 1
        gkmute3 = 1
        gkmute4 = 1
        ; get the envelope
        kenv oscili 1, 1/idur, 666
        gkamp1 = itoamp1*((idir>0)?kenv:(1-kenv))
        gkamp2 = itoamp2*((idir>0)?kenv:(1-kenv))
        gkamp3 = itoamp3*((idir>0)?(1-kenv):kenv)
        gkamp4 = itoamp4*((idir>0)?(1-kenv):kenv)
        endin
