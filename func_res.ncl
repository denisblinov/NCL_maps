
; TODO:
; - for function get_wks_png add format svg

undef("init_gsn_res")
function init_gsn_res(res)
begin;;
    ; setup gsn resources
    ; res = True
    res@gsnDraw                = False
    res@gsnFrame               = False
    res@gsnMaximize            = True
    res@gsnLeftString   = ""
    res@gsnRightString  = ""
    ; res@gsnCenterString = ""
    ; res@gsnPaperOrientation = "auto"
    ; res@gsnPaperOrientation = "Horizontal"
    ; res@gsnPaperOrientation = "Vertical"

    return res
end;;

undef("init_gsn_res0")
function init_gsn_res0()
begin;;
    ; setup gsn resources
    res = True
    res@gsnDraw                = False
    res@gsnFrame               = False
    res@gsnMaximize            = True
    res@gsnLeftString   = ""
    res@gsnRightString  = ""
    ; res@gsnCenterString = ""
    ; res@gsnPaperOrientation = "auto"
    ; res@gsnPaperOrientation = "Horizontal"
    ; res@gsnPaperOrientation = "Vertical"

    return res
end;;

undef("init_gsn_res_noMap")
function init_gsn_res_noMap(res)
begin;;
    ; setup gsn resources
    ; res = True
    res@gsnDraw                = False
    res@gsnFrame               = False
    ; res@gsnMaximize            = True
    ; res@gsnLeftString   = ""
    ; res@gsnRightString  = ""
    ; res@gsnCenterString = ""
    ; res@gsnPaperOrientation = "auto"
    ; res@gsnPaperOrientation = "Horizontal"
    ; res@gsnPaperOrientation = "Vertical"

    return res
end;;

undef("get_labelbar")
function get_labelbar(res,pos)
begin;;

    if( res@lbOrientation .eq. "Vertical" .and. pos .eq. "Center" )then;;
        ; res@lbTitleOn        = False
        res@lbTitlePosition    = "Left"
        res@lbTitleAngleF      = 90
        res@lbTitleDirection   = "Across"
        res@pmLabelBarWidthF   = 0.05
        res@lbTitleFontHeightF = 0.012 ; instead 0.025
        res@lbLabelFontHeightF = 0.010 ; instead 0.020
        res@pmLabelBarOrthogonalPosF = 0.01
        if( isatt(res,"pmLabelBarHeightF") )then
            res@pmLabelBarHeightF = res@pmLabelBarHeightF
        else
            res@pmLabelBarHeightF  = 0.65
            ; res@pmLabelBarHeightF  = 0.58
        end if

    else if( res@lbOrientation .eq. "Vertical" .and. pos .eq. "1from2" )then;;
        ; res@pmLabelBarOrthogonalPosF = -1.35     ; Move labelbar to the left side of plot
        ; res@pmLabelBarOrthogonalPosF = 0.015
        res@pmLabelBarOrthogonalPosF = 0.020
        ; res@pmLabelBarParallelPosF = 0.85
        ; res@pmLabelBarParallelPosF = 0.80
        res@pmLabelBarParallelPosF = 0.78
        ; res@pmLabelBarDisplayMode = "Always"
        ; res@lbLeftMarginF = -0.60
        res@pmLabelBarWidthF  = 0.04
        res@pmLabelBarHeightF = 0.15
        ; res@lbTitleFontHeightF = 0.015 ; instead 0.025
        ; res@lbTitleFontHeightF = 0.012 ; instead 0.025
        res@lbTitleFontHeightF = 0.010 ; instead 0.025
        res@lbLabelFontHeightF = 0.010 ; instead 0.020
        ; res@lbLabelPosition  = "left"    ; Move labels to left side of labelbar
        res@lbTitlePosition  = "Left"
        res@lbTitleAngleF    = 90
        res@lbTitleDirection = "Across"
        ; res@lbJustification = "TopRight"

     else if( res@lbOrientation .eq. "Vertical" .and. pos .eq. "2from2" )then;;
        ; value for this part legend shoud be less then 1 part
        ; res@pmLabelBarParallelPosF   =  0.35
        ; res@pmLabelBarParallelPosF   =  0.25
        res@pmLabelBarParallelPosF   =  0.27
        ; res@pmLabelBarOrthogonalPosF = -0.10 ; cfo
        ; res@pmLabelBarOrthogonalPosF =  0.05
        ; res@pmLabelBarOrthogonalPosF =  0.00 ; ETR; Kerch
        res@pmLabelBarOrthogonalPosF = 0.005
        ; res@pmLabelBarSide = "Right"
        ; res@pmLabelBarWidthF   = 0.05
        res@pmLabelBarWidthF   = 0.035
        res@pmLabelBarHeightF  = 0.20
        ; res@lbTitleFontHeightF = 0.015 ; instead 0.025
        ; res@lbTitleFontHeightF = 0.010 ; instead 0.025
        res@lbTitleFontHeightF = 0.009 ; instead 0.025
        res@lbLabelFontHeightF = 0.008 ; instead 0.020
        ; res@lbLabelPosition    = "Left"
        ; res@lbTitlePosition    = "Right"
        res@lbTitlePosition    = "Left"
        res@lbTitleAngleF      = 90
        res@lbTitleDirection   = "Across"

    else if( res@lbOrientation .eq. "Vertical" .and. pos .eq. "1from3" )then;;
        res@pmLabelBarOrthogonalPosF = 0.020
        res@pmLabelBarParallelPosF = 0.84
        res@pmLabelBarWidthF  = 0.04
        res@pmLabelBarHeightF = 0.15
        res@lbTitleFontHeightF = 0.010 ; instead 0.025
        res@lbLabelFontHeightF = 0.010 ; instead 0.020
        res@lbTitlePosition  = "Left"
        res@lbTitleAngleF    = 90
        res@lbTitleDirection = "Across"

     else if( res@lbOrientation .eq. "Vertical" .and. pos .eq. "2from3" )then;;
        res@pmLabelBarParallelPosF   =  0.53
        res@pmLabelBarOrthogonalPosF = 0.005
        res@pmLabelBarWidthF   = 0.035
        res@pmLabelBarHeightF  = 0.20
        res@lbTitleFontHeightF = 0.009 ; instead 0.025
        res@lbLabelFontHeightF = 0.008 ; instead 0.020
        res@lbTitlePosition    = "Left"
        res@lbTitleAngleF      = 90
        res@lbTitleDirection   = "Across"

     else if( res@lbOrientation .eq. "Vertical" .and. pos .eq. "3from3" )then;;
        res@pmLabelBarParallelPosF   =  0.19
        res@pmLabelBarOrthogonalPosF = 0.005
        res@pmLabelBarWidthF   = 0.035
        res@pmLabelBarHeightF  = 0.20
        res@lbTitleFontHeightF = 0.009 ; instead 0.025
        res@lbLabelFontHeightF = 0.008 ; instead 0.020
        res@lbTitlePosition    = "Left"
        res@lbTitleAngleF      = 90
        res@lbTitleDirection   = "Across"

    end if;;
    end if;;
    end if;;

    end if;;
    end if;;
    end if;;

    if( res@lbOrientation .eq. "Horizontal" .and. pos .eq. "Center" )then;;
        ; res@pmLabelBarOrthogonalPosF   =  0.15
        res@pmLabelBarOrthogonalPosF   =  0.16
        res@pmLabelBarWidthF  = 0.40
        res@pmLabelBarHeightF = 0.05
        res@lbTitleFontHeightF = 0.009   ; instead 0.025
        res@lbLabelFontHeightF = 0.008   ; instead 0.020
        ; res@lbTitlePosition  = "Right"
        ; res@lbTitleAngleF    = 90
        ; res@lbTitleDirection = "Across"

    else if( res@lbOrientation .eq. "Horizontal" .and. pos .eq. "1from2" )then;;
        res@pmLabelBarOrthogonalPosF =  0.15     ; Move labelbar to the down side of plot
        res@pmLabelBarParallelPosF   =  0.20     ; Move labelbar to the left
        ; res@pmLabelBarDisplayMode = "Always"
        ; res@lbLeftMarginF = -0.60
        res@pmLabelBarWidthF  = 0.20
        res@pmLabelBarHeightF = 0.05
        res@lbTitleFontHeightF = 0.010 ; instead 0.025
        res@lbLabelFontHeightF = 0.010 ; instead 0.020
        ; res@lbLabelPosition  = "left"    ; Move labels to left side of labelbar
        ; res@lbTitlePosition  = "Left"
        ; res@lbTitleAngleF    = 90
        ; res@lbTitleDirection = "Across"
        ; res@lbJustification = "TopRight"

     else if( res@lbOrientation .eq. "Horizontal" .and. pos .eq. "2from2" )then;;
        res@pmLabelBarOrthogonalPosF =  0.15
        res@pmLabelBarParallelPosF   =  0.80
        ; res@pmLabelBarSide = "Bottom"
        ; res@pmLabelBarOrthogonalPosF =  0.05
        ; res@pmLabelBarOrthogonalPosF =  0.00 ; ETR
        res@pmLabelBarWidthF   = 0.20
        res@pmLabelBarHeightF  = 0.05
        res@lbTitleFontHeightF = 0.010 ; instead 0.025
        res@lbLabelFontHeightF = 0.010 ; instead 0.020
        ; res@lbTitlePosition    = "Right"
        ; res@lbTitleAngleF      = 90
        ; res@lbTitleDirection   = "Across"

    else if( res@lbOrientation .eq. "Horizontal" .and. pos .eq. "1from3" )then;;
        res@pmLabelBarOrthogonalPosF =  0.09     ; Move labelbar to the down side of plot
        res@pmLabelBarParallelPosF   =  0.17     ; Move labelbar to the left
        res@pmLabelBarWidthF  = 0.18
        res@pmLabelBarHeightF = 0.035
        res@lbTitleFontHeightF = 0.008 ; instead 0.025
        res@lbLabelFontHeightF = 0.007 ; instead 0.020

     else if( res@lbOrientation .eq. "Horizontal" .and. pos .eq. "2from3" )then;;
        res@pmLabelBarOrthogonalPosF =  0.10
        res@pmLabelBarParallelPosF   =  0.52
        res@pmLabelBarWidthF   = 0.18
        res@pmLabelBarHeightF  = 0.05
        res@lbTitleFontHeightF = 0.008 ; instead 0.025
        res@lbLabelFontHeightF = 0.007 ; instead 0.020

     else if( res@lbOrientation .eq. "Horizontal" .and. pos .eq. "3from3" )then;;
        res@pmLabelBarOrthogonalPosF =  0.10
        res@pmLabelBarParallelPosF   =  0.84
        res@pmLabelBarWidthF   = 0.18
        res@pmLabelBarHeightF  = 0.05
        res@lbTitleFontHeightF = 0.008 ; instead 0.025
        res@lbLabelFontHeightF = 0.007 ; instead 0.020

    end if;;
    end if;;
    end if;;

    end if;;
    end if;;
    end if;;

    return res

end;;


undef("get_txres")
function get_txres( config )
begin;;

    txres               = True                      ; text mods desired
    txres@txFontHeightF = 0.015                     ; text font height
    txres@txJust        = "CenterLeft"              ; Default is "CenterCenter".
    ; txres@txFont        = "helvetica"
    ; txres@txFontThicknessF        = 1.0 ; default 1.0
    ; txres@txFuncCode    =  ":" ; default ~

    return txres

end;;


undef("get_legend1")
function get_legend1( config, dataset )
begin;;
    ; print( "config: " + config )
    ; print( config )
    ; print( "dataset: " + dataset )
    ; print( dataset )

    grid = False

    if( isatt(dataset,"model") .and. dataset@model .eq. "COSMO" )then;;
        configModel = "COSMO-Ru"
        grid = get_domain( dataset )
        ; grid = get_domain( dataset@domain )
    else if( isatt(dataset,"model") .and. dataset@model .eq. "ICON" )then;;
        configModel = "ICON-Global"
        grid = True
        grid@dkm = 13.2

    else if( isatt(dataset,"typeData") .and. dataset@typeData .eq. "radar_observation" )then;;
        configModel = "Radar obs. for COSMO-Ru2"
        grid = True
        grid@dkm = 2.2

    else if( isatt(dataset,"model") .and. dataset@model .eq. "data_on_regular_grid" )then;;
        ; configModel = "data_on_regular_grid"
        configModel = "ICON-Global"
        grid@dlon = 0.25

    end if;;
    end if;;
    end if;;
    end if;;

    ; if( isatt(grid,"dkm") .and. dataset@typeData .eq. "forecast" )
    if( isatt(grid,"dkm") )then
        discretenessXY = grid@dkm
        discretenessXY@unit = "km"
        discretenessXY@unit_ru = "jl"
    else if( isatt(grid,"dlon") .and. dataset@typeData .eq. "forecast" )then
        discretenessXY = 0.25
        discretenessXY@unit = "degree"
        discretenessXY@unit_ru = "dp."
    end if
    end if

    if( isatt(config,"forecast_time_units") )then;;
        timeunits = config@forecast_time_units
    else if( isatt(config,"units_time") )then
        timeunits = config@units_time
    end if
    end if;;

    ; if ( str_get_cols(timeunits,0,2) .eq. "min" )then
    if ( str_get_cols(config@units_time,0,2) .eq. "min" )then
        fhour = config@looptime / 60
        fmin = config@looptime % 60
        msuff_ru = "lim."
        msuff_en = "min."
    else
        fhour = config@looptime
        fmin  = ""
        msuff_ru = ""
        msuff_en = ""
    end if
    hsuff = get_inflection( fhour, config@langlab )
    ; print( "timeunits: " + timeunits )


    inidate = get_inidate( config@initial_time )
    inidate = str_sub_str( inidate, "Z", " ")
    ; print( "inidate: " + inidate  )
    if( dataset@typeData .eq. "forecast")then
        if( config@langlab .eq. "RU" )then;;
            ; print(grid@dkm)
            ; print(tostring(grid@dkm))
            ; dkm = str_sub_str( tostring(grid@dkm), ".", "," )
            dkm = str_sub_str( discretenessXY, ".", "," )
            ; strleg1 = "COSMO-Ru ~F11~2,2jl~F07~:~F11~ Opndmnh ma " + \
            strleg1 = configModel + " ~F11~"+dkm + discretenessXY@unit_ru+"~F07~:~F11~ Opndmnh ma " + \
                    fhour+" waq"+hsuff + " " + fmin + msuff_ru
            fromTime = " ~F11~nr "
        else 
            ; strleg1 = "COSMO-Ru 2.2km: Forecast on "+config@looptime+" hour"+suff
            ; strleg1 = configModel + " " + grid@dkm +"km: Forecast on "+ \
            strleg1 = configModel + " " + discretenessXY + discretenessXY@unit+": Forecast on "+ \
                    fhour+" hour "+hsuff + " " + fmin + msuff_en
            fromTime = " from "
        end if;;
    else if( dataset@typeData .eq. "initialData" )then
        if( config@langlab .eq. "RU" )then;;
            dkm = str_sub_str( discretenessXY, ".", "," )
            strleg1 = configModel + " ~F11~"+dkm + discretenessXY@unit_ru+"~F07~:~F11~  Amakih"
            fromTime = " ~F11~nr "
        else
            strleg1 = configModel + " " + discretenessXY + discretenessXY@unit+":  Analysis"
            fromTime = " from "
        end if
        end if;;
    end if

    inidate = str_get_cols(inidate,0,3) + "-" + str_get_cols(inidate,4,5) + "-" + \
              str_get_cols(inidate,6,7) +  str_get_cols(inidate,8,20)

    if( isatt(dataset,"typeData") .and. dataset@typeData .eq. "radar_observation" )then;;
        strleg1 = configModel

    else if( isatt(dataset,"typeData") .and. dataset@typeData .eq. "forecast")then;;
        strleg1 = strleg1 + "~C~" + fromTime + "~F07~" + inidate + "(UTC)"

    else if( isatt(dataset,"typeData") .and. dataset@typeData .eq. "initialData")then;;
        inidate = config@idatetime

        ; config@initial_time
        ; print( "get_actDateTime: " + get_actDateTime( config@initial_time, 0, "hour" ) )
        inidate = get_actDateTime( config@initial_time, 0, "hour" )
        inidate = str_sub_str(get_month3RuLabel( inidate ),"#","~")
        ; res@tiMainFuncCode = "#"
        strleg1 = strleg1 + fromTime + "~F07~" + inidate + "(UTC)"
    else
        strleg1 = strleg1
    end if;;
    end if;;
    end if;;

    return strleg1

end;;


undef("get_wks_png")
function get_wks_png( ofilename, size )
local ptype
begin;;

; open graphic port
    ; ptype = "svg"
    ptype = "png"
    ; ptype@wkWidth  = 1024
    ; ptype@wkHeight = 1024
    ; ptype@wkWidth  = 1450
    ; ptype@wkHeight = 1450
    ; ptype@wkWidth  = 1600
    ; ptype@wkHeight = 1600
    ptype@wkWidth  = size
    ptype@wkHeight = size
    
    ; ptype@wkFileName   = "M_1point"
    ; ptype@wkFormat   = "png"
    ; ptype@wkOrientation    = "landscape"
    ; ptype@wkWidthF  = 1024
    ; ptype@wkDeviceLowerX = 0
    ; ptype@wkDeviceLowerY = 1

    ; res@mpShapeMode  = "FreeAspect"
    ; res@mpShapeMode  = "FixedAspectNoFitBB"
    ; res@vpWidthF      = 0.8 ; for pdf, svg
    ; res@vpHeightF     = 0.4

    wks = gsn_open_wks( ptype, ofilename )

    ; increased for data with big grid (cm06ena, sattelite)
    setvalues NhlGetWorkspaceObjectId() 
        "wsMaximumSize": 900000000
        ; "wsMaximumSize": 300000000
    end setvalues

    return( wks )

end;;

undef("handle_image")
procedure handle_image(wksname,depthpicture,cfggrid,size)
begin;;
; png -> png work only with: convert  in.png png8:out.png 

    if( depthpicture .eq. 8 .or. depthpicture .eq. 16 )then
    ; if( True )then
        system("convert -depth " + depthpicture + " " + wksname + ".png " + wksname + ".gif" )
        if ( isatt(cfggrid,"shaveBorder") )then
            cutsize = cfggrid@shaveBorder * size / 1014
            cropEdge = " -shave 0x" + sprintf("%06.0f",cutsize) + " "
            ; print( cropEdge )
            ; -chop 0x100
        else
            cropEdge = ""
        end if
        system("convert "+ cropEdge + wksname + ".gif " + wksname + ".png" )
        ; system("convert "+ cropEdge + wksname + ".png  png8:" + wksname + ".png" )

    else if( depthpicture .eq. 24  .and. isatt(cfggrid,"shaveBorder") )then
        cutsize = cfggrid@shaveBorder * size / 1014
        cropEdge = " -shave 0x" + sprintf("%06.0f",cutsize) + " "
        system("convert "+ cropEdge + wksname + ".png " + wksname + ".png" )

    end if
    end if
    
end;;
