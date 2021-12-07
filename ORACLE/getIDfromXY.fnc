CREATE OR REPLACE FUNCTION getID(x integer, y integer)
  RETURN integer
IS
   AA integer;
BEGIN
   select ID into AA from QUARE_DETAILS where x between X1 and X2-1 and y between Y1 and Y2-1; 
return(AA);
END;
/
show errors;