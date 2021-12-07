prompt <-- Creating function GET_SPACE_IDs_BY_ID_R...;

CREATE or REPLACE 
   FUNCTION GET_SPACE_IDs_BY_ID_R(IDtemp IN integer,
                                       R IN integer)
   RETURN SYS_REFCURSOR
   IS
      recordSet SYS_REFCURSOR;
      a1 integer;
      b1 integer;
      a2 integer;
      b2 integer;

   BEGIN
      SELECT X1,Y1,X2,Y2 into a1,b1,a2,b2 FROM QUARE_DETAILS WHERE ID=IDtemp;
      OPEN recordSet FOR
      SELECT
         ID,X1,X2 
      FROM 
         QUARE_DETAILS 
      WHERE
         X1 BETWEEN (a1-R) AND (a2+R-1) AND Y1 BETWEEN (b1-R) AND (b2+R-1);  
      RETURN(recordSet);
   END;
/
show errors;