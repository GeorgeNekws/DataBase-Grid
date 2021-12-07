prompt <-- Creating function GET_CIRCLE_SIZE...;

CREATE or REPLACE 
   FUNCTION GET_CIRCLE_SIZE(IDtemp IN integer,
                            R IN integer)
   RETURN integer
   IS 
      x0         integer;
      y0         integer;
      yi_plus    integer;
      yi_minus   integer;
      xi         integer;
      qlen       integer := 2;                            -- length of each quare
      select_str varchar2(5000);                          -- string that contains the select union statement
	  total      integer;								  -- the number of quare rectangles that consist the circle
     
   BEGIN
      SELECT X1,Y1 INTO x0,y0 FROM QUARE_DETAILS WHERE ID=IDtemp;

      FOR xi in (x0-R) .. (x0+R) LOOP               
         IF MOD(xi,2) = 0 THEN                            -- xi := xi+qlen , where qlen=2, increment xi by 2 in every loop
            yi_plus := y0 + sqrt(R**2 - (xi-x0)**2);
            yi_minus := y0 - sqrt(R**2 - (xi-x0)**2);
			
            select_str := CONCAT('(SELECT COUNT(*) FROM QUARE_DETAILS WHERE X1=' || TO_CHAR(xi) ||
                                 ' AND (Y1 BETWEEN ' || TO_CHAR(yi_minus) || ' AND ' || TO_CHAR(yi_plus) || ')) + ' , select_str);
         END IF;
      END LOOP;
      select_str := RTRIM(select_str, '+ ');        -- delete last occurence of 'UNION' from the select_str that i made above
	  select_str := CONCAT(select_str, 'as total from dual');
	  select_str := CONCAT('SELECT ',select_str);	-- global select
      --select_str := CONCAT(select_str,';');       -- i do not need to add a ; in the end of the select statement string
    
	  execute immediate select_str into total;
      RETURN(total);
   END;
/
show errors;
