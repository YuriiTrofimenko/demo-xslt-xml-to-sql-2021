USE [CountryInfo]
select [name] from [Countries2]
    except
select [name] from [Countries];