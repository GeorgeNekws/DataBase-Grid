prompt <-- Creating function GET_SPACE...;

CREATE or REPLACE 
   FUNCTION GET_SPACE(ID1 IN integer,
                      ID2 IN integer)
   RETURN integer
   IS
      x1 integer;
      y1 integer;
      x2 integer;
      y2 integer;
      sp integer;
   BEGIN
      select X1,Y1 into x1,y1 from QUARE_DETAILS where ID=ID1;
      select X2,Y2 into x2,y2 from QUARE_DETAILS where ID=ID2;
      sp := (x2-x1)*(y2-y1);
      return(sp); 
   END;
/
show errors;