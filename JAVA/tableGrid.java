import java.io.File;
import java.io.IOException;
import java.io.FileWriter;
import java.sql.*;
import oracle.jdbc.OracleTypes;

class tableGrid{
	public static void main(String[] args){
		CreateFile();
		int i = 0;
		try{
			//step 1 Load the driver class
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//step 2 Create the Connection object
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@DESKTOP:1521:orcl","user","pwd");
			
			//step 3 Create the Statement object
			CallableStatement cstmt = con.prepareCall("{? = call GET_CIRCLE(?,?)}");		//for calling an oracle function
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.setInt(2,4550);
			cstmt.setInt(3,40);
			
			CallableStatement cstmt2 = con.prepareCall("{? = call GET_CIRCLE_SIZE(?,?)}");		
			cstmt2.registerOutParameter(1,OracleTypes.INTEGER);
			cstmt2.setInt(2,4550);
			cstmt2.setInt(3,40);
			 
			//step 4 Execute query
			cstmt.executeUpdate();					
			cstmt2.execute();
			
			int result = cstmt2.getInt(1);
			int [] ids_array = new int[result];
			System.out.println(result);
			
			ResultSet rs = (ResultSet)cstmt.getObject(1);
			while(rs.next()){
				ids_array[i] = rs.getInt(1);					//fill an array with the ids i want to color
				System.out.println(rs.getInt(1));
				i++;
			}
			WriteToFIle(ids_array);

			//step 5 Close the connection object
			cstmt.close();
			cstmt2.close();
			con.close();
			
		} catch(Exception e){
			System.out.println(e);
		}	
	}
	
	public static void CreateFile(){
		try{
			File myObj = new File("tableGrid.html");
			if(myObj.createNewFile()){
				System.out.println("File Created: "+myObj.getName());
			}
			else System.out.println("File already exists.");
		} catch(IOException e){
			System.out.println("An error occured.");
			e.printStackTrace();
		}	
	}

	public static void WriteToFIle(int [] ids_array){
		String s = "[";
		for(int i=0;i<ids_array.length;i++){
			s = s + ids_array[i] +",";
		}
		s =s +"]";
		System.out.println(s);
		
		String htmlHeaderText = "<!DOCTYPE html>\n<html>\n<head>\n\t<meta charset=\"UTF-8\">\n\t<script src=\"tableGrid.js\"></script>\n\t<link rel=\"stylesheet\" href=\"tableGrid.css\">\n\t<script>var ar ="+s+" </script>\n\t<title> Draw a Rectangle Using SVG </title>\n</head>\n";
		String htmlFooterText = "</body>\n</html>";
		String htmlBodyText = "<body onload=\"createGrid();createCircle(ar)\">\n\t<table id=\"table-grid\"></table>\n";
		htmlBodyText = htmlBodyText + "\t<button id=\"myBtn\" onclick=\"color_ids()\">TARGET</button>\n";
		
		try{
			FileWriter myWriter = new FileWriter("tableGrid.html");
			myWriter.write(htmlHeaderText);
			myWriter.write(htmlBodyText);
			myWriter.write(htmlFooterText);
			myWriter.close();
			System.out.println("Successfully wrote to the file.");
		} catch(IOException e){
			System.out.println("An error occured.");
			e.printStackTrace();
		}
	}
	
}













