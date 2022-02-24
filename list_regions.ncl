;------------------------------------------------------------------
; Library of geographical regions/areas for plotting.
; Authors: Denis Blinov, denisblinov@ya.ru. 2017 - ...
;------------------------------------------------------------------

load "$lib_NCL/func4grids.ncl"

; res@gsnMajorLatSpacing = 10
; ! res@mpProjection      = "CylindricalEquidistant" give big margin in top of page 
; ! an blank between frame and ticks
; ! should change "CylindricalEquidistant" on "AzimuthalEquidistant"


undef("select_area")
function select_area( area, res, field, lon2d, lat2d )
begin;;

    ;; ; no re-projection (we are on the "native" grid)
    ; res@tfDoNDCOverlay         = True
    ; res@sfXArray               = lon2d
    ; res@sfYArray               = lat2d

    ; get dimensions
    if( str_get_cols(area,0,3) .eq. "icon" )then;;
        npoint = dimsizes(field(:))
    else
        nlat = dimsizes(field(:,0))
        nlon = dimsizes(field(0,:))
        nxny = nlat * nlon

    end if;;

    if( area .eq. "domain" .or. area .eq. "" )then;;
        print( "all domain" )

        ; res@mpLeftCornerLatF  = field@lat2d(0)
        ; res@mpLeftCornerLonF  = field@lon2d(0)
        ; res@mpRightCornerLatF = field@lat2d(nlat-1,0)
        ; res@mpRightCornerLonF = field@lon2d(nlat-1,0)
        res@mpLeftCornerLatF  = lat2d(0,0)
        res@mpLeftCornerLonF  = lon2d(0,0)
        res@mpRightCornerLatF = lat2d(nlat-1,nlon-1)
        res@mpRightCornerLonF = lon2d(nlat-1,nlon-1)

        ; Center of projection, need for unscatted plot
        res@mpCenterLonF           = field@pole_lon + 180.
        res@mpCenterLatF           = 90. - field@pole_lat
        ; res@mpCenterLonF           = lon2d(nlat/2,nlon/2)
        ; res@mpCenterLatF           = lat2d(nlat/2,nlon/2)
        
        ; res@mpLeftCornerLatF       = min( lat2d(:,0) )
        ; res@mpLeftCornerLonF       = min( lon2d(:,0) )
        ; res@mpRightCornerLatF      = max( lat2d(:,0) )
        ; res@mpRightCornerLonF      = max( lon2d(0,:) )

    end if;;

    res@gsnAddCyclic           = False

  ; res@gsnPolar             = "NH"               ; specify the hemisphere
  ; res@mpMinLatF            = 70                 ; specify min lat
  ;---Zoom in on map if desired
  ; res@mpMinLatF         = min(lat)
  ; res@mpMaxLatF         = max(lat)
  ; res@mpMinLonF         = min(lon)
  ; res@mpMaxLonF         = max(lon)
  ; res@mpCenterLonF      = (res@mpMinLonF + res@mpMaxLonF) / 2.

    return(res)
end;;


undef("get_area")
function get_area( area, res )
; local res
begin;;

    res@mpDataBaseVersion = "MediumRes"
    res@mpOceanFillColor  = "lightblue"
    ; res@mpLandFillColor   = "antiquewhite"
    res@mpLandFillColor   = "beige"
    ; res@mpInlandWaterFillColor = "LightBlue"
    res@mpInlandWaterFillColor = "LightSkyBlue"
    res@mpOutlineOn = True

    ; res@mpOceanFillColor       = "azure1"
    ; res@mpInlandWaterFillColor = "azure1"
    ; res@mpOceanFillColor       = "gray80"
    ; res@mpInlandWaterFillColor = "gray80"
    ; res@mpOceanFillColor       = "white"
    ; res@mpInlandWaterFillColor = "white"

    res@pmTickMarkDisplayMode = "Conditional"
    ; res@tmXBLabelFontHeightF = 0.005
    res@tmXBLabelFontHeightF = 0.007
    ; res@tmYLLabelFontHeightF = 0.009
    ; res@tmYLLabelFontHeightF = 0.010
    ; res@tmEqualizeXYSizes = True
    ; res@tmXBMajorLengthF = 0.005
    ; res@tmYLTickSpacingF = 10
    res@tmXBMajorLengthF = 0.005
    ; res@tmXBMajorLengthF = 0.007

    if( area .eq. "MosReg" )then;;

        ; res@mpProjection      = "CylindricalEquidistant"
        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 54.20
        res@mpRightCornerLatF = 57.20
        res@mpLeftCornerLonF  = 35.00
        res@mpRightCornerLonF = 40.70

        res@mpCenterLonF      = 37.616
        res@mpCenterLatF      = 55.833

        res@mpDataBaseVersion = "HighRes"
        ; res@mpDataResolution  = "Finest" ; don't work

        res@mpOutlineOn  = False

        res@mpInlandWaterFillColor = res@mpLandFillColor

    else if( area .eq. "Moscow" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        ; res@mpProjection      = "CylindricalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 55.50
        res@mpRightCornerLatF = 56.05
        res@mpLeftCornerLonF  = 37.15
        res@mpLeftCornerLonF  = 37.10
        res@mpRightCornerLonF = 38.00

        ; res@mpLimitMode       = "LatLon"
        ; res@mpMinLonF      =  37.12
        ; res@mpMaxLonF      =  38.
        ; res@mpMinLatF      =  55.50
        ; res@mpMaxLatF      =  56.12

        res@mpCenterLonF      = 37.616
        res@mpCenterLatF      = 55.833
        
        ; res@mpCenterLonF      = 37.600
        ; res@mpCenterLatF      = 55.700

        ; res@mpLimitMode         = "Angles"
        ; res@mpLeftAngleF         = 0.39
        ; res@mpRightAngleF        = 0.39
        ; res@mpBottomAngleF       = 0.30
        ; res@mpTopAngleF          = 0.2
        ; res@mpBottomAngleF       = 0.39
        ; res@mpTopAngleF          = 0.39

        res@mpDataBaseVersion = "HighRes"
        ; res@mpDataResolution  = "Finest" ; don't work
        res@mpOutlineOn  = False

    else if( area .eq. "NewMoscow" )then;;

        ; res@mpProjection      = "CylindricalEquidistant"
        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "Corners"

        ; res@mpLeftCornerLatF  = 55.00
        ; res@mpRightCornerLatF = 56.40
        ; res@mpLeftCornerLonF  = 36.20
        ; res@mpRightCornerLonF = 38.80

        res@mpLeftCornerLatF  = 55.08
        ; res@mpRightCornerLatF = 56.12
        res@mpRightCornerLatF = 56.10
        ; res@mpLeftCornerLonF  = 36.45
        res@mpLeftCornerLonF  = 36.47
        res@mpRightCornerLonF = 38.45

        res@mpCenterLonF      = 37.616
        res@mpCenterLatF      = 55.833

        res@mpDataBaseVersion = "LowRes"
        ; res@mpDataBaseVersion = "HighRes"
        
        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        ; res@mpGridLatSpacingF = 0.5
        ; res@mpGridLonSpacingF = 0.5

    else if( area .eq. "TulObl" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 52.20
        res@mpRightCornerLatF = 55.00
        res@mpLeftCornerLonF  = 34.50
        res@mpRightCornerLonF = 39.00

        res@mpCenterLonF      = 38.0
        res@mpCenterLatF      = 54.0

        res@mpDataBaseVersion = "HighRes"
        ; res@mpDataResolution  = "Finest" ; don't work

        res@mpOutlineOn  = False

    else if( area .eq. "OrelObl" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 51.80
        res@mpRightCornerLatF = 53.60
        res@mpLeftCornerLonF  = 34.50
        res@mpRightCornerLonF = 38.50

        res@mpCenterLonF      = 36.0
        res@mpCenterLatF      = 51.6

        res@mpDataBaseVersion = "HighRes"
        ; res@mpDataResolution  = "Finest" ; don't work

        res@mpOutlineOn  = False

    else if ( area .eq. "BelgorodObl" ) then;;

        res@mpProjection  = "AzimuthalEquidistant"
        res@mpLimitMode   = "Corners"

        res@mpLeftCornerLatF = 50.00
        res@mpRightCornerLatF = 52.15
        res@mpLeftCornerLonF = 34.50
        res@mpRightCornerLonF = 38.95

        res@mpCenterLatF = 50.60
        res@mpCenterLonF = 36.55
        res@mpDataBaseVersion = "HighRes"
        res@mpOutlineOn = False


    else if( area .eq. "icon_korea" .or. area .eq. "Korea"  )then;;
        print( "icon domain" )

        ; res@mpProjection = "Stereographic"
        ; res@mpProjection = " CylindricalEquidistant"
        ; res@mpProjection = "AzimuthalEquidistant"
        res@mpProjection = "CylindricalEqualArea"
        res@mpLimitMode = "LatLon"
        ; res@mpMinLonF      =  -25.
        ; res@mpMaxLonF      =  190.
        ; res@mpMinLatF      =   10.
        ; res@mpMaxLatF      =   90.
        res@mpCenterLonF = 82.5

        res@mpMinLonF      =  117.
        res@mpMaxLonF      =  140.
        res@mpMinLatF      =   29.
        res@mpMaxLatF      =   47.

    else if( area .eq. "CFO" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "Corners"
        res@mpLeftCornerLatF  = 49.00
        res@mpRightCornerLatF = 60.00
        res@mpLeftCornerLonF  = 30.00
        res@mpRightCornerLonF = 48.00

        ; res@mpLimitMode       = "LatLon"
        ; res@mpMinLonF      =  30.
        ; res@mpMaxLonF      =  48.
        ; res@mpMinLatF      =  49.
        ; res@mpMaxLatF      =  60.

        res@mpCenterLonF      = 37.616
        res@mpCenterLatF      = 55.833

        ; res@mpDataBaseVersion = "MediumRes"
        res@mpDataBaseVersion = "HighRes"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 5
        res@mpGridLonSpacingF = 10
        
    else if( area .eq. "NWFO" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "Corners"
        res@mpLeftCornerLatF  = 53.0
        res@mpRightCornerLatF = 72.0
        ; res@mpRightCornerLatF = 75.0
        res@mpLeftCornerLonF  = 19.0
        ; res@mpRightCornerLonF = 72.0
        res@mpRightCornerLonF = 75.0

        ; res@mpCenterLonF      = 30.000
        ; res@mpCenterLatF      = 60.000
        
        res@mpCenterLonF      = 37.0
        res@mpCenterLonF      = 41.0
        res@mpCenterLatF      = 63.0
        
        res@mpGridAndLimbOn = True

    else if( area .eq. "SFO" )then;;

        ; res@mpProjection      = "CylindricalEquidistant"
        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 40.00
        res@mpRightCornerLatF = 51.50
        res@mpLeftCornerLonF  = 33.00
        res@mpRightCornerLonF = 52.00

        res@mpCenterLonF      = 43.000
        res@mpCenterLatF      = 46.000

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 2
        res@mpGridLonSpacingF = 4

        res@mpDataBaseVersion = "HighRes"

    else if( area .eq. "RuBSC" )then;;

        ; res@mpProjection      = "CylindricalEquidistant"
        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 38.00
        res@mpRightCornerLatF = 49.00
        res@mpLeftCornerLonF  = 33.00
        res@mpRightCornerLonF = 46.00

        res@mpCenterLonF      = 40.000
        res@mpCenterLatF      = 45.000

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 2
        res@mpGridLonSpacingF = 2

        res@mpDataBaseVersion = "HighRes"
        
    else if( area .eq. "NCFO" )then;;
        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 40.00
        res@mpRightCornerLatF = 46.00
        res@mpLeftCornerLonF  = 39.00
        res@mpRightCornerLonF = 50.00

        res@mpCenterLonF      = 44.000
        res@mpCenterLatF      = 43.000

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 2
        res@mpGridLonSpacingF = 4

        res@mpDataBaseVersion = "HighRes"

    else if( area .eq. "ETR" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        ; res@mpLimitMode       = "Corners"
        ; res@mpLeftCornerLatF  = 40.00
        ; res@mpRightCornerLatF = 65.00
        ; res@mpLeftCornerLonF  = 30.00
        ; res@mpRightCornerLonF = 76.00

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF           = 40.0
        res@mpMaxLatF           = 70.0
        res@mpMinLonF           = 23.0
        res@mpMaxLonF           = 60.0

        res@mpCenterLonF      = 37.616
        res@mpCenterLatF      = 55.833

        res@mpDataBaseVersion = "MediumRes"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10

    else if( area .eq. "EUeast" )then;;

        res@mpProjection      = "CylindricalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 40.00
        res@mpRightCornerLatF = 70.00
        res@mpLeftCornerLonF  = 20.00
        res@mpRightCornerLonF = 65.00

        res@mpCenterLonF      = 37.616
        res@mpCenterLatF      = 55.833

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10

    else if( area .eq. "cm07etr" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        ; res@mpLimitMode       = "Corners"
        ; res@mpLeftCornerLatF  = 40.00
        ; res@mpRightCornerLatF = 65.00
        ; res@mpLeftCornerLonF  = 30.00
        ; res@mpRightCornerLonF = 76.00

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF           = 40.0
        res@mpMaxLatF           = 70.0
        res@mpMinLonF           =  0.0
        res@mpMaxLonF           = 80.0

        res@mpCenterLonF      = 37.616
        res@mpCenterLatF      = 55.833

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "Europe_ceq" )then;;

        res@mpProjection      = "CylindricalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 30.00
        res@mpRightCornerLatF = 75.00
        res@mpLeftCornerLonF  = -20.00
        res@mpRightCornerLonF = 65.00

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "Europe" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        ; res@mpLimitMode       = "Corners"

        ; res@mpLeftCornerLatF  = 30.00
        ; res@mpRightCornerLatF = 72.00
        ; res@mpLeftCornerLonF  = -10.00
        ; res@mpRightCornerLonF = 65.00
        res@mpLimitMode         = "LatLon"
        res@mpMinLatF           = 33.0
        res@mpMaxLatF           = 73.0
        res@mpMaxLatF           = 79.0
        res@mpMinLonF           = -7.0
        res@mpMaxLonF           =  53.0
        res@mpMaxLonF           =  58.0

        ; res@mpOutlineBoundarySets = "AllBoundaries"

        res@mpCenterLonF      = 27.616
        res@mpCenterLatF      = 55.833

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10
        res@mpGridLonSpacingF = 20

    else if( area .eq. "Belarus" .or. area .eq. "extBelarus" )then;;

        ; res@mpProjection      = "CylindricalEquidistant"
        ; res@mpProjection      = "CylindricalEqualArea"
        ; res@mpProjection      = "Stereographic"
        res@mpProjection      = "Mercator"
        ; res@mpProjection      = "Orthographic"
        ; res@mpLimitMode       = "Corners"

        res@mpLimitMode         = "LatLon"
        res@mpMinLatF           = 49.5
        res@mpMaxLatF           = 60.7
        res@mpMinLonF           = 17.5
        res@mpMaxLonF           = 40.0

        if( area .eq. "extBelarus" )then;;
            res@mpLimitMode         = "LatLon"
            res@mpMinLatF           = 46.0
            res@mpMaxLatF           = 60.7
            res@mpMinLonF           = 17.5
            res@mpMaxLonF           = 40.0
        end if;;

        ; res@mpLimitMode          = "Angles"
        ; res@mpLeftAngleF         = 6.0
        ; res@mpRightAngleF        = 8.5
        ; res@mpBottomAngleF       = 9.0
        ; res@mpTopAngleF          = 5.8

        ; res@mpCenterLonF      = 27.00
        ; res@mpCenterLatF      = 55.00

        res@mpDataBaseVersion = "HighRes"
        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"


    else if( area .eq. "Belarus4verif"  )then;;

        ; res@mpProjection      = "CylindricalEquidistant"
        ; res@mpProjection      = "CylindricalEqualArea"
        ; res@mpProjection      = "Stereographic"
        res@mpProjection      = "Mercator"
        ; res@mpProjection      = "Orthographic"
        ; res@mpLimitMode       = "Corners"

        res@mpLimitMode         = "LatLon"
        res@mpMinLatF           = 50.0
        res@mpMaxLatF           = 60.7
        res@mpMinLonF           = 18.5
        res@mpMaxLonF           = 40.0

        ; else if( area .eq. "extBelarus" )then;;
            ; res@mpLimitMode         = "LatLon"
            ; res@mpMinLatF           = 46.0
            ; res@mpMaxLatF           = 60.7
            ; res@mpMinLonF           = 17.5
            ; res@mpMaxLonF           = 40.0
        ; end if;;

        ; res@mpLimitMode          = "Angles"
        ; res@mpLeftAngleF         = 6.0
        ; res@mpRightAngleF        = 8.5
        ; res@mpBottomAngleF       = 9.0
        ; res@mpTopAngleF          = 5.8

        ; res@mpCenterLonF      = 27.00
        ; res@mpCenterLatF      = 55.00

        res@mpDataBaseVersion = "HighRes"
        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"

    else if( area .eq. "Belarus2" )then;;

        res@mpProjection      = "Mercator"

        res@mpLimitMode         = "LatLon"
        res@mpMinLatF           = 51.0
        res@mpMaxLatF           = 56.7
        res@mpMinLonF           = 23.0
        res@mpMaxLonF           = 33.0

        res@mpDataBaseVersion = "HighRes"
        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"

    else if( area .eq. "Cuba" )then;;

        res@mpProjection      = "CylindricalEquidistant"
        ; res@mpProjection      = "CylindricalEqualArea"
        ; res@mpProjection      = "Stereographic"
        ; res@mpProjection      = "Mercator"
        ; res@mpProjection      = "Orthographic"
        ; res@mpLimitMode       = "Corners"

        res@mpLimitMode         = "LatLon"
        res@mpMinLatF           = 13.0         ; map area
        res@mpMaxLatF           = 31.0         ; latitudes
        res@mpMinLonF           = -91.0         ; and
        res@mpMaxLonF           = -61.0         ; longitudes

        ; res@mpLimitMode          = "Angles"
        ; res@mpLeftAngleF         = 12.0
        ; res@mpRightAngleF        = 15.0
        ; res@mpBottomAngleF       = 9.0
        ; res@mpTopAngleF          = 9.0

        ; res@mpCenterLonF      = -78.00
        ; res@mpCenterLatF      = 22.00

        res@mpDataBaseVersion = "HighRes"
        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"

    else if( area .eq. "Antilles" )then;;

        ; res@mpProjection      = "CylindricalEquidistant"
        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode         = "LatLon"
        res@mpMinLatF           = 8.0         ; map area
        res@mpMaxLatF           = 45.0         ; latitudes
        res@mpMinLonF           = -100.0        ; and
        res@mpMaxLonF           = -54.0        ; longitudes
        res@mpMaxLonF           = -45.0        ; longitudes

        ; res@mpMinLatF         =  5.0
        ; res@mpMaxLatF         = 23.0
        ; res@mpMinLonF         = -70.0
        ; res@mpMaxLonF         = -35.0

        res@mpCenterLonF      = -75
        res@mpCenterLatF      = 20

        ; res@mpDataBaseVersion = "HighRes"
        res@mpDataBaseVersion = "MediumRes"
        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"

    else if( area .eq. "NHem" )then;;

        ; res@mpProjection      = "AzimuthalEquidistant"
        res@mpProjection = "PolarStereographic"
        ; res@mpProjection = "Stereographic"

        res@mpLimitMode         = "LatLon"

        res@mpMinLatF           = 0.0         ; map area
        res@mpMaxLatF           = 90.0         ; latitudes
        res@mpMinLonF           = -180.0         ; and
        res@mpMaxLonF           = 180.0        ; longitudes

        res@mpCenterLonF      = 0.
        res@mpCenterLatF      = 90.

        res@mpDataBaseVersion = "LowRes"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"
        ; res@mpGridLineDashPattern = 5
        ; res@mpGridLatSpacingF = 10

    else if( area .eq. "globe" )then;;

        ; res@mpProjection      = "AzimuthalEquidistant"
        ; res@mpProjection      = "Stereographic"
        ; res@mpProjection      = "Mercator"
        ; res@mpProjection      = "CylindricalEquidistant"
        ; res@mpProjection      = "Robinson"
        res@mpProjection      = "WinkelTripel"

        ; res@mpCenterLonF      = 0
        ; res@mpCenterLonF      = 90  ; there is problem with shaded field
        ; mpRelativeCenterLon = True
        ; res@mpLimitMode         = "LatLon"
        ; res@mpMinLatF           = -90.0         ; map area
        ; res@mpMaxLatF           = 90.0         ; latitudes
        ; res@mpMinLonF           = -180.0         ; and
        ; res@mpMaxLonF           = 180.0        ; longitudes
        ; res@mpMinLonF           = -90.0         ; and
        ; res@mpMaxLonF           = 270.0        ; longitudes

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 20
        res@mpGridLonSpacingF = 30
        ; res@mpGridLatSpacingF = 45
        ; res@mpGridLonSpacingF = 90
        
        res@mpGridLineThicknessF = 2.0
        res@gsnAddCyclic = True
        
    else if( area .eq. "ETR_sat" )then;;
    
        ; res@mpProjection      = "Orthographic"
        res@mpProjection      = "Satellite"
        res@mpPerimOn         = False
        ; res@mpCenterLonF      = 90
        res@mpCenterLonF      = 50
        res@mpCenterLatF      = 50
        res@mpCenterLatF      = 60
        ; res@mpSatelliteDistF      = 4.0        
        ; res@mpSatelliteDistF      = 2.0

    else if( area .eq. "ENA_70" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        ; res@mpProjection = "Stereographic"
        ; res@mpProjection = "PolarStereographic"

        res@mpLimitMode         = "LatLon"
        res@mpMinLatF           = 15.0         ; map area
        res@mpMaxLatF           = 60.0         ; latitudes
        res@mpMinLonF           = 10.0         ; and
        res@mpMaxLonF           = 200.0        ; longitudes
        
        ; res@mpLimitMode         = "Angles"
        ; res@mpLeftAngleF         = 90
        
        ; res@mpLimitMode         = "MaximalArea"
        ; res@mpOutlineBoundarySets = "AllBoundaries"
        ; res@mpOutlineBoundarySets = "National"
        ; res@mpOutlineBoundarySets = "NoBoundaries"

        res@mpCenterLonF      = 70
        res@mpCenterLatF      = 45
        res@mpCenterLatF      = 55

        ; res@mpDataBaseVersion = "LowRes" ; boundary with USSR and 2 GDR and FRG
        res@mpDataBaseVersion = "MediumRes"
        
    else if( area .eq. "ENA55" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        ; res@mpProjection = "Stereographic"
        ; res@mpProjection = "PolarStereographic"

        ; res@mpLimitMode         = "LatLon"
        ; res@mpMinLatF           = 25.0         ; map area
        ; res@mpMaxLatF           = 60.0         ; latitudes
        ; res@mpMinLonF           = 0.0         ; and
        ; res@mpMaxLonF           = 190.0        ; longitudes
        
        ; res@mpLimitMode         = "Angles"
        ; res@mpLeftAngleF         = 55.0
        ; res@mpRightAngleF        = 65.0
        ; res@mpBottomAngleF       = 25.0
        ; res@mpTopAngleF          = 43.0
        
        res@mpLimitMode         = "Corners"
        res@mpLeftCornerLatF  =  16.00
        res@mpLeftCornerLonF  =   5.00
        res@mpRightCornerLatF =  34.00
        res@mpRightCornerLonF = 179.00

        res@mpCenterLonF      = 55
        res@mpCenterLatF      = 50

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10
        res@mpGridLonSpacingF = 20

    else if( area .eq. "ENA" .or. area .eq. "ENA_90" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpCenterLonF      = 90.
        res@mpCenterLatF      = 55.
        res@mpCenterLatF      = 65.

        ; res@mpLimitMode         = "LatLon"
        ; res@mpMinLatF           = 23.0         ; map area
        ; res@mpMaxLatF           = 90.0         ; latitudes
        ; res@mpMinLonF           = -10.0         ; and
        ; res@mpMaxLonF           = 190.0        ; longitudes

        res@mpLimitMode         = "Angles"
        res@mpLeftAngleF         = 61.0
        res@mpRightAngleF        = 61.0
        res@mpBottomAngleF       = 39.0
        res@mpTopAngleF          = 39.0

        ; res@mpDataBaseVersion = "LowRes"
        res@mpOutlineOn  = True

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"
        ; res@mpGridLineDashPattern = 5
        ; res@mpGridLatSpacingF = 10

    else if( area .eq. "PENA" .or. area .eq. "extENA" .or. area .eq. "RussiaArctO" )then;;

        res@mpProjection        = "AzimuthalEquidistant"

        res@mpCenterLonF      = 90.
        res@mpCenterLatF      = 65.

        res@mpLimitMode         = "Angles"

        ; res@mpLeftAngleF         = 50.0 
        ; res@mpLeftAngleF         = 60.0
        ; res@mpRightAngleF        = 40.0
        ; res@mpBottomAngleF       = 30.0
        ; res@mpTopAngleF          = 50.0

        res@mpLeftAngleF         = 61.0
        res@mpRightAngleF        = 61.0
        res@mpBottomAngleF       = 39.0
        res@mpTopAngleF          = 61.0

        ; res@mpDataBaseVersion = "LowRes"

        res@mpGridAndLimbOn = True
        ; res@mpGridLineColor = "grey40"
        ; res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10
        res@mpGeophysicalLineThicknessF  = 2.5

    else if( area .eq. "native" )then;; ; fake Native 
        ; res@trYReverse             = True
        res@tfDoNDCOverlay         = True
 
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 25.00
        res@mpRightCornerLatF = 90.00
        res@mpLeftCornerLonF  = -10.00
        res@mpRightCornerLonF = 190.00

        res@mpCenterLonF      = 90.
        res@mpCenterLatF      = 65.

        res@mpDataBaseVersion = "LowRes"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"
        ; res@mpGridLineDashPattern = 5
        ; res@mpGridLatSpacingF = 10

    else if( area .eq. "ENA_90_45" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode         = "LatLon"
        res@mpMinLatF           = 23.0         ; map area
        res@mpMaxLatF           = 60.0         ; latitudes
        res@mpMinLonF           = 10.0         ; and
        res@mpMaxLonF           = 200.0        ; longitudes

        res@mpCenterLonF      = 90.
        res@mpCenterLatF      = 45.

        res@mpDataBaseVersion = "LowRes"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"
        ; res@mpGridLineDashPattern = 5
        ; res@mpGridLatSpacingF = 10

    else if( area .eq. "ENA_ceq" )then;;

        res@mpProjection      = "CylindricalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 10.00
        res@mpRightCornerLatF = 85.00
        res@mpLeftCornerLonF  = -20.00
        res@mpRightCornerLonF = 350.00

        res@mpCenterLonF      = 90.0
        res@mpCenterLatF      = 55.0

        res@mpDataBaseVersion = "LowRes"

    else if( area .eq. "Russia" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode         = "LatLon"
        res@mpMinLatF           = 47.0
        res@mpMaxLatF           = 80.0
        res@mpMinLonF           = 26.0
        res@mpMaxLonF           = 190.0

        res@mpCenterLonF      = 90.
        res@mpCenterLatF      = 60.

        res@mpDataBaseVersion = "LowRes"
        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10
        res@mpGridLonSpacingF = 15
        res@mpOutlineOn  = True
        ; res@mpCountyLineThicknessF   = "3.0"
        res@mpGeophysicalLineThicknessF  = "2.0"

    else if( area .eq. "RussiaKr" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        ; res@mpLimitMode       = "LatLon"
        ; res@mpMinLatF         = 39.0
        ; res@mpMaxLatF         = 75.0
        ; res@mpMinLonF         = 38.0
        ; res@mpMaxLonF         = 165.0

        res@mpLimitMode          = "Angles"
        res@mpLeftAngleF         = 38.5
        res@mpRightAngleF        = 42.0
        res@mpBottomAngleF       = 17.0
        res@mpTopAngleF          = 30.0

        res@mpCenterLonF      = 90.
        res@mpCenterLatF      = 55.

        res@mpDataBaseVersion = "LowRes"
        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10
        res@mpGridLonSpacingF = 15
        
    else if( area .eq. "SNG" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpCenterLonF      = 90.
        res@mpCenterLatF      = 55.
        res@mpCenterLatF      = 65.

        res@mpLimitMode         = "Angles"
        res@mpLeftAngleF         = 52.0
        res@mpRightAngleF        = 47.0
        res@mpBottomAngleF       = 30.0
        res@mpTopAngleF          = 31.0

        res@mpOutlineOn  = True

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey40"
        ; res@mpGridLineDashPattern = 5
        ; res@mpGridLatSpacingF = 10

    else if( area .eq. "sSib" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 42.0
        res@mpMaxLatF         = 69.0
        res@mpMinLonF         = 55.0
        res@mpMaxLonF         = 125.0

        res@mpCenterLonF      = 90.0
        res@mpCenterLatF      = 55.0

        res@mpDataBaseVersion = "MediumRes"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10
        res@mpGridLonSpacingF = 15

    else if( area .eq. "swSib" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 45.0
        res@mpMaxLatF         = 66.0
        res@mpMinLonF         = 61.0
        res@mpMaxLonF         = 97.0

        res@mpCenterLonF      = 80.0
        res@mpCenterLatF      = 55.0

        res@mpDataBaseVersion = "MediumRes"
        res@mpOutlineOn  = True

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10
        res@mpGridLonSpacingF = 15

    else if( area .eq. "cm02krs" .or. area .eq. "Krasn" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode         = "Angles"

        res@mpLeftAngleF         = 2.45
        res@mpRightAngleF        = 5.38
        res@mpBottomAngleF       = 11.96
        res@mpTopAngleF          = -5.50

        ; res@mpLeftAngleF         = 2.48
        ; res@mpRightAngleF        = 5.48
        ; res@mpBottomAngleF       = 12.00
        ; res@mpTopAngleF          = -5.40

        res@mpCenterLonF      = 90.
        res@mpCenterLatF      = 65.

        res@mpDataBaseVersion = "HighRes"
        res@mpOutlineOn  = True

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 4
        res@mpGridLonSpacingF = 4

    else if( area .eq. "Krasnoyarsk" )then;;
        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 55.7
        res@mpMaxLatF         = 56.35
        res@mpMinLonF         = 92.15
        res@mpMaxLonF         = 93.70

        res@mpCenterLonF      = 93.0
        res@mpCenterLatF      = 56.0

        res@mpDataBaseVersion = "HighRes"
        res@mpOutlineOn  = True

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 4
        res@mpGridLonSpacingF = 4

        res@tmYLOn = False
        res@tmXBOn = False

    else if( area .eq. "UniKrs" )then;;
        res@mpProjection      = "AzimuthalEquidistant"
        ; res@mpProjection      = "CylindricalEquidistant"

        ; res@mpLimitMode          = "Angles"
        ; res@mpLeftAngleF         = 0.7
        ; res@mpRightAngleF        = 0.4
        ; res@mpBottomAngleF       = 0.12
        ; res@mpTopAngleF          = 0.12

        res@mpLimitMode       = "LatLon"
        ; res@mpMinLatF         = 55.87
        ; res@mpMaxLatF         = 56.10
        ; res@mpMinLonF         = 92.55
        ; res@mpMaxLonF         = 93.12

        res@mpMinLatF         = 55.91
        res@mpMaxLatF         = 56.072
        res@mpMinLonF         = 92.60
        res@mpMaxLonF         = 92.97

        res@mpCenterLonF      = 93.0
        res@mpCenterLatF      = 56.0

        res@mpDataBaseVersion = "HighRes"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        ; res@mpGridLatSpacingF = 0.07
        res@mpGridLatSpacingF = 0.40/6
        res@mpGridLonSpacingF = 0.25

        res@tmYLOn = False
        res@tmXBOn = False

    else if( area .eq. "UralFO" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 48.0
        res@mpMaxLatF         = 73.5
        res@mpMinLonF         = 49.0
        res@mpMaxLonF         = 81.0

        res@mpCenterLonF      = 60.0
        res@mpCenterLatF      = 59.0

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "sUral" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 49.0
        res@mpMaxLatF         = 63.0
        res@mpMinLonF         = 49.0
        res@mpMaxLonF         = 73.0

        res@mpCenterLonF      = 60.0
        res@mpCenterLatF      = 56.0

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "SibFO" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        ; res@mpLimitMode       = "Corners"
        ; res@mpLeftCornerLatF  = 40.00
        ; res@mpRightCornerLatF = 65.00
        ; res@mpLeftCornerLonF  = 30.00
        ; res@mpRightCornerLonF = 76.00

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF           = 48.0
        res@mpMaxLatF           = 80.0
        res@mpMinLonF           = 65.0
        res@mpMaxLonF           = 115.0

        res@mpCenterLonF      = 90.0
        res@mpCenterLatF      = 65.0

        res@mpDataBaseVersion = "MediumRes"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10
        res@mpGridLonSpacingF = 15

    else if( area .eq. "DVFO" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 40.0
        res@mpMaxLatF         = 75.0
        res@mpMinLonF         = 113.0
        res@mpMaxLonF         = 180.0

        res@mpCenterLonF      = 155.0
        res@mpCenterLatF      = 55.0

        ; res@mpGridLatSpacingF = 15
        ; res@mpGridLonSpacingF = 15

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "nDVFO" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 50.0
        res@mpMaxLatF         = 75.0
        res@mpMinLonF         = 138.0
        res@mpMaxLonF         = 190.0

        res@mpCenterLonF      = 155.0
        res@mpCenterLatF      = 65.0

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "sDVFO" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        ; res@mpLimitMode       = "LatLon"
        ; res@mpMinLatF         = 40.0
        ; res@mpMaxLatF         = 55.0
        ; res@mpMinLonF         = 108.0
        ; res@mpMaxLonF         = 165.0

        ; res@mpCenterLonF      = 135.0
        ; res@mpCenterLatF      = 50.0
        
        res@mpLimitMode          = "Angles"
        res@mpLeftAngleF         = 20.0
        res@mpRightAngleF        = 20.0
        res@mpBottomAngleF       = 11.0
        res@mpTopAngleF          = 18.0

        res@mpCenterLonF      = 130.0
        res@mpCenterLatF      = 47.0

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "Sakha")then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 54.0
        res@mpMaxLatF         = 76.0
        res@mpMinLonF         = 111.0
        res@mpMaxLonF         = 152.0

        res@mpCenterLonF      = 130.0
        res@mpCenterLatF      = 62.0

    else if( area .eq. "ruArcticSeas" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 65.0
        res@mpMaxLatF         = 80.0
        res@mpMinLonF         = -15.0
        res@mpMaxLonF         = 180.0

        res@mpCenterLonF      = 90.0
        res@mpCenterLatF      = 75.0

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey12"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 10
        res@mpGridLonSpacingF = 15

    else if( area .eq. "VFO" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        ; res@mpMinLatF         = 48.5
        ; res@mpMaxLatF         = 62.0
        ; res@mpMinLonF         = 41.0
        ; res@mpMaxLonF         = 63.0
        res@mpMinLatF         = 48.9
        res@mpMaxLatF         = 62.0
        res@mpMinLonF         = 41.0
        res@mpMaxLonF         = 62.0

        res@mpCenterLonF      = 49.0
        res@mpCenterLatF      = 55.0

        res@mpDataBaseVersion = "HighRes"

    else if( area .eq. "Tatarstan" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 53.5
        res@mpMaxLatF         = 57.0
        res@mpMinLonF         = 46.5
        res@mpMaxLonF         = 54.5

        res@mpCenterLonF      = 49.0
        res@mpCenterLatF      = 55.0

        res@mpDataBaseVersion = "HighRes"

    else if( area .eq. "Vyatka" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 56.0
        res@mpMaxLatF         = 60.0
        res@mpMinLonF         = 45.0
        res@mpMaxLonF         = 54.0

        res@mpCenterLonF      = 49.70
        res@mpCenterLatF      = 58.60

        res@mpDataBaseVersion = "HighRes"

    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;

    if( area .eq. "FarEast" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 20.0
        res@mpMaxLatF         = 75.0
        res@mpMinLonF         = 113.0
        res@mpMaxLonF         = 180.0

        res@mpCenterLonF      = 155.0
        res@mpCenterLatF      = 45.0

        ; res@mpGridLatSpacingF = 15
        ; res@mpGridLonSpacingF = 15

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "PhilippSea" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 10.0
        res@mpMaxLatF         = 50.0
        res@mpMinLonF         = 120.0
        res@mpMaxLonF         = 160.0

        res@mpCenterLonF      = 140.0
        res@mpCenterLatF      = 25.0

        ; res@mpGridLatSpacingF = 15
        ; res@mpGridLonSpacingF = 15

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "California" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 14.0
        res@mpMaxLatF         = 43.0
        res@mpMinLonF         = -130.0
        res@mpMaxLonF         = -100.0

        res@mpCenterLonF      = -120.0
        res@mpCenterLatF      = 25.0

        ; res@mpGridLatSpacingF = 15
        ; res@mpGridLonSpacingF = 15

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "wMexico" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         = 10.0
        res@mpMaxLatF         = 33.0
        res@mpMinLonF         = -125.0
        res@mpMaxLonF         = -90.0

        res@mpCenterLonF      = -110.0
        res@mpCenterLatF      = 15.0

        ; res@mpGridLatSpacingF = 15
        ; res@mpGridLonSpacingF = 15

        res@mpDataBaseVersion = "MediumRes"

    else if( area .eq. "lAntilIsles" )then;;

        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"
        res@mpMinLatF         =  5.0
        res@mpMaxLatF         = 23.0
        res@mpMinLonF         = -70.0
        res@mpMaxLonF         = -35.0

        res@mpCenterLonF      = -50.0
        res@mpCenterLatF      = 15.0

        ; res@mpGridLatSpacingF = 15
        ; res@mpGridLonSpacingF = 15

        res@mpDataBaseVersion = "MediumRes"

    end if;;
    end if;;
    end if;;
    end if;;
    end if;;

    if( area .eq. "SeaAzov" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "LatLon"

        res@mpMinLatF         = 43.2
        res@mpMaxLatF         = 47.5
        res@mpMinLonF         = 34.1
        res@mpMaxLonF         = 39.3

        res@mpCenterLonF      = 36.0
        res@mpCenterLatF      = 45.0

        res@mpDataBaseVersion = "HighRes"
        ; res@mpOutlineOn  = False
        res@mpNationalLineColor     = "red"
        res@mpCountyLineColor       = "red"
        res@mpGeophysicalLineColor  = "black"
        ; res@mpOutlineBoundarySets = "National"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 1
        res@mpGridLonSpacingF = 2

    else if( area .eq. "Crimea" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "LatLon"

        res@mpMinLatF         = 43.2
        res@mpMaxLatF         = 47.5
        res@mpMinLonF         = 31.1
        res@mpMaxLonF         = 39.3

        res@mpCenterLonF      = 34.0
        res@mpCenterLatF      = 45.5

        res@mpDataBaseVersion = "HighRes"
        ; res@mpOutlineOn  = False
        res@mpNationalLineColor     = "red"
        res@mpCountyLineColor       = "red"
        res@mpGeophysicalLineColor  = "black"
        ; res@mpOutlineBoundarySets = "National"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 1
        res@mpGridLonSpacingF = 2


    else if( area .eq. "Kerch" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "LatLon"

        res@mpMinLatF         = 44.3
        res@mpMaxLatF         = 46.3
        res@mpMinLonF         = 35.3
        res@mpMaxLonF         = 38.1

        res@mpCenterLonF      = 36.0
        res@mpCenterLatF      = 45.0

        res@mpDataBaseVersion = "HighRes"
        ; res@mpOutlineOn  = False
        res@mpNationalLineColor     = "red"
        res@mpCountyLineColor       = "red"
        res@mpGeophysicalLineColor  = "black"
        ; res@mpOutlineBoundarySets = "National"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 1
        res@mpGridLonSpacingF = 1

    else if( area .eq. "Kerch.CylEq" )then;;

        res@mpProjection      = "CylindricalEquidistant"
        res@mpLimitMode       = "Corners"

        res@mpLeftCornerLatF  = 43.00
        res@mpRightCornerLatF = 47.00
        res@mpLeftCornerLonF  = 33.90
        res@mpRightCornerLonF = 39.50
        
    end if;;
    end if;;
    end if;;
    end if;;

    if( area .eq. "LenObl" )then;;

        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "LatLon"

        ; res@mpMinLatF         = 54.0
        ; res@mpMaxLatF         = 65.0
        ; res@mpMinLonF         = 20.0
        ; res@mpMaxLonF         = 40.0

        res@mpMinLatF         = 58.0
        res@mpMaxLatF         = 62.0
        res@mpMinLonF         = 27.0
        res@mpMaxLonF         = 36.0

        res@mpCenterLonF      = 30.0
        res@mpCenterLatF      = 60.0

        ; res@mpDataBaseVersion = "MediumRes"
        res@mpDataBaseVersion = "HighRes"
        ; res@mpOutlineOn  = False
        res@mpNationalLineColor     = "red"
        res@mpCountyLineColor       = "red"
        res@mpGeophysicalLineColor  = "black"
        ; res@mpOutlineBoundarySets = "National"

        res@mpGridAndLimbOn = True
        res@mpGridLineColor = "grey50"
        res@mpGridLineDashPattern = 5
        res@mpGridLatSpacingF = 2
        res@mpGridLonSpacingF = 4

    end if;;

    if( area .eq. "bigCentrAsia" )then;;
        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"

        res@mpMinLatF         = 31.0
        res@mpMaxLatF         = 63.0
        res@mpMinLonF         = 35.0
        res@mpMaxLonF         = 92.0

        res@mpCenterLonF      = 70.0
        res@mpCenterLatF      = 40.0

    else if( area .eq. "CentrAsia" )then;;
        res@mpProjection      = "AzimuthalEquidistant"

        res@mpLimitMode       = "LatLon"

        res@mpMinLatF         = 33.0
        res@mpMaxLatF         = 56.0
        res@mpMinLonF         = 50.8
        res@mpMaxLonF         = 85.8

        res@mpCenterLonF      = 70.0
        res@mpCenterLatF      = 40.0

    else if (area .eq. "mountCAsia" )then;; Fergana
        res@mpProjection      = "AzimuthalEquidistant"
        res@mpLimitMode       = "LatLon"

        res@mpMinLatF         = 36.0
        res@mpMaxLatF         = 44.0
        res@mpMinLonF         = 67.0
        res@mpMaxLonF         = 81.0

        res@mpCenterLonF      = 74.0
        res@mpCenterLatF      = 40.0

     end if;;
     end if;;
     end if;;

    ; res@selected_region = area

    return res
end;;

undef("settings4layer")
function settings4layer( area,res )
begin;;

    if( area .eq. "ENA" .or. \
        area .eq. "Russia" .or. \
        area .eq. "sSib" .or. \
        area .eq. "DVFO" .or. \
        area .eq. "UralFO" .or. \
        area .eq. "EUeast" .or. \
        area .eq. "ETR"  )then;;
        res@pmsl_cnLevelSpacingF  = 5.0

    else if( area .eq. "Europe" )then
        res@pmsl_cnLevelSpacingF  = 2.5

    else if( area .eq. "Krasn" )then
        res@pmsl_cnLevelSpacingF  = 2.0

    else if( area .eq. "MosReg" )then
        ; res@pmsl_cnLevelSpacingF  = 1.0 ; not enough for anticyclon
        res@pmsl_cnLevelSpacingF  = 0.5

    else if( area .eq. "NewMoscow" )then
        res@pmsl_cnLevelSpacingF  = 0.25

    else if( area .eq. "Moscow" )then
        res@pmsl_cnLevelSpacingF  = 0.2

    else if( area .eq. "wMexico" .or. area .eq. "lAntilIsles" .or. \
             area .eq. "PhilippSea" .or. area .eq. "Antilles" )then
        res@pmsl_cnLevelSpacingF  = 1

     end if
     end if
     end if
     end if
     end if
     end if
     end if;;

    return res
end;;

undef("delete_shaded_map")
function delete_shaded_map( res )
begin;;

    ; delete (res@mpDataBaseVersion )
    delete( res@mpOceanFillColor )
    delete( res@mpLandFillColor )
    delete( res@mpInlandWaterFillColor )
    
    return res
end;;

undef("value_map")
function value_map( area )
begin;;

    res               = True
    res@txFontHeightF = 0.008
    ; res@txFont        = "helvetica-bold"
    ; res@txFont        = "helvetica"

    res@dx = 40
    res@dy = 20
    res@stLineStartStride = 2 ; default

    ; res@adm_bound = (/""/)
    ; print(str_get_cols(area,0,2) )
    ; setting for 13 km (0.12 degree)
    if( str_get_cols(area,0,2) .eq. "ENA" .or. area .eq. "PENA" )then;;
        ; res@dx = 40
        ; res@dy = 15
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_sovereignty.shp", \
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_sovereignty.shp", \
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp" \
        /)
        ; ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_physical/ne_50m_rivers_lake_centerlines.shp" /)

    else if( area .eq. "extENA" .or. area .eq. "RussiaArctO" )then;;
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_sovereignty.shp",  \
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp",  \
                         getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_physical/ne_50m_rivers_lake_centerlines.shp" /)

    else if( area .eq. "ETR"  )then;;

        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces_lines.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces_scale_rank.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_boundary_lines_land.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_1_states_provinces_scale_rank.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_1_states_provinces.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_1_states_provinces_lines.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_disputed_areas.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm2_country.shp" \
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_boundary_lines_land.shp" \
                         ,getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp"    /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp" \
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_sovereignty.shp"    \
                         ; ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)


    else if( area .eq. "EUeast" .or. area .eq. "Europe" )then;;
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/110m_cultural/ne_110m_admin_0_boundary_lines_land.shp" /)

    else if( area .eq. "CFO" .or. area .eq. "NWFO" )then;;
        res@dx = 4
        res@dy = 3
        ; res@adm_bound = (/"national","province"/)
        ; res@adm_bound = (/"province","national"/) 
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_sovereignty.shp",    \
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)
        res@adm_bound = (/getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp" \
                         ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines.shp"  \
        /)
                         ; ,getenv("dir_shp")+ "/VMap0/Russia/hydro-inland-water-a.shp" \ 
        res@stLineStartStride  = 30 ; for vector 2 km

    else if( area .eq. "MosReg" )then;;
        res@dx = 1
        res@dy = 1
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)
        res@adm_bound = (/getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp" \
                          ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines.shp"  \
                          ,getenv("dir_shp")+ "/VMap0/Russia/hydro-inland-water-a.shp"     \
                          ,getenv("dir_shp")+ "/VMap0/Russia/hydro-aqueduct-canal-l.shp" /) ;,   \
                          ; ,getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm6_district.shp" \
                          ; getenv("dir_shp")+ "/VMap0/Russia/hydro-water-course-l.shp",     \
                          ; getenv("dir_shp")+ "/VMap0/Russia/hydro-danger-p.shp"    /)
                          ; getenv("dir_shp")+ "/VMap0/Russia/trans-road-l.shp" /)
                          ; 

         ; ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines.shp"  \
         ; ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_europe.shp"  \
         ; ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp",  \
         ; ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_minor_islands.shp",  \

    else if( area .eq. "NewMoscow" )then;;
        ; res@dx = 1
        ; res@dy = 1
        res@adm_bound = (/getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp" \
                          ,getenv("dir_shp")+ "/VMap0/Russia/hydro-inland-water-a.shp"     \
                          ,getenv("dir_shp")+ "/VMap0/Russia/hydro-water-course-l.shp"       \
                           /)

    else if( area .eq. "Moscow" )then;;
        ; res@dx = 1
        ; res@dy = 1
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)
        res@adm_bound =  (/  \
                           getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm8_municipal.shp" \
                           ,getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp" \
                           ,getenv("dir_shp")+ "/VMap0/Russia/hydro-inland-water-a.shp"     \
                           ,getenv("dir_shp")+ "/VMap0/Russia/hydro-aqueduct-canal-l.shp"   \
                           ,getenv("dir_shp")+ "/VMap0/Russia/hydro-water-course-l.shp"       \
                         /)
                          ; getenv("dir_shp")+ "/VMap0/Russia/trans-road-l.shp", \
                          ; getenv("dir_shp")+ "/VMap0/Russia/hydro-danger-p.shp"    /)
                         ; getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm6_district.shp" \

    else if( area .eq. "LenObl" .or. area .eq. "TulObl" .or. area .eq. "OrelObl" .or. area .eq. "BelgorodObl" \
      .or. area .eq. "Vyatka"    )then;;
        res@dx = 1
        res@dy = 1
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)
        res@adm_bound = (/getenv("dir_OpenStreetMap") + "/adm4_region.shp" /)

    else if( area .eq. "SFO" .or. area .eq. "NCFO" )then;;
        res@dx = 4
        res@dy = 3
        ; res@adm_bound = (/"national","province"/)
        ; res@adm_bound = (/"province","national"/) 
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_sovereignty.shp",    \
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)
        res@adm_bound = (/ getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp" \
                          ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines.shp"  \
                          ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_sovereignty.shp"  \
                          /)
                          ; ,getenv("dir_shp")+ "/VMap0/Russia/hydro-inland-water-a.shp"     \
                          ; ,getenv("dir_shp")+ "/VMap0/Russia/hydro-aqueduct-canal-l.shp" \ 
        res@stLineStartStride  = 30 ; for vector 2 km

    else if( area .eq. "VFO" .or. area .eq. "Tatarstan" )then;;
        res@dx = 4
        res@dy = 3
        ; res@adm_bound = (/"national","province"/)
        ; res@adm_bound = (/"province","national"/) 
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_sovereignty.shp",    \
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" \
                         ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines.shp"  \
        /)
        ; ,getenv("dir_shp")+ "/VMap0/Russia/hydro-inland-water-a.shp"     \
        ; ,getenv("dir_shp")+ "/VMap0/Russia/hydro-aqueduct-canal-l.shp" \ 
        ; ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines.shp"  \
        res@stLineStartStride  = 30 ; for vector 2 km

    else if( area .eq. "UralFO" )then;;
        res@dx = 20
        res@dy = 10
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)
        res@adm_bound = (/getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp" /)

    else if( area .eq. "sUral" )then;;
        res@dx = 20
        res@dy = 10
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)
        res@adm_bound = (/getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp" /)

    else if( area .eq. "SibFO" )then;;
        res@dx = 20
        res@dy = 10

    else if( area .eq. "DVFO" .or. area .eq. "FarEast" .or. area .eq. "nDVFO" .or. area .eq. "sDVFO" )then;;
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp" \
                         ,getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp" \
        /)

    else if( area .eq. "California" .or. area .eq. "wMexico" .or. area .eq. "lAntilIsles" \
             .or. area .eq. "PhilippSea"    )then;;

        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp" \
        /)

    else if( area .eq. "Sakha" )then;;
        res@dx = 20
        res@dy = 10
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp" \
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" \
        /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_10m_admin_1_states_provinces.shp" \

    else if( area .eq. "Kerch" )then;;
        res@stLineStartStride = 20 ; 2km
        ; res@adm_bound = (/getenv("dir_OpenStreetMap") + "/adm4_region.shp", \
        res@adm_bound = (/   getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_sovereignty.shp" /)
                         ; getenv("dir_shp")+ "/NaturalEarth/3.1.0/ne_10m_admin_0_sovereignty.shp" /)

    else if( area .eq. "SeaAzov" )then;;
        res@stLineStartStride = 25 ; 2km

    else if( area .eq. "Russia" .or. area .eq. "SNG" )then;;
        res@dx = 14
        res@dy = 13
        ; res@adm_bound = (/"national","province"/)
        ; res@adm_bound = (/"province","national"/) 
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_sovereignty.shp",  \
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp"  \
                         ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_physical/ne_50m_rivers_lake_centerlines.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/110m_cultural/ne_110m_admin_0_sovereignty.shp" /) ; \
        
        ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines.shp" /)
        ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/110m_physical/ne_110m_rivers_lake_centerlines.shp" /)
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" /)
        ; res@stLineStartStride  = 30 ; for vector 2 km

    else if( area .eq. "RussiaKr" )then;;
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_sovereignty.shp",  \
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp",  \
                         getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_physical/ne_50m_rivers_lake_centerlines.shp" /)

    else if( area .eq. "Belarus" .or. area .eq. "Belarus2" .or. area .eq. "Belarus4verif" )then;;
        res@dx = 14
        res@dy = 13
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_sovereignty.shp",  \
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp" /)

    else if( area .eq. "sSib" )then;;
        res@dx = 18
        res@dy = 17
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_sovereignty.shp",  \
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp",  \
                         getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_physical/ne_50m_rivers_lake_centerlines.shp" /)

    else if( area .eq. "swSib" )then;;
        res@dx = 18
        res@dy = 17
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_sovereignty.shp",  \
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp"  \
                         ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_physical/ne_50m_rivers_lake_centerlines.shp"     \
                         ,getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm4_region.shp"  /)

    else if( area .eq. "Krasn" .or. area .eq. "cm02krs" )then;;
        res@dx = 15
        res@dy = 14
        res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp",  \
                         getenv("dir_shp")+ "/VMap0/Russia/hydro-inland-water-a.shp", \
                        getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines.shp" /)
                        ; getenv("dir_shp")+ "/VMap0/Russia/hydro-water-course-l.shp" /)

    else if( area .eq. "Krasnoyarsk" )then;;
        res@dx = 3
        res@dy = 3
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp",  \
        res@adm_bound = (/ getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm6_district.shp"  \
                          ,getenv("dir_shp")+ "/VMap0/Russia/hydro-inland-water-a.shp"   \
                          /)
                         ; ,getenv("dir_shp")+ "/VMap0/Russia/hydro-water-course-l.shp" \ 
                         ; ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines.shp"  \
                         ; getenv("dir_shp")+"/NaturalEarth/4.0.0/10m_cultural/ne_10m_urban_areas.shp" ,
                         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_minor_islands.shp" ,   \
                         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_minor_islands2.shp" ,   \
                         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_geographic_lines.shp" ,   \
                         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_coastline.shp" ,   \
                         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_lakes_europe.shp" ,   \
                         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_lakes_pluvial.shp" ,   \
                         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_lakes.shp" /)

    else if( area .eq. "UniKrs" )then;;
        res@dx = 1
        res@dy = 1
        res@adm_bound = (/ getenv("dir_shp")+ "/OpenStreetMap_rus/rus_adm_2012/adm6_district.shp" \
                          ,getenv("dir_shp")+ "/VMap0/Russia/hydro-inland-water-a.shp" \ 
                          ,getenv("dir_shp")+ "/VMap0/Russia/hydro-water-course-l.shp" \ 
                         /)
         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines.shp"  \
         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_europe.shp",  \
         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp",  \
         ; getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_physical/ne_10m_minor_islands.shp",  \

    else if( area .eq. "bigCentrAsia" .or. area .eq. "CentrAsia" )then;;
         ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp" \
         res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_sovereignty.shp" \
         /)
    else if (area .eq. "mountCAsia" )then;;
         ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/50m_cultural/ne_50m_admin_0_boundary_lines_land.shp" \
         res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_sovereignty.shp" \
         /)
         ; ,getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_1_states_provinces.shp" \

    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;

    ; if( res@adm_bound(0) .eq. "national" )then
        ; res@adm_bound = (/getenv("dir_shp")+ "/NaturalEarth/4.0.0/10m_cultural/ne_10m_admin_0_sovereignty.shp"
    ; end if 

    res@lbOrientation = "Vertical"
    res@lb2from2 = 0.005
    if( str_get_cols(area,0,2) .eq. "ENA" )then;;
        res@lbOrientation = "Horizontal"
        res@shaveBorder = 160

    else if( area .eq. "RussiaArctO" )then;;
        res@lb2from2 = 0.0

    else if( area .eq. "ruArcticSeas" )then;;
        res@lbOrientation = "Horizontal"
        res@shaveBorder = 130

    else if( str_get_cols(area,0,5) .eq. "Russia" )then;;
        res@lbOrientation = "Horizontal"
        res@shaveBorder = 170
        if( area .eq. "RussiaKr" )then
            res@shaveBorder = 165
        end if

    else if( area .eq. "SNG" )then;;
        res@lbOrientation = "Horizontal"
        ; res@shaveBorder = 130
        res@shaveBorder = 129
        
    else if( area .eq. "sSib" )then;;
        res@lbOrientation = "Horizontal"
        res@shaveBorder = 130

    else if( area .eq. "cm02krs" .or. area .eq. "Krasn" )then;;
        ; res@shaveBorder = 40
        res@shaveBorder = 50

    else if( area .eq. "Krasnoyarsk" )then;;
        ; res@shaveBorder = 100
        res@shaveBorder = 50 ; no tickmarks

    else if( area .eq. "UniKrs" )then;;
        ; res@shaveBorder = 90
        res@shaveBorder = 50 ; no tickmarks

    else if( area .eq. "ETR" )then;;
        res@lbOrientation = "Vertical"

    else if( area .eq. "Europe" )then;;
        res@shaveBorder = 50

    else if( area .eq. "CFO" )then;;
        res@lb2from2 = 0.0
        ; res@pmLabelBarHeightF  = 0.75

    else if( area .eq. "NWFO" )then;;
        res@lbOrientation = "Horizontal"

    else if( area .eq. "SFO" )then;;
        res@shaveBorder = 60

    else if( area .eq. "NCFO" )then;;
        res@lbOrientation = "Horizontal"
        res@shaveBorder = 50

    else if( area .eq. "MosReg" )then;;
        res@shaveBorder = 25

    else if( area .eq. "SeaAzov" )then;;
        res@lb2from2 =  0.00

    ; else if( area .eq. "Kerch" )then;;
        ; res@lb2from2 =  0.00
        
    else if( area .eq. "Crimea" )then;;
        ; res@shaveBorder = 100
        res@shaveBorder = 115
        res@pmLabelBarHeightF  = 0.55
        ; res@lbOrientation = "Horizontal"
        ; res@shaveBorder = 50
        
    else if( area .eq. "UralFO" )then;;
        res@lbOrientation = "Vertical"

    else if( area .eq. "SibFO" )then
        res@lbOrientation = "Vertical"

    else if( area .eq. "DVFO" )then
        ; res@shaveBorder = 80
        ; res@shaveBorder = 100
        res@shaveBorder = 105
        res@pmLabelBarHeightF  = 0.58
        ; res@lbOrientation = "Horizontal"
        ; res@shaveBorder = 45
        
    else if( area .eq. "nDVFO" )then
        res@shaveBorder = 60

    else if( area .eq. "sDVFO" )then
        res@shaveBorder = 60
        res@lbOrientation = "Horizontal"

    else if( area .eq. "NewMoscow" )then
        ; res@lb2from2 = -0.08   ; was nessasary for second labelbar
        res@shaveBorder = 45

    ; else if( area .eq. "VFO" )then
        ; res@shaveBorder = 5

    else if( area .eq. "Tatarstan" )then
        res@lbOrientation = "Horizontal"
        res@shaveBorder = 50

    else if( area .eq. "Belarus" )then
        res@shaveBorder = 55
        
    else if( area .eq. "LenObl" )then
        res@shaveBorder = 60

    else if( area .eq. "globe" )then
        res@lbOrientation = "Horizontal"
        ; res@shaveBorder = 150
        ; res@shaveBorder = 120 ; for Robinson
        ; res@shaveBorder = 75 ; for WinkelTripel
        res@shaveBorder = 85 ; for WinkelTripel

    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;

    return res
end;;

undef("skipValueGrid")
function skipValueGrid( res, area, domain)
begin;;

    res@txFontHeightF = 0.008
    res@dx = 1
    res@dy = 1
    res@dx = 40
    res@dy = 15

    if( domain .eq. "cm02krs" )then;;
        if( area .eq. "Krasnoyarsk" )then;;
            res@dx = 3
            res@dy = 3
        else if( area .eq. "UniKrs" )then;;
            res@dx = 1
            res@dy = 1
        end if;;
        end if;;
    end if;;

    if( domain .eq. "cm01krs" )then;;
        if( area .eq. "Krasnoyarsk" )then;;
            res@dx = 4
            res@dy = 4
        else if( area .eq. "UniKrs" )then;;
            res@dx = 1
            res@dy = 1
        end if;;
        end if;;

    end if;;

    if( domain .eq. "cm02bel" .or. domain .eq. "cm02etr" )then;;
        if( area .eq. "EUeast" )then;;
            res@dx = 40
            res@dy = 30
        else if( area .eq. "Belarus" )then;;
            res@dx = 40
            res@dy = 25
        else if( area .eq. "ETR" )then;;
            res@dx = 40
            res@dy = 30
        else if( area .eq. "CFO" )then;;
            res@dx = 20
            res@dy = 20
        else if( area .eq. "MosReg" )then;;
            res@dx = 5
            res@dy = 5
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
    end if;;

    if( domain .eq. "cm01msk" )then;;

        if( area .eq. "ETR" )then;;
            res@dx = 50
            res@dy = 30
        else if( area .eq. "CFO" )then;;
            res@dx = 30
            res@dy = 20
        else if( area .eq. "MosReg" )then;;
            res@dx = 8
            res@dy = 7
        else if( area .eq. "NewMoscow" )then;;
            res@dx = 4
            res@dy = 3
        else if( area .eq. "Moscow" )then;;
            res@dx = 2
            res@dy = 1
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
    end if;;
    
    if( domain .eq. "cm06ena" )then;;

        if( area .eq. "ETR" )then;;
            ; res@dx = 30
            ; res@dy = 10
            res@dx = 20
            res@dy = 15
        else if( area .eq. "CFO" )then;;
            ; res@dx = 12
            ; res@dy = 10
            res@dx = 10
            res@dy = 10
        else if( area .eq. "MosReg" )then;;
            res@dx = 5
            res@dy = 5
        else if( area .eq. "NewMoscow" )then;;
            res@dx = 2
            res@dy = 2
        else if( area .eq. "Moscow" )then;;
            res@dx = 1
            res@dy = 1

        else if( area .eq. "NWFO" )then;;
            res@dx = 12
            res@dy = 12

        else if( area .eq. "UralFO" )then;;
            res@dx = 15
            res@dy = 15

        else if( area .eq. "SibFO" )then;;
            res@dx = 20
            res@dy = 20

        else if( area .eq. "DVFO" )then;;
            ; res@dx = 20
            ; res@dy = 20
            res@dx = 25
            res@dy = 25

        else if( area .eq. "SFO" )then;;
            res@dx = 10
            res@dy = 10

        else if( area .eq. "NCFO" )then;;
            res@dx = 7
            res@dy = 7

        else if( area .eq. "VFO" )then;;
            res@dx = 10
            res@dy = 10
            
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
    end if;;

    return res
end;;


undef("subset_grid")
function subset_grid( area, field, domain )
local field_out
begin;;

    res = True
    draw_domain_border = True
    grid = get_domain( domain )
    
    ; printVarSummary (field)
    ndims = dimsizes(dimsizes(field))
    ; print (dimsizes(field))
    ; print (ndims)
    if( ndims .eq. 2 )then;;
        nx = dimsizes(field(0,:))
        ny = dimsizes(field(:,0))
    else if( ndims .eq. 3 )then
        nx = dimsizes(field(0,0,:))
        ny = dimsizes(field(0,:,0))
    else if( ndims .eq. 1 )then
        print( "1d array. no subset")
        return field
    end if
    end if
    end if;;

    ix1 = 0
    ix2 = nx-1
    iy1 = 0
    iy2 = ny-1

    if( str_get_cols(domain,0,6) .eq. "cm06ena" .or. domain .eq. "iclm06_ena" )then;;

        if( area .eq. "ETR" )then;;
            ; res@dx = 10
            ; res@dy = 10
            ix1 = 240
            ix2 = 945
            iy1 = 150
            iy2 = 850

        else if( area .eq. "Europe" )then;;
            ; res@dx = 11
            ; res@dy = 11
            iy1 = 44
            ix2 = 1085

        else if( area .eq. "CFO" )then;;
            ; res@dx = 1
            ; res@dy = 3
            ix1 = 420
            ix2 = 675
            iy1 = 400
            iy2 = 650

        else if( area .eq. "Belarus" )then;;
            ; res@dx = 4
            ; res@dy = 3
            ix1 = 305
            ix2 = 630
            iy1 = 405
            iy2 = 725

        else if( area .eq. "VFO" )then;;
            ; res@dx = 10
            ; res@dy = 10

            ix1 = 500
            ix2 = 820
            iy1 = 290
            iy2 = 610

        else if( area .eq. "UralFO" )then;;
            ; res@dx = 20
            ; res@dy = 10
            ix1 = 550
            ix2 = 1080
            iy1 = 190
            iy2 = 750

        ; else if( area .eq. "sUral" )then;;
            ; res@dx = 10
            ; res@dy = 10
            ; ix1 = 510
            ; ix2 = 915
            ; iy1 = 240
            ; iy2 = 585

        else if( area .eq. "MosReg" .or. area .eq. "NewMoscow" .or. area .eq. "Moscow" )then;;
            ; res@dx = 1
            ; res@dy = 1
            ix1 = 450
            ix2 = 650
            iy1 = 450
            iy2 = 600

        else if( area .eq. "LenObl" )then;;
            res@dx = 1
            res@dy = 1

        else if( area .eq. "SibFO" )then;;
            res@dx = 20
            res@dy = 10

        else if( area .eq. "DVFO" )then;;
            ix1 =  915
            ix2 = 1920
            iy1 =   55
            iy2 =  999

        else if( area .eq. "Sakha" )then;;
            ix1 =  990
            ix2 = 1600
            iy1 =  250
            iy2 =  900

        else if( area .eq. "Kerch" )then;;
            res@dx = 5
            res@dy = 5

        else if( area .eq. "SeaAzov" )then;;
            res@dx = 5
            res@dy = 5

        ; else if( area .eq. "SFO" )then;;
            ; res@dx = 1
            ; res@dy = 3

            ; ix1 = 325
            ; ix2 = 625
            ; iy1 = 245
            ; iy2 = 550

        else if( area .eq. "RussiaKr" )then;;
            ix1 = 270
            ix2 = 1830
            iy1 = 70
            iy2 = 830

        else if( area .eq. "Russia" )then;;
            ix1 = 340
            ix2 = 1795
            iy1 = 200
            iy2 = 960

        else if( area .eq. "sSib" )then;;
            ix1 = 550
            ix2 = 1450
            iy1 = 119
            iy2 = 630

        else if( area .eq. "swSib" )then;;
            ix1 = 645
            ix2 = 1130
            iy1 = 150
            iy2 = 580

        else if( area .eq. "Krasn" )then;;
            ix1 = 940
            ix2 = 1150
            iy1 = 280
            iy2 = 450

        ; end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
    end if;;

    if( domain .eq. "cm02krs" )then;;
        if( area .eq. "Krasn" )then;;
            ; ix1 = 190
            ; ix2 = 220
            ; iy1 = 142
            ; iy2 = 158

        else if( area .eq. "Krasnoyarsk" )then;;
            ix1 = 180
            ix2 = 230
            iy1 = 132
            iy2 = 170

        else if( area .eq. "UniKrs" )then;;
            ix1 = 190
            ix2 = 220
            iy1 = 142
            iy2 = 158
            ; ix1 = 180
            ; ix2 = 230
            ; iy1 = 132
            ; iy2 = 170

        end if;;
        end if;;
        end if;;

    else if( domain .eq. "cm01krs" )then;;
        if( area .eq. "Krasn" )then;;
            ; ix1 = 940
            ; ix2 = 1150
            ; iy1 = 280
            ; iy2 = 450

        else if( area .eq. "Krasnoyarsk" )then;;
            ix1 = 120
            ix2 = 210
            iy1 = 120
            iy2 = 195

        else if( area .eq. "UniKrs" )then;;
            ix1 = 144
            ix2 = 180
            iy1 = 140
            iy2 = 165

        end if;;
        end if;;
        end if;;
    end if;;
    end if;;

    if( str_get_cols(domain,0,6) .eq. "cm02etr" )then;;
        if( area .eq. "VFO" )then;;
            ix1 = 400
            ix2 = 1200-1
            iy1 = 50
            iy2 = 1000

        else if( area .eq. "Tatarstan" )then;;
            ix1 = 685
            ix2 = 990
            iy1 = 375
            iy2 = 675

        else if( area .eq. "SFO" )then;;
            ix1 = 0
            ix2 = 765
            iy1 = 0
            iy2 = 785

        else if( area .eq. "RuBSC" )then;;
            ix1 = 0
            ix2 = 550
            iy1 = 0
            iy2 = 700

        else if( area .eq. "Crimea" .or. area .eq. "SeaAzov" .or. area .eq. "Kerch" )then;;
            ix2 = 350
            iy1 = 300
            iy2 = 700

        else if( area .eq. "CFO" )then;;
            ; res@dx = 1
            ; res@dy = 1
            ix1 = 150
            ix2 = 950
            iy1 = 350
            iy2 = 1150

        else if( area .eq. "MosReg" )then;;
            ; res@dx = 1
            ; res@dy = 1
            ix1 = 450
            ix2 = 700
            iy1 = 650
            iy2 = 900

        else if( area .eq. "NewMoscow" )then;;
            ; res@dx = 1
            ; res@dy = 1
            ix1 = 520
            ix2 = 625
            iy1 = 730
            iy2 = 840

        else if( area .eq. "Moscow" )then;;
            ; res@dx = 1
            ; res@dy = 1
            ix1 = 550
            ix2 = 595
            iy1 = 765
            iy2 = 805

        else if( area .eq. "Belarus" )then;;
            ix2 = 795
            iy1 = 515
            iy2 = 1355

        else if( area .eq. "Belarus2" )then;;
            ix1 = 120
            ix2 = 530
            iy1 = 725
            iy2 = 1135
            
        else if( area .eq. "LenObl" )then;;
            ix1 = 470
            ix2 = 800
            iy1 = 880
            iy2 = 1210

        ; else
            ; draw_domain_border = False

        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;

    end if;;


    if( domain .eq. "cm13ena" .or. domain .eq. "cm06ena" \
        .or. domain .eq. "cm02etr" )then;;
        
        if( area .eq. "sUral" )then;;
            rlon1 = -29.4
            rlon2 = -5.1
            rlat1 = -15.6
            rlat2 = 5.1

        ix1 = max( (/ 0, coord2index( rlon1, grid@startlon, grid@dlon ) -1 /) )
        ix2 = min( (/ grid@nx-1, coord2index( rlon2, grid@startlon, grid@dlon ) -1 /) )
        iy1 = max( (/ 0, coord2index( rlat1, grid@startlat, grid@dlat ) -1 /) )
        iy2 = min( (/ grid@ny-1, coord2index( rlat2, grid@startlat, grid@dlat ) -1 /) )
        ; print (ix1 + " " + ix2 + " " + iy1 + " " + iy2 )

        else if( area .eq. "NWFO" )then;;
            rlon1 = -36.0
            rlon2 = -4.5
            rlat1 = -6.0
            rlat2 = 24.0

            ix1 = max( (/ 0, coord2index( rlon1, grid@startlon, grid@dlon ) -1 /) )
            ix2 = min( (/ grid@nx-1, coord2index( rlon2, grid@startlon, grid@dlon ) -1 /) )
            iy1 = max( (/ 0, coord2index( rlat1, grid@startlat, grid@dlat ) -1 /) )
            iy2 = min( (/ grid@ny-1, coord2index( rlat2, grid@startlat, grid@dlat ) -1 /) )

        else if( area .eq. "nDVFO" )then;;
            rlon1 = 6.0
            rlon2 = 49.50
            rlat1 = -4.5
            rlat2 = 29.94

            ix1 = max( (/ 0, coord2index( rlon1, grid@startlon, grid@dlon ) -1 /) )
            ix2 = min( (/ grid@nx-1, coord2index( rlon2, grid@startlon, grid@dlon ) -1 /) )
            iy1 = max( (/ 0, coord2index( rlat1, grid@startlat, grid@dlat ) -1 /) )
            iy2 = min( (/ grid@ny-1, coord2index( rlat2, grid@startlat, grid@dlat ) -1 /) )

        else if( area .eq. "sDVFO" )then;;
            rlon1 = -0.9
            rlon2 = 49.50
            rlat1 = -30.0
            rlat2 = 17.10

            ix1 = max( (/ 0, coord2index( rlon1, grid@startlon, grid@dlon ) -1 /) )
            ix2 = min( (/ grid@nx-1, coord2index( rlon2, grid@startlon, grid@dlon ) -1 /) )
            iy1 = max( (/ 0, coord2index( rlat1, grid@startlat, grid@dlat ) -1 /) )
            iy2 = min( (/ grid@ny-1, coord2index( rlat2, grid@startlat, grid@dlat ) -1 /) )

        else if( area .eq. "SFO" )then;;
            ; ix1 = 325
            ; ix2 = 625
            ; iy1 = 245
            ; iy2 = 550

            rlon1 = -40.5
            rlon2 = -22.5
            rlat1 = -15.3
            rlat2 =  3.0
            
        else if( area .eq. "NCFO" )then;;
            rlon1 = -37.5
            rlon2 = -25.5
            rlat1 = -15.0
            rlat2 =  -4.5

            ix1 = max( (/ 0, coord2index( rlon1, grid@startlon, grid@dlon ) -1 /) )
            ix2 = min( (/ grid@nx-1, coord2index( rlon2, grid@startlon, grid@dlon ) -1 /) )
            iy1 = max( (/ 0, coord2index( rlat1, grid@startlat, grid@dlat ) -1 /) )
            iy2 = min( (/ grid@ny-1, coord2index( rlat2, grid@startlat, grid@dlat ) -1 /) )

        else if( area .eq. "ruArcticSeas" )then;;
            rlon1 = -28.5
            rlon2 =  28.5
            rlat1 =  -1.0
            rlat2 =  30.0

            ix1 = max( (/ 0, coord2index( rlon1, grid@startlon, grid@dlon ) -1 /) )
            ix2 = min( (/ grid@nx-1, coord2index( rlon2, grid@startlon, grid@dlon ) -1 /) )
            iy1 = max( (/ 0, coord2index( rlat1, grid@startlat, grid@dlat ) -1 /) )
            iy2 = min( (/ grid@ny-1, coord2index( rlat2, grid@startlat, grid@dlat ) -1 /) )

        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;
        end if;;

    end if;;

    if( str_get_cols(domain,0,6) .eq. "cm01msk" )then;;
        if( area .eq. "NewMoscow" )then;;
            res@dx = 1
            res@dy = 1
            ; ix1 = 5
            ; ix2 = 170
            ; iy1 = 10
            ; iy2 = 170
        else if( area .eq. "Moscow" )then;;
            res@dx = 1
            res@dy = 1
            ; ix1 = 60
            ; ix2 = 130
            ; iy1 = 60
            ; iy2 = 130
        end if;;
        end if;;

    end if;;

    if( str_get_cols(domain,0,6) .eq. "cm01msk" .or. \
        str_get_cols(domain,0,7) .eq. "cm005msk"    )then;;
        rlon1 = grid@startlon
        rlat1 = grid@startlat
        rlon2 = grid@endlon
        rlat2 = grid@endlat
        if( area .eq. "NewMoscow" )then;;
            rlon1 = -0.774
            rlon2 = 0.711
            rlat1 = -0.729
            rlat2 = 0.711
        else if( area .eq. "Moscow" )then;;
            rlon1 = -0.279
            rlon2 = 0.351
            rlat1 = -0.279
            rlat2 = 0.351
        end if;;
        end if;;

        ix1 = max( (/ 0, coord2index( rlon1, grid@startlon, grid@dlon ) -1 /) )
        ix2 = min( (/ grid@nx-1, coord2index( rlon2, grid@startlon, grid@dlon ) -1 /) )
        iy1 = max( (/ 0, coord2index( rlat1, grid@startlat, grid@dlat ) -1 /) )
        iy2 = min( (/ grid@ny-1, coord2index( rlat2, grid@startlat, grid@dlat ) -1 /) )
        ; print (ix1 + " " + ix2 + " " + iy1 + " " + iy2 )

    end if;;


    if( domain .eq. "cm02cfo" )then;;
        rlon1 = grid@startlon
        rlat1 = grid@startlat
        rlon2 = grid@endlon
        rlat2 = grid@endlat
        if( area .eq. "MosReg" )then;;
            rlon1 = -0.14
            rlon2 = 3.20
            rlat1 = -0.82
            rlat2 = 2.34
        end if;;

        ix1 = max( (/ 0, coord2index( rlon1, grid@startlon, grid@dlon ) -1 /) )
        ix2 = min( (/ grid@nx-1, coord2index( rlon2, grid@startlon, grid@dlon ) -1 /) )
        iy1 = max( (/ 0, coord2index( rlat1, grid@startlat, grid@dlat ) -1 /) )
        iy2 = min( (/ grid@ny-1, coord2index( rlat2, grid@startlat, grid@dlat ) -1 /) )
        ; print (ix1 + " " + ix2 + " " + iy1 + " " + iy2 )

    end if;;


    if( iy1 .ne. 0 .or. ix1 .ne. 0 .or.  \
        iy2 .ne. ny-1 .or. ix2 .ne. nx-1 )then
        ; field := field(iy1:iy2,ix1:ix2)
        if( ndims .eq. 2 )then;;
            field_out = field(iy1:iy2,ix1:ix2)

        else if( ndims .eq. 3 )then;;
            field_out = field(:,iy1:iy2,ix1:ix2)

        end if;;
        end if;;
        x = reshape( field@lon2d, (/ny,nx/) )
        y = reshape( field@lat2d, (/ny,nx/) )
        ; field@lon2d := x(iy1:iy2,ix1:ix2)
        ; field@lat2d := y(iy1:iy2,ix1:ix2)
        field_out@lon2d := x(iy1:iy2,ix1:ix2)
        field_out@lat2d := y(iy1:iy2,ix1:ix2)
    else
        field_out = field
        draw_domain_border = True
    end if
    field_out@draw_domain_border = draw_domain_border
    printVarSummary(field_out)

    return field_out

end;;

