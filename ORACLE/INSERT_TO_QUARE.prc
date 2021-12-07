prompt <-- Creating procedure INSERT_TO_QUARE...;
CREATE OR REPLACE procedure INSERT_TO_QUARE
AS
   i integer := 0;
   j integer := 0;
BEGIN
   FOR i in 0 .. 99 LOOP
      FOR j in 0 .. 99 LOOP
         INSERT INTO QUARE VALUES((j+1)+(i*100));
         INSERT INTO QUARE_DETAILS VALUES( (j+1)+(i*100), j*2, i*2, (j*2)+2, (i*2)+2 );    /*(ID,x1,y1,x2,y2)*/
      END LOOP;
   END LOOP;
   COMMIT;
END;
/
show errors;
/
prompt <-- OK;
execute INSERT_TO_QUARE
/
drop procedure INSERT_TO_QUARE
/
