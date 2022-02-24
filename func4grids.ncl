
;-----------------------------------------------------------------------------
undef("get_domain")
function get_domain( name )
begin;;
;--------------
; Example:
; grid = get_domain( domains )
; -------------

    domain = True

    if( name .eq. "cm07etr" )then;;
        domain@nx = 700
        domain@ny = 620
        domain@dlon = 0.0625
        domain@dlat = 0.0625
        
        domain@startlat = -19.0
        domain@startlon = -19.0

        domain@pollat = 35
        domain@pollon = -145
        domain@polgam = 0.0
        domain@dkm    = 7

        domain@kelm_tot   = 40

    else if( name .eq. "cm13ena" )then
        domain@nx = 1000
        domain@ny = 500
        domain@dlon = 0.12
        domain@dlat = 0.12
        domain@startlat = -30.0
        domain@startlon = -60.0
        domain@pollat = 25
        domain@pollon = -90
        domain@polgam = 0.0
        domain@dkm    = 13

        domain@kelm_tot   = 40

    ; else if( name .eq. "cm06ena" )then
    else if( str_get_cols(name,0,6) .eq. "cm06ena" )then
        domain@nx = 2000
        domain@ny = 1000
        domain@dlon = 0.06
        domain@dlat = 0.06
        domain@startlat = -30.0
        domain@startlon = -60.0
        domain@pollat = 25
        domain@pollon = -90
        domain@polgam = 0.0
        domain@dkm    = 6

        domain@kelm_tot   = 40

    else if( name .eq. "cm02cfo" )then
        domain@nx = 420
        domain@ny = 470
        domain@dlon = 0.02
        domain@dlat = 0.02
        domain@startlat = -4.5
        domain@startlon = -3.0
        domain@pollat = 35
        domain@pollon = -145
        domain@polgam = 0.0
        domain@dkm    = 2.2

        domain@kelm_tot   = 50

    else if( name .eq. "cm02bel" )then
        domain@nx = 820
        domain@ny = 920
        domain@dlon = 0.02
        domain@dlat = 0.02
        domain@startlat = -3.6
        domain@startlon = -36.0
        domain@pollat = 25
        domain@pollon = -90
        domain@polgam = 0.0
        domain@dkm    = 2.2

        domain@kelm_tot   = 50

    else if( name .eq. "cm02etr" )then
        domain@nx = 1200
        domain@ny = 1400
        domain@dlon = 0.02
        domain@dlat = 0.02
        domain@startlat = -13.50
        domain@startlon = -38.0
        domain@pollat = 25
        domain@pollon = -90
        domain@polgam = 0.0
        domain@dkm    = 2.2

        domain@kelm_tot   = 50

    else if( name .eq. "cm02sfo" )then
        domain@nx = 420
        domain@ny = 470
        domain@dlon = 0.02
        domain@dlat = 0.02
        domain@startlat = -16.5
        domain@startlon = -1.0
        domain@pollat = 35
        domain@pollon = -145
        domain@polgam = 0.0
        domain@dkm    = 2.2

        domain@kelm_tot = 50

    else if( name .eq. "cm02vfo" )then
        domain@nx = 470
        domain@ny = 450
        domain@dlon = 0.02
        domain@dlat = 0.02
        domain@startlat = -8.0
        domain@startlon = -26.0
        domain@pollat = 25
        domain@pollon = -90
        domain@polgam = 0.0
        domain@dkm    = 2.2

        domain@kelm_tot   = 50

    else if( name .eq. "cm02krs" )then
        domain@nx = 396
        domain@ny = 326
        domain@dlon = 0.02
        domain@dlat = 0.02
        domain@startlat = -11.96
        domain@startlon = -2.46
        domain@pollat   = 25
        domain@pollon   = -90
        domain@polgam   = 0.0
        domain@dkm      = 2.2
        domain@dhm      = 22

        domain@kelm_tot = 50

    else if( name .eq. "cm01sfo" )then
        domain@nx = 190
        domain@ny = 190
        domain@dlon = 0.01
        domain@dlat = 0.01
        domain@startlat = -8.4
        domain@startlon = -34.70
        domain@pollat = 25
        domain@pollon = -90
        domain@polgam = 0.0
        domain@dkm    = 1.1

        domain@kelm_tot = 50

    else if( name .eq. "cm01kerch" )then
        domain@nx = 300
        domain@ny = 250
        domain@dlon = 0.01
        domain@dlat = 0.01
        domain@startlat = -10.8
        domain@startlon = -0.4
        domain@pollat = 35
        domain@pollon = -145
        domain@polgam = 0.0
        domain@dkm    = 1.1

        domain@kelm_tot = 50

    else if( name .eq. "cm01krs_ext" )then ; preliminary
        domain@nx = 400
        domain@ny = 400
        domain@dlon = 0.01
        domain@dlat = 0.01
        domain@startlat = -11.00
        domain@startlon = -0.50
        domain@pollat = 25
        domain@pollon = -90
        domain@polgam = 0.0
        domain@dkm    = 1.1

        domain@kelm_tot = 50

    else if( name .eq. "cm01krs" )then ; preliminary
        domain@nx = 300
        domain@ny = 300
        domain@dlon = 0.01
        domain@dlat = 0.01
        domain@startlat = -10.50
        domain@startlon =  0.00
        domain@pollat = 25
        domain@pollon = -90
        domain@polgam = 0.0
        domain@dkm    = 1.1

        domain@kelm_tot = 50

    else if( str_get_cols(name,0,6) .eq. "cm01msk" )then
        domain@dlon = 0.009
        domain@dlat = 0.009
        if( name .eq. "cm01msk.180" )then
            domain@nx = 180
            domain@ny = 180
            domain@startlat = -0.810
            domain@startlon = -0.810
        else                           ; from 2020071606
            domain@nx = 200
            domain@ny = 200
            domain@startlat = -0.900
            domain@startlon = -0.900
        end if
        domain@pollat = 34.3
        domain@pollon = -142.5
        domain@polgam = 0.0
        domain@dkm    = 1.0

        domain@kelm_tot = 50

    else if( name .eq. "cut_cm01msk" )then
        domain@nx = 78
        domain@ny = 105
        domain@dlon = 0.009
        domain@dlat = 0.009
        domain@startlat = -0.585
        domain@startlon = -0.405
        domain@pollat = 34.3
        domain@pollon = -142.5
        domain@polgam = 0.0
        domain@dkm    = 1.0

        domain@kelm_tot = 50

    else if( name .eq. "cm005msk" )then
        domain@nx = 400
        domain@ny = 400
        domain@dlon = 0.0045
        domain@dlat = 0.0045
        domain@startlat = -0.90225
        domain@startlon = -0.90225
        domain@pollat = 34.3
        domain@pollon = -142.5
        domain@polgam = 0.0
        domain@dkm    = 0.5

        domain@kelm_tot = 50

    else if( name .eq. "cm01cfo" )then; belg
        domain@nx = 780
        domain@ny = 780
        domain@dlon = 0.01
        domain@dlat = 0.01
        domain@startlat = -4.35
        domain@startlon = -2.85
        domain@pollat = 35
        domain@pollon = -145
        domain@polgam = 0.0
        domain@dkm    = 1.1

        domain@kelm_tot = 50

    else if( name .eq. "cm01belg" )then
        domain@nx = 396
        domain@ny = 396
        domain@dlon = 0.01
        domain@dlat = 0.01
        domain@startlat = -1.96
        domain@startlon = -1.46
        domain@pollat = 39.40
        domain@pollon = -143.42
        domain@polgam = 0.0
        domain@dkm    = 1.1

        domain@kelm_tot = 50

    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
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

    if( name .eq. "cm01kirov" )then ; preliminary
        domain@nx = 700
        domain@ny = 700
        domain@dlon = 0.009
        domain@dlat = 0.009
        domain@startlat = -3.982
        domain@startlon = -3.482
        domain@pollat = 31.5
        domain@pollon = -130
        domain@polgam = 0.0
        domain@dkm    = 1.0

    end if

    if( name .eq. "ext_cm07etr" )then;;
        domain@nx = 721
        domain@ny = 641
        domain@dlon = 0.0625
        domain@dlat = 0.0625
        
        domain@startlat = -20.0
        domain@startlon = -20.0

        domain@pollat = 35
        domain@pollon = -145
        domain@polgam = 0.0
        domain@dkm    = 7

    else if( name .eq. "ext_cm13ena" )then
        domain@nx = 1004
        domain@ny = 504
        domain@dlon = 0.12
        domain@dlat = 0.12
        domain@startlat = -30.24
        domain@startlon = -60.24
        domain@pollat = 25
        domain@pollon = -90
        domain@polgam = 0.0
        domain@dkm    = 13

    else if( name .eq. "ext_cm14sib" )then
        domain@nx = 384
        domain@ny = 272
        domain@dlon = 0.125
        domain@dlat = 0.125
        domain@startlat = -18.00
        domain@startlon = -24.00
        domain@pollat = 30
        domain@pollon = -85
        domain@polgam = 0.0
        domain@dkm    = 13

    end if
    end if
    end if;;

    domain@endlat = domain@startlat + domain@dlat * (domain@ny-1)
    domain@endlon = domain@startlon + domain@dlon * (domain@nx-1)

    if( isatt(domain,"kelm_tot"))then
        if( domain@kelm_tot .eq. 40 )then
            domain@vcoord = (/                  \
                22700.00, 20800.00,            \
                19100.00, 17550.00, 16150.00,  \
                14900.00, 13800.00, 12785.00,  \
                11875.00, 11020.00, 10205.00,  \
                9440.00,  8710.00,  8015.00,  \
                7355.00,  6725.00,  6130.00,  \
                5565.00,  5035.00,  4530.00,  \
                4060.00,  3615.00,  3200.00,  \
                2815.00,  2455.00,  2125.00,  \
                1820.00,  1545.00,  1295.00,  \
                1070.00,   870.00,   695.00,  \
                542.00,   412.00,   303.00,  \
                214.00,   143.00,    89.00,  \
                    49.00,    20.00,     0.00  /)

        else if( domain@kelm_tot .eq. 50 )then
            domain@vcoord = (/                  \
                22000.00, 21000.00, 20028.57,  \
                19085.36, 18170.00, 17282.14,  \
                16421.43, 15587.50, 14780.00,  \
                13998.57, 13242.86, 12512.50,  \
                11807.14, 11126.43, 10470.00,  \
                9837.50,  9228.57,  8642.86,  \
                8080.00,  7539.64,  7021.43,  \
                6525.00,  6050.00,  5596.07,  \
                5162.86,  4750.00,  4357.14,  \
                3983.93,  3630.00,  3295.00,  \
                2978.57,  2680.36,  2400.00,  \
                2137.14,  1891.43,  1662.50,  \
                1450.00,  1253.57,  1072.86,  \
                907.50,   757.14,   621.43,  \
                500.00,   392.50,   298.57,  \
                217.86,   150.00,    94.64,  \
                    51.43,    20.00,     0.00   /)

        end if
        end if
        domain@vcoord_thick = (domain@vcoord(0:domain@kelm_tot-1) - domain@vcoord(1:domain@kelm_tot) ) * 0.5
        domain@vcoord_hfl = (domain@vcoord(0:domain@kelm_tot-1) + domain@vcoord(1:domain@kelm_tot) ) * 0.5
    end if

    return domain

end;;
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
undef("rot2geo")
function  rot2geo ( phirot, rlarot, pollat, pollon, polgam )
begin;;
;-----------------------------------------------------------------------------
;
; Description:
;   This function converts phi,lambda from one rotated system to phi, 
;   lambda in another system. If the optional argument polgam is present, 
;   the other system can also be a rotated one, where polgam is the angle 
;    between the two north poles.
;   If polgam is not present, the other system is the real geographical
;   system.
;
; Method:
;   Transformation formulas for converting between these two systems.
;
;-----------------------------------------------------------------------------
;
; Declarations:
;
;-----------------------------------------------------------------------------

; Parameter list:
;REAL (KIND=wp),     INTENT (IN)      ::        &
;  pollat,   & ! latitude of the rotated north pole
;  pollon,   & ! longitude of the rotated north pole
;  phirot,   & ! latitude in the rotated system
;  rlarot      ! longitude in the rotated system

;REAL (KIND=wp),     INTENT (IN)      ::        &
;  polgam      ! angle between the north poles of the systems

;REAL (KIND=wp)                       ::        &
  ; phirot2phi  ; latitude in the geographical system

 ; rlarot2rla  ; longitude in the geographical system

; Local variables

  ; zsinpol, zcospol, zphis, zrlas, zarg, zgam, zlampol, zarg1, zarg2

; REAL (KIND=wp),     PARAMETER        ::        &
  zrpi18 = 57.2957795
  zpir18 = 0.0174532925

;------------------------------------------------------------------------------

; Begin function phirot2phi

  zsinpol     = sin (zpir18 * pollat)
  zcospol     = cos (zpir18 * pollat)

  zlampol = zpir18 * pollon
  zphis       = zpir18 * phirot
  if (max (rlarot) .gt. 180.0) then
    zrlas = rlarot - 360.0
  else
    zrlas = rlarot
  end if
  zrlas       = zpir18 * zrlas

  if (polgam .ne. 0.0) then
    zgam  = zpir18 * polgam
    zarg  = zsinpol*sin (zphis) +                                            \
        zcospol*cos(zphis) * ( cos(zrlas)*cos(zgam) - sin(zgam)*sin(zrlas) )

    zarg1   = sin (zlampol) *                                                \
      (- zsinpol*cos(zphis) * (cos(zrlas)*cos(zgam) - sin(zrlas)*sin(zgam))  \
       + zcospol * sin(zphis))                                               \
    - cos (zlampol)*cos(zphis) * (sin(zrlas)*cos(zgam) + cos(zrlas)*sin(zgam))

    zarg2   = cos (zlampol) *                                                \
      (- zsinpol*cos(zphis) * (cos(zrlas)*cos(zgam) - sin(zrlas)*sin(zgam))  \
       + zcospol * sin(zphis))                                               \
    + sin (zlampol)*cos(zphis) * (sin(zrlas)*cos(zgam) + cos(zrlas)*sin(zgam))

  else
    zarg  = zcospol * cos (zphis) * cos (zrlas) + zsinpol * sin (zphis)
    
    zarg1   = sin (zlampol) * (-zsinpol * cos(zrlas) * cos(zphis)  +    \
                                zcospol *              sin(zphis)) -    \
              cos (zlampol) *             sin(zrlas) * cos(zphis)
    zarg2   = cos (zlampol) * (-zsinpol * cos(zrlas) * cos(zphis)  +    \
                                zcospol *              sin(zphis)) +    \
              sin (zlampol) *             sin(zrlas) * cos(zphis)

  end if

  zarg2 = where(zarg2 .eq. 0.0, 1.0E-20, zarg2)
  ; if (zarg2 == 0.0) then
    ; zarg2 = 1.0E-20
  ; end if

  phirot2phi  = zrpi18 * asin (zarg)

  rlarot2rla = zrpi18 * atan2(zarg1,zarg2)

  return(/phirot2phi,rlarot2rla/)

end;;
;-----------------------------------------------------------------------------


;-----------------------------------------------------------------------------
undef("UVrot2UVgeogr") 
function UVrot2UVgeogr (urot, vrot, glat, glon, pollat, pollon)
begin;;
;-------------------------------------------------
; Usage:
;-------------------------------------------------


;   Convert the u- and v-components from rotate to geografical grid
;   urot   , vrot   ,     & ! wind components in the rotated system
;   glat, glon,     & ! coordinates in the true geographical system
;   pollat, pollon    ! latitude and longitude of the north pole of the rotated grid

;   pollat=35; pollon=-145;; ETR
;   pollat=25; pollon=-90;; ENA

    zrpi18 = 57.2957795
    zpir18 = 0.0174532925

    zsinpol = sin(pollat * zpir18)
    zcospol = cos(pollat * zpir18)

    zlonp   = (pollon-glon) * zpir18
    zlat    =         glat  * zpir18

    zarg1   = zcospol * sin(zlonp)
    zarg2   = zsinpol * cos(zlat) - zcospol * sin(zlat) * cos(zlonp)
    znorm   = 1.0 / sqrt(zarg1^2 + zarg2^2)

    if( dimsizes(dimsizes(urot)) .le. 2 )then;;
        ; print("rotation for 2dims field")
        Ugeogr =   urot * zarg2 * znorm + vrot * zarg1 * znorm
        Vgeogr = - urot * zarg1 * znorm + vrot * zarg2 * znorm

    else if( dimsizes(dimsizes(urot)) .eq. 3 )then;;
        ; print("rotation for 3dims field")
        ; Ugeogr = urot * urot@_FillValue
        ; Ugeogr = urot * 10000000
        ; Ugeogr = urot@_FillValue
        Ugeogr = new((/dimsizes(urot)/),float,urot@_FillValue)
        Vgeogr = new((/dimsizes(vrot)/),float,vrot@_FillValue)
        ; print(dimsizes(urot))
        copy_VarMeta(urot,Ugeogr)
        copy_VarMeta(vrot,Vgeogr)
        ; printVarSummary(Ugeogr)
        ; printMinMax(Ugeogr,0)
        ; printMinMax(urot,0)
        do i=0,dimsizes(urot(:,0,0))-1
            Ugeogr(i,:,:) =   urot(i,:,:) * zarg2 * znorm + vrot(i,:,:) * zarg1 * znorm
            Vgeogr(i,:,:) = - urot(i,:,:) * zarg1 * znorm + vrot(i,:,:) * zarg2 * znorm
        end do
        ; printMinMax(Ugeogr,0)

    end if;;
    end if;;

    return (/Ugeogr,Vgeogr/)
end;;

;-----------------------------------------------------------------------------
undef("get_coordinate_domain")
function get_coordinate_domain( name )
begin;;

    grid = get_domain( name )
    ; print ( grid )

    lonrot = new((/grid@ny,grid@nx/),float)
    latrot = new((/grid@ny,grid@nx/),float)

    ; do j = 0, grid@ny-1
        ; lonrot(j,0:grid@nx-1) = fspan(grid@startlon,grid@endlon,grid@nx)
    ; end if
    ; do i = 0, grid@nx-1
        ; latrot(0:grid@ny-1,i) = fspan(grid@startlat,grid@endlat,grid@ny)
    ; end if
    do j = 0, grid@ny-1
        latrot(j,:) = grid@startlat + grid@dlat*(j-1)
    end do
    do i = 0, grid@nx-1
        lonrot(:,i) = grid@startlon + grid@dlon*(i-1)
    end do
    ; print(lonrot)

    geo = rot2geo( latrot, lonrot, grid@pollat, grid@pollon, 0.0 )
    ; print (geo)

    ; return (/latrot,lonrot/)
    return geo

end;;
;-----------------------------------------------------------------------------



undef("get_angle_rotation")
function get_angle_rotation( domain )
begin;;
    ; load "$lib_NCL/func4grids.ncl"

    print("get domain: " + isdefined("get_domain"))
    grid = get_domain( domain )
    geoCoord = get_coordinate_domain( domain )
    lat2d = geoCoord(0,:,:)
    lon2d = geoCoord(1,:,:)
    ; u@lat2d = lat2d
    ; u@lon2d = lon2d
    ; printVarSummary(lat2d)
    ; printVarSummary(lon2d)
    ; printMinMax(lat2d,0)
    ; printMinMax(lon2d,0)

    u = new((/grid@ny,grid@nx/),float)
    ; u!0 = "g10_x_0"
    ; u!1 = "g10_y_1"
    ; u@coordinates = " g10_x_0 g10_y_1"

    ; u(:,:) = 5
    u(:,:) = 0
    v = u + 5
    ; v = u * 0
    ; v = u * 1
    ; printVarSummary(u)

    uvgeogr  = UVrot2UVgeogr(u, v, lat2d, lon2d, grid@pollat, grid@pollon)
    printVarSummary(uvgeogr)
    ugeogr   = uvgeogr(0,:,:)
    vgeogr   = uvgeogr(1,:,:)

    printMinMax(u,0)
    printMinMax(v,0)
    printMinMax(ugeogr,0)
    printMinMax(vgeogr,0)

    wDir      = wind_direction(u , v,0)         - 180
    wDirGeogr = wind_direction(ugeogr,vgeogr,0) - 180
    printMinMax(wDir,0)
    printMinMax(wDirGeogr,0)
    printMinMax(wDir-wDirGeogr,0)

    rotAngle = wDir - wDirGeogr
    rotAngle!0 = "g10_x_0"
    rotAngle!1 = "g10_y_1"
    rotAngle@coordinates = " g10_x_0 g10_y_1"
    rotAngle@lat2d = lat2d
    rotAngle@lon2d = lon2d

    return(rotAngle)

end;;

;-----------------------------------------------------------------------------


;----------------------------------------------------------------------
undef("lambert_xy2geogr")
function lambert_xy2geogr( x, y, latline1, latline2, OrigLon, OrigLat )
begin;;

    ; pi  = get_pi(0.0)
    pi  = 4.d * atan( 1.d )
    ; print( "pi: " + pi )

    aveR = 1.0
    aveR = 6371.302 ; Radius or Earth Shphere

    ; degree to radian
    refLon0 =  OrigLon * pi/180
    refLat0 =  OrigLat * pi/180
    ; stdlat1 =  30.0 * get_d2r(0.0)
    stdlat1 =  latline1 * pi/180
    stdlat2 =  latline2 * pi/180
    ; print ( stdlat1 + " " + stdlat2 )

    ; --- example from book ----
    ; refLon0 =  -96.0 * pi/180
    ; refLat0 =   23.0 * pi/180
    ; x = 0.2966785
    ; y = 0.2462112
    ; x = 0.0
    ; y = 0.0
    ; stdlat1 =  33.0 * pi/180
    ; stdlat2 =  45.0 * pi/180

    n = log( cos(stdlat1) / cos(stdlat2) ) / log( tan(0.25 * pi + 0.5 * stdlat2 )/ tan(0.25 * pi + 0.5 * stdlat1 ) )
    ; print( "n: " + n )
    F = ( cos(stdlat1)* (tan(0.25 * pi + 0.5 * stdlat1 ))^n ) / n
    ; print( "F: " + F )
    p0 = aveR * F * tan(0.25 * pi + 0.5 * refLat0 )^(-n)
    ; print( "p0: " + p0 )

    Theta = atan(x / (p0 - y) )
    ; print( "Theta: " + Theta )

    p = sign_f90(1,n) * ( x^2 + ( p0 - y )^2 )^0.5
    ; print( "p: " + p )
    ; p = (n/abs(n))    * ( x^2 + ( p0 - y )^2 )^0.5
    ; print( "p: " + p )

    lon = refLon0 + Theta / n
    lat = 2 * atan( ( aveR * F/p )^(1/n)  ) - 0.5 * pi

    ; print( "lon: " + lon*180/pi )
    ; print( "lat: " + lat*180/pi )

    return (/ lon*180/pi, lat*180/pi /)

end;;
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
undef("get_coord_Lambert")
procedure get_coord_Lambert( )
begin;;

    nx = 1153
    ny = 1441

    OrigLon =  126.0
    OrigLat =   38.0

    stdlat1 =  30.0
    stdlat2 =  60.0

    x = 0.0
    y = 0.0
    ; ll = lambert_xy2geogr( x, y, stdlat1, stdlat2, OrigLon, OrigLat )

    x = -560.0
    y = -840.0
    ; ll = lambert_xy2geogr( x, y, stdlat1, stdlat2, OrigLon, OrigLat )

    x = -560.0
    y =  600.0
    ; ll = lambert_xy2geogr( x, y, stdlat1, stdlat2, OrigLon, OrigLat )

    x =  592.0
    y =  600.0
    ; ll = lambert_xy2geogr( x, y, stdlat1, stdlat2, OrigLon, OrigLat )

    x =  592.0
    y = -840.0
    ; ll = lambert_xy2geogr( x, y, stdlat1, stdlat2, OrigLon, OrigLat )

    ; xi =  ispan(-560,592,1)
    ; yi =  ispan(-840,600,1)
    ; print( xi )
    xvec = new((/1153,1441/),"integer")
    yvec = new((/1153,1441/),"integer")
    ; do i = -560,592
    do i = 0,nx-1
        xvec(i,:) = i - 560
    end do
    ; do i = -840,600
    do i = 0,ny-1
        yvec(:,i) = i - 840
    end do

    ll = lambert_xy2geogr( xvec, yvec, stdlat1, stdlat2, OrigLon, OrigLat )

    ; print( ll )
    printVarSummary ( ll )

    lon = ll(0,:,:)
    lat = ll(1,:,:)
    printVarSummary ( lon )
    print ( lon(0,0) + " " + lat(0,0) )
    print ( lon(0,ny-1) + " " + lat(0,ny-1) )
    print ( lon(nx-1,ny-1) + " " + lat(nx-1,ny-1) )
    print ( lon(nx-1,0) + " " + lat(nx-1,0) )

    asciiwrite ("lon_gridCmpRadarKorea", lon)
    asciiwrite ("lat_gridCmpRadarKorea", lat)

end;;
;-----------------------------------------------------------------------------


undef("lineCoordinateCenter")
function lineCoordinateCenter( name, plres, wks, plot )
begin;;

    grid = get_domain( name )
    rotPar = new((/2,grid@nx/),float)
    rotMer = new((/2,grid@ny/),float)
    rotPar(0,:) = 0.0
    rotMer(1,:) = 0.0

    rotPar(1,:) = fspan(grid@startlon,grid@endlon,grid@nx)
    rotMer(0,:) = fspan(grid@startlat,grid@endlat,grid@ny)
    ; print (rotMer)

    geo := rot2geo( rotPar(0,:), rotPar(1,:), grid@pollat, grid@pollon, 0.0 )
    parR1 = gsn_add_polyline(wks, plot, geo(1,:), geo(0,:), plres)

    geo := rot2geo( rotMer(0,:), rotMer(1,:), grid@pollat, grid@pollon, 0.0 )
    merR1 = gsn_add_polyline(wks, plot, geo(1,:), geo(0,:), plres)

    return (/parR1,merR1/)

end;;

;-----------------------------------------------------------------------------
undef("get_gridpoint_edge_geo")
function get_gridpoint_edge_geo( name )
begin;;

    grid = get_domain( name )
    ; print ( grid )

    ; latrot = (/grid@startlat,grid@startlat,grid@endlat,grid@endlat,grid@startlat/)
    ; lonrot = (/grid@startlon,grid@endlon,grid@endlon,grid@startlon,grid@startlon/)

    i1 = grid@nx - 1
    i2 = i1 + (grid@ny-2)
    i3 = i2 + grid@nx
    i4 = i3 + (grid@ny-2)
    ; print (i1)
    ; print (i2)
    ; print (i3)
    ; print (i4)

    lonrot = new(grid@nx*2+(grid@ny-2)*2,float)
    latrot = new(grid@nx*2+(grid@ny-2)*2,float)

    lonrot(0:i1)     = fspan(grid@startlon,grid@endlon,grid@nx)
    lonrot(i1+1:i2)  = grid@endlon
    lonrot(i2+1:i3)  = fspan(grid@endlon,grid@startlon,grid@nx)
    lonrot(i3+1:i4)  = grid@startlon
    ; print(lonrot)

    latrot(0:i1)     = grid@startlat
    latrot(i1+1:i2)  = fspan(grid@startlat+grid@dlat,grid@endlat-grid@dlat,grid@ny-2)
    latrot(i2+1:i3)  = grid@endlat
    latrot(i3+1:i4)  = fspan(grid@endlat-grid@dlat,grid@startlat+grid@dlat,grid@ny-2)

    geo = rot2geo( latrot, lonrot, grid@pollat, grid@pollon, 0.0 )
    ; print (geo)

    ; return (/latrot,lonrot/)
    return geo

end;;

undef("geo2rot")
function geo2rot (glon,glat,pollat,pollon,polgam)
local rlon,rlat, lon,lat
begin;;

  degtorad = 0.0174532925
  radtodeg = 57.2957795

  sinpol = sin(pollat*degtorad)
  cospol = cos(pollat*degtorad)

  if( pollon .gt. 180. )then
    pollon1 = (pollon - 360.) * degtorad
  else
    pollon1 = pollon * degtorad
  end if

  lon = where(glon .gt. 180.0, glon - 360., glon)

  lat  = glat * degtorad
  lon  = lon  * degtorad
  arg  = cospol * cos(lat) * cos(lon-pollon1) + sinpol * sin(lat)
  arg1 = sin(lon-pollon1) * cos(lat)
  arg2 = sinpol * cos(lon-pollon1) * cos(lat)-cospol * sin(lat)
  rlat = asin(arg) * radtodeg
  rlon = atan2(arg1,arg2) * radtodeg + 180.0

  rlon = where(rlon .gt. 180.0, rlon - 360., rlon)

  ; print( rlat + " " + rlon  )

  return(/rlat,rlon/)

end;;

undef("rotWind_fromCOSMO2geogr")
function rotWind_fromCOSMO2geogr(urot,vrot,domain)
begin;;
    grid = get_domain( domain )
    ; geoCoord = get_coordinate_domain( domain )
    ; lat2d = geoCoord(0,:,:)
    ; lon2d = geoCoord(1,:,:)
    lat2d = urot@lat2d
    lon2d = urot@lon2d

    ; printVarSummary(lat2d)
    ; printVarSummary(lon2d)

    ; printVarSummary(u500)
    ; printVarSummary(v500)

    uvgeogr = UVrot2UVgeogr (urot, vrot, lat2d, lon2d, grid@pollat, grid@pollon)

    return (uvgeogr)

end;;

;-----------------------------------------------------------------------------

undef("coord2index") 
function coord2index ( coord, base, step )
local index
begin;;

    index = round(( coord - base ) / step, 3) + 1 ; 3 mean integer

    return index

end;;

undef("cosmo_vlevels")
function cosmo_vlevels( numlev )
begin;;

    levels = True

    if( numlev .eq. 50)then;;

        levels@ilev0m     = 49
        levels@ilev500m   = 42 ; or
        ; levels@ilev500m   = 41
        levels@ilev1000m  = 38
        levels@ilev1500m  = 35
        levels@ilev2000m  = 33
        levels@ilev2500m  = 31
        levels@ilev3000m  = 30 ; or
        ; levels@ilev3000m  = 29
        levels@ilev3500m  = 28
        levels@ilev4000m  = 27; or
        ; levels@ilev4000m  = 26
        levels@ilev4500m  = 25
        levels@ilev5000m  = 24
        levels@ilev5500m  = 23
        levels@ilev6000m  = 22

        ;; D. Zakharchenko
        ; v0     = v(50,:,:)
        ; v500   = v(44,:,:)
        ; v1000  = v(40,:,:)
        ; v1500  = v(37,:,:)
        ; v2000  = v(34,:,:)
        ; v2500  = v(33,:,:)
        ; v3000  = v(31,:,:)
        ; v3500  = v(29,:,:)
        ; v4000  = v(28,:,:)
        ; v4500  = v(26,:,:)
        ; v5000  = v(25,:,:)
        ; v5500  = v(23,:,:)
        ; v6000  = v(22,:,:)
    
    else if( numlev .eq. 40 )then;;
        
        levels@ilev0m     = 39
        levels@ilev500m   = 32
        levels@ilev1000m  = 29
        levels@ilev1500m  = 27
        levels@ilev2000m  = 25
        levels@ilev2500m  = 23
        levels@ilev3000m  = 22
        levels@ilev3500m  = 21
        levels@ilev4000m  = 20
        levels@ilev4500m  = 19
        levels@ilev5000m  = 18
        levels@ilev5500m  = 17
        levels@ilev6000m  = 16
        
    end if;;
    end if;;
    return levels

end;;
