;------------------------------------------------------------------
; Library for plotting points(city) from csv-file on geografical map.
; Authors: Denis Blinov, denisblinov@ya.ru. 2017 - ...
;------------------------------------------------------------------

function select_point(list_points, area)
begin;;

    select = True
    select@nposlabels = 1
    select@city = list_points@Name

    ; rlpointlabel = (/"Moscow","Kazan"/)
    ; llpointlabel = (/"Tver","Ryazan"/)

    return select

end;;

undef("read_points_coord")
function read_points_coord()
begin;;

    file_point = "$lib_NCL/points/all_point.txt"
    ; if( listPoints .eq. "all" ) then
        ; file_point = "all_point.txt"
    ; else
        ; file_point = "all_point.txt"
    ; end if
    z1 = asciiread(file_point, -1, "string" )

    if (.not. isvar("npoints")) then      ; data from command line
        npoints = dimsizes(z1)-1
    end if

    ; indexX = toint( str_get_field(z1(2:),2," ") )
    ; indexY = toint( str_get_field(z1(2:),3," ") )
    ; pointName = "  " + str_get_field(z1(1:),1," ")
    point = True
    point@Name = str_get_field(z1(1:),1," ")
    point@lat  = tofloat( str_get_field(z1(1:),2," ") )
    point@lon  = tofloat( str_get_field(z1(1:),3," ") )
    point@NameRu = str_get_field(z1(1:),4," ")
    ; print ( point@Name + " " + point@lat + " " + point@lon )

    return point

end;;

; undef("draw_city")
; procedure draw_city( points, wks, plot )
begin;;

    ; table
    ; namepoint lat lon heigth namepoint_ru namepoint_wmo

    ; rlpointlabel = get_city( area, "right" )
    ; z1 = asciiread("list_point."+data+".txt", -1, "string" )
    ; print( "listPoints: " + listPoints )
    file_point = "$lib_NCL/points/all_point.txt"
    ; if( listPoints .eq. "all" ) then
        ; file_point = "all_point.txt"
    ; else
        ; file_point = "all_point.txt"
    ; end if
    z1 = asciiread(file_point, -1, "string" )

    if (.not. isvar("npoints")) then      ; data from command line
        npoints = dimsizes(z1)-1
    end if

    ; indexX = toint( str_get_field(z1(2:),2," ") )
    ; indexY = toint( str_get_field(z1(2:),3," ") )
    ; pointName = "  " + str_get_field(z1(1:),1," ")
    point = True
    point@Name = str_get_field(z1(1:),1," ")
    point@lat  = tofloat( str_get_field(z1(1:),2," ") )
    point@lon  = tofloat( str_get_field(z1(1:),3," ") )
    point@NameRu = str_get_field(z1(1:),4," ")
    ; print ( point@Name + " " + point@lat + " " + point@lon )

    if( listPoints .eq. "all" ) then
        file_point_labels = "$lib_NCL/points/ETR.csv"
    else if( listPoints .eq. "Uni_Krs" ) then
        file_point_labels = "$lib_NCL/points/Uni_Krs.csv"
    ; else if( listPoints .eq. "RussiaKr" ) then
        ; file_point_labels = "$lib_NCL/points/RussiaKr.csv"
    else
        file_point_labels = "$lib_NCL/points/" + listPoints + ".csv"
        ; if( .not. ismissing(listPoints) .and. isfilepresent("$lib_NCL/points/listPoints" ) )then
        if( .not.  fileexists( file_point_labels ) )then
            file_point_labels = "$lib_NCL/points/ETR.csv"
        end if

    ; end if
    end if
    end if
    print("file_point_labels: " + file_point_labels)

    z2 = asciiread(file_point_labels, -1, "string" )
    nlabels = dimsizes(z2) - 1
    labels = True
    labels@id    = str_get_field(z2(1:),1," ")
    labels@name  = str_get_field(z2(1:),2," ")
    labels@pos   = str_get_field(z2(1:),3," ")
    labels@type  = str_get_field(z2(1:),4," ")
    labels@size  = str_get_field(z2(1:),5," ")
    labels@color = str_get_field(z2(1:),6," ")
    labels@lon = new(nlabels,float)
    labels@lat = new(nlabels,float)
    labels@startIndex = new(nlabels,integer)
    labels@endIndex   = new(nlabels,integer)
    res_mk     = True
    res_mk@color    = new(nlabels,string)
    res_mk@pos      = new(nlabels,string)
    res_mk@type     = new(nlabels,string)
    res_mk@size     = new(nlabels,string)
    ; print(labels)

    ; print( "config@layers in list_points.ncl: " + config@layers )

    res_pm1 = True
    
    if( str_get_cols(config@layers,0,2) .eq. "SDI" )then
        res_pm1@gsMarkerColor = "ForestGreen"
    else
        res_pm1@gsMarkerColor = "red"
    end if
    res_pm1@gsMarkerIndex = 16
    res_pm1@gsMarkerSizeF = 0.005
    res_pm1@gsLineThicknessF = 3.0

    ; res_pm1@gsMarkerColor = "black"

    ; res_lbmk   = new(nlabels,logical)
    ; print( res_mk )

    res_pl1 = True
    ; res_pl1@txFontColor = "blue"
    res_pl1@txFontColor = "black"
    ; res_pl1@txJust = "CenterLeft"
    res_pl1@txJust = "TopLeft"
    ; res_pl1@txFontHeightF = 0.012
    res_pl1@txFontHeightF = 0.010
    ; res_pl1@txFontHeightF = 0.016 ; for printing big labels of city VFO

    ; res_lbmk(:) = res_pl1

    ; sp = select_point(point, "sSib")
    ; print (sp)

    select = True
    ; select@nposlabels = 1
    do i = 0,npoints - 1
        do j = 0,nlabels - 1
            if( labels@id(j) .eq. point@Name(i) )then
                labels@lon(j) = point@lon(i)
                labels@lat(j) = point@lat(i)
            end if
        end do
    end do

    labels@pos   = where(labels@pos   .eq. "-", res_pl1@txJust, labels@pos)
    labels@type  = where(labels@type  .eq. "-", res_pm1@gsMarkerIndex, labels@type)
    labels@color = where(labels@color .eq. "-", res_pm1@gsMarkerColor, labels@color)
    labels@size  = where(labels@size  .eq. "-", res_pm1@gsMarkerSizeF, labels@size)
    ; print(labels)
    ; labels@nTypeOfMarkers = 1
    imarker = 0
    ; res_mk@color(0) = "red"
    ; res_mk@pos(0)   = "TopLeft"
    do i = 0,nlabels - 1
        if ( i .eq. 0)then
            labels@startIndex(0) = 0
            res_mk@color(imarker) = labels@color(i)
            res_mk@pos(imarker)   = labels@pos(i)
            res_mk@type(imarker)  = labels@type(i)
            res_mk@size(imarker)  = labels@size(i)

        ; else if ( i .eq. nlabels - 1 )then
            ; labels@endIndex(imarker) = i - 1

        else if( labels@pos(i)   .ne. labels@pos(i-1)   .or. \
            labels@type(i)  .ne. labels@type(i-1)  .or. \
            labels@color(i) .ne. labels@color(i-1) .or. \
            labels@size(i)  .ne. labels@size(i-1)  )then

            labels@endIndex(imarker) = i - 1

            imarker = imarker + 1
            res_mk@color(imarker) = labels@color(i)
            res_mk@pos(imarker)   = labels@pos(i)
            res_mk@type(imarker)  = labels@type(i)
            res_mk@size(imarker)  = labels@size(i)

            labels@startIndex(imarker) = i

            if ( i .eq. nlabels - 1 )then
                labels@endIndex(imarker) = i
            end if

        else 
            labels@endIndex(imarker) = i

        end if
        end if 

    end do
    labels@nTypeOfMarkers = imarker + 1

    ; print(labels)
    ; print(labels@color)
    ; print( res_mk )
    ; exit

    ipoint  = new(labels@nTypeOfMarkers,graphic)
    ; ipoint  = new(labels@nTypeOfMarkers,integer)
    ; rlpoint = new(labels@nTypeOfMarkers,graphic)
    ; print("before marker")
    do i = 0,labels@nTypeOfMarkers - 1
        ; res_pm1@gsMarkerColor = labels@color(i)
        res_pm1@gsMarkerIndex := res_mk@type(i)
        res_pm1@gsMarkerColor = res_mk@color(i)
        res_pm1@gsMarkerSizeF := res_mk@size(i)
        res_pl1@txJust = res_mk@pos(i)
        ; print(res_pm1)
        i1 = labels@startIndex(i)
        i2 = labels@endIndex(i)
        ; print (point@lon(i1:i2))
        ; print( "i: " + i1+" "+i2 + " " +  res_mk@pos(i) )
        ipoint(i)   = gsn_add_polymarker(wks,plot,labels@lon(i1:i2),labels@lat(i1:i2),res_pm1)
        ; print (typeof(ipoint))
        if( res_mk@pos(i) .eq. "TopRight" .or. res_mk@pos(i) .eq. "BottomRight" )then
            suff = "  "
            pref = ""
        else
            suff = ""
            pref = "  "
        end if
        labels@name(i1:i2) = pref + labels@name(i1:i2) + suff
        ; print( labels@name(i1:i2) + " " + i )
        rlpoint  := gsn_add_text(wks,plot, labels@name(i1:i2), labels@lon(i1:i2),labels@lat(i1:i2),res_pl1)
        ; print( rlpoint )
        ; print( ipoint )
    end do

end;;
