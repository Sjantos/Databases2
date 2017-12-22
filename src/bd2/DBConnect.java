package bd2;

import java.sql.*;
import java.util.Arrays;
import java.util.LinkedList;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.bind.DatatypeConverter;


public class DBConnect {
	private class Triple<X, Y, Z> { 
		  public final X x; 
		  public final Y y; 
		  public final Z z;
		  public Triple(X x, Y y, Z z) { 
		    this.x = x; 
		    this.y = y; 
		    this.z = z;
		  } 
		} 
	
	private Connection con;
	private Statement st;
	private ResultSet rs;
	
	public DBConnect()
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hurtownia1", "root", "");
			st = con.createStatement();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
        
        public ResultSet ShowClientOrders()
        {
            try {
                return st.executeQuery("SELECT * FROM zamowieniaklientow;");
            } catch (SQLException ex) {
                Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
            }
            return null;
        }
	
	private byte[] toBytes(char[] chars) {
	    CharBuffer charBuffer = CharBuffer.wrap(chars);
	    ByteBuffer byteBuffer = Charset.forName("UTF-8").encode(charBuffer);
	    byte[] bytes = Arrays.copyOfRange(byteBuffer.array(),
	            byteBuffer.position(), byteBuffer.limit());
	    Arrays.fill(charBuffer.array(), '\u0000'); // clear sensitive data
	    Arrays.fill(byteBuffer.array(), (byte) 0); // clear sensitive data
	    return bytes;
	}
	
	public int Login(String login, char[] password)
	{
		byte[] loginBytes = login.getBytes();
		String loginHashValue = "";
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-512");
			messageDigest.update(loginBytes);
			byte[] digestedBytes = messageDigest.digest();
			loginHashValue = DatatypeConverter.printHexBinary(digestedBytes).toLowerCase();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		byte[] passwordBytes = toBytes(password);
		String passwordHashValue = "";
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-512");
			messageDigest.update(passwordBytes);
			byte[] digestedBytes = messageDigest.digest();
			passwordHashValue = DatatypeConverter.printHexBinary(digestedBytes).toLowerCase();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		//Get logins and passwords from DB, find ID_pracownika, 
		//if success, login as ID_pracownika with ID_stanowisko privileges

		
		try {
			String query = "SELECT ID_pracownika, login, haslo FROM pracownicy";
			rs = st.executeQuery(query);
			LinkedList<Triple<String, String, String>> workers = new LinkedList<Triple<String, String, String>>();
			while(rs.next())
			{
				Triple<String, String, String> t = new Triple<String, String, String>(	rs.getString("ID_pracownika"), 
																						rs.getString("login"), 
																						rs.getString("haslo"));
				workers.add(t);
			}
			String id = "";
			for (int i = 0; i < workers.size(); i++) {
				if(workers.get(i).y.equals(loginHashValue))
				{
					if(workers.get(i).z.equals(passwordHashValue))
					{
						id = workers.get(i).x;
						break;
					}
					
				}
			}
			System.out.println("id: "+id);
			if(!id.equals(""))
			{
				return Integer.parseInt(id);
			}
			else
				return 0;
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
}
