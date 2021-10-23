USE [CountryInfo]
/* select * from [Countries2]
    except
select * from [Countries]; */

DECLARE @CountriesCount INT = (SELECT COUNT(*) FROM [Countries] AS c)
DECLARE @Countries2Count INT = (SELECT COUNT(*) FROM [Countries2] AS c2)

SELECT 'mismatch'
FROM [Countries] AS c FULL JOIN [Countries2] c2 ON c.[alpha3Code] = c2.[alpha3Code]
WHERE (@CountriesCount = @Countries2Count) AND
    (
        c.[name] <> c2.[name]
        OR c.[nativeName] <> c2.[nativeName]
        OR c.[alpha2Code] <> c2.[alpha2Code]
        OR c.[area] <> c2.[area]
        OR c.[population] <> c2.[population]
        OR c.[capital] <> c2.[capital]
        OR c.[flag] <> c2.[flag]
        OR c.[location].STEquals(c2.[location]) <> 1
        OR c.[region] <> c2.[region]
        OR c.[timezones] <> c2.[timezones]
    )