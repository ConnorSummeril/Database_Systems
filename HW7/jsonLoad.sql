COPY (SELECT ROW_TO_JSON(entry) 
FROM (SELECT * FROM airline, city, mailing_address) entry) 
TO 'C:\aaaHome\Education\PrinciplesOfDatabaseSystems\HW7\HW7.json';