

undef("get_inflection")
function get_inflection( digit, lang )
local oneItem, inflection, lastdigit, notTeen
begin;;

    lastdigit = mod(digit,10)

    if( digit .ge. 11 .and. digit .le. 19 )then;;
        notTeen = False
    else
        notTeen = True
    end if;;

    if( lastdigit .eq. 1 .and. notTeen )then;;
        oneItem = True
        inflection = ""
    else if( (lastdigit .eq. 2 .or. lastdigit .eq. 3 .or. lastdigit .eq. 4) .and. notTeen )then;;
        oneItem = False
        if( lang .eq. "RU" )then;;
            inflection = "a"
        else
            inflection = "s"
        end if;;
    else
        oneItem = False
        if( lang .eq. "RU" )then;;
            inflection = "nc"
        else
            inflection = "s"
        end if;;
    end if;;
    end if;;

    return inflection
end;;

undef("field_attributes")
function field_attributes (name,field)
begin;;

    if( name .eq. "ZMAX" )then
        field@name = "Zmax"
        field@long_name = "maximum of radar reflectivity in columns"
        field@unit = "dbz"

    else if( name .eq. "R" )then
        field@name = "R"
        field@long_name = "Precipitation rate for 10 minutes"
        field@unit = "mm/h"

    end if
    end if

    if( name .eq. "T_2M" )then;;
        ; field = field - 273.15
        field@long_name = "temperature at 2m"
        field@units = "C"

    else if( name .eq. "VMAX10M" .or. name .eq. "VMAX_10M" )then;;
        field@long_name = "maximum 10m wind gust"
        field@units = "m/s"

    else if( name .eq. "Prec03h" .or. name .eq. "TOT_PREC" )then;;
        field@long_name = "total precipitation amount"
        field@units = "mm"

    else if( name .eq. "PMSL" )then;;
        ; field@long_name = "Pressure at MSL"
        field@long_name = "mean sea level pressure"
        field@units = "Pa"

    else if( str_upper(name) .eq. "U_10M" )then;;
        field@long_name = "U-component of wind "
        field@units = "m/s"

    else if( str_upper(name) .eq. "V_10M" )then;;
        field@long_name = "V-component of wind "
        field@units = "m/s"

    else if( str_upper(name) .eq. "CLON" )then;;
        field@long_name = "Longitude"
        field@units = "degree"

    else if( str_upper(name) .eq. "CLAT" )then;;
        field@long_name = "Latitude"
        field@units = "degree"

    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;

    return(field)
end;;
