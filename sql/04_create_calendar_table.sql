IF OBJECT_ID('Calendar', 'U') IS NOT NULL DROP TABLE Calendar;

CREATE TABLE Calendar ([date] DATE PRIMARY KEY);

DECLARE @StartDate DATE = '1990-01-01', @EndDate DATE = '2025-12-31';
WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO Calendar ([date]) VALUES (@StartDate);
    SET @StartDate = DATEADD(day, 1, @StartDate);
END;
 


SELECT TOP 10000 * FROM Calendar ORDER BY [date] ASC;