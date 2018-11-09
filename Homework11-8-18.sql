--use adventureworks2012

--SET NOCOUNT ON;  

--DECLARE @vendor_id int, @vendor_name nvarchar(50),  
--    @message varchar(80), @product nvarchar(50);  

--PRINT '-------- Vendor Products Report --------';  

--DECLARE vendor_cursor CURSOR FOR   
--SELECT BusinessEntityID, Name  
--FROM Purchasing.Vendor  
--WHERE PreferredVendorStatus = 1  
--ORDER BY BusinessEntityID;  

--OPEN vendor_cursor  

--FETCH NEXT FROM vendor_cursor   
--INTO @vendor_id, @vendor_name  

--WHILE @@FETCH_STATUS = 0  
--BEGIN  
--    PRINT ' '  
--    SELECT @message = '----- Products From Vendor: ' +   
--        @vendor_name  

--    PRINT @message  

--    -- Declare an inner cursor based     
--    -- on vendor_id from the outer cursor.  

--    DECLARE product_cursor CURSOR FOR   
--    SELECT v.Name  
--    FROM Purchasing.ProductVendor pv, Production.Product v
--    WHERE pv.ProductID = v.ProductID AND  
--    pv.BusinessEntityID = @vendor_id  -- Variable value from the outer cursor  

--    OPEN product_cursor  
--    FETCH NEXT FROM product_cursor INTO @product  

--    IF @@FETCH_STATUS <> 0   
--        PRINT '         <<None>>'       

--    WHILE @@FETCH_STATUS = 0  
--    BEGIN  

--        SELECT @message = '         ' + @product  
--        PRINT @message  
--        FETCH NEXT FROM product_cursor INTO @product  
--        END  

--    CLOSE product_cursor  
--    DEALLOCATE product_cursor  
--        -- Get the next vendor.  
--    FETCH NEXT FROM vendor_cursor   
--    INTO @vendor_id, @vendor_name  
--END   
--CLOSE vendor_cursor;  
--DEALLOCATE vendor_cursor;  




-- FIXED CURSOR: 1 & 2 finished

select MONTH(SalesOrderHeader.OrderDate) from sales.SalesOrderHeader


use adventureworks2012

SET NOCOUNT ON;  


DECLARE @Territory_id int, @Territory_name nvarchar(50),  
    @message varchar(80), @Sales nvarchar(50), @Year int = '2005';  

PRINT '-------- Territory Sales Report --------';  

DECLARE Territory_cursor CURSOR FOR   
SELECT TerritoryID, Name  
FROM Sales.SalesTerritory 
--WHERE PreferredVendorStatus = 1  
ORDER BY TerritoryID
OPEN Territory_cursor  

FETCH NEXT FROM Territory_cursor   
INTO @Territory_id, @Territory_name  

WHILE @@FETCH_STATUS = 0  
BEGIN  
    PRINT ' '  
    SELECT @message = '----- Sales From: ' +   
        @Territory_name  

    PRINT @message  

    -- Declare an inner cursor based     
    -- on Territory_id from the outer cursor.  



	DECLARE Sales_cursor CURSOR FOR   
    SELECT SOH.SalesOrderID 
    FROM Sales.SalesTerritory ST, Sales.SalesPerson SP, Sales.SalesOrderHeader SOH
    WHERE SOH.TerritoryID = ST.TerritoryID AND Year(SOH.Orderdate) = @Year AND
    SOH.TerritoryID = @Territory_id  -- Variable value from the outer cursor  


    OPEN Sales_cursor  
    FETCH NEXT FROM Sales_cursor INTO @Sales 

    IF @@FETCH_STATUS <> 0   
        PRINT '         <<None>>'       

    WHILE @@FETCH_STATUS = 0  
    BEGIN  

        SELECT @message = '         ' + @Sales  
        PRINT @message  
        FETCH NEXT FROM Sales_cursor INTO @Sales  
        END  

    CLOSE Sales_cursor  
    DEALLOCATE Sales_cursor  
        -- Get the next vendor.  
    FETCH NEXT FROM Territory_cursor   
    INTO @Territory_id, @Territory_name  
END   
CLOSE Territory_cursor;  
DEALLOCATE Territory_cursor;  

