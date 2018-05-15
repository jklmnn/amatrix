with Ada.Text_IO;
with Amatrix.Client;

package body Example_Client is

   -----------------------
   -- Send_Test_Message --
   -----------------------

   procedure Send_Test_Message (
                                Username : String;
                                Password : String;
                                Room : String
                               )
   is
      package Matrix is new Amatrix.Client (Username, Password, "https://matrix.org");
   begin
      Matrix.Send_Message("amatrix test message", Matrix.Room_Type (Room));
   end Send_Test_Message;

end Example_Client;
