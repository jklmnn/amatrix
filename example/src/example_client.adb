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
      package Matrix is new Amatrix.Client (Get_Username (Username),
                                            Password,
                                            Get_Homeserver (Username));
   begin
      Matrix.Send_Message("amatrix test message", Matrix.Room_Type (Room));
   end Send_Test_Message;

   function Get_Username (
                          User : String
                         ) return String
   is
   begin
      if User (User'First) = '@' then
         for I in User'Range loop
            if User (I) = ':' then
               return User (User'First + 1 .. I - 1);
            end if;
         end loop;
      else
         return User;
      end if;
   end Get_Username;

   function Get_Homeserver (
                            User : String
                           ) return String
   is
   begin
      if User (User'First) = '@' then
         for I in User'Range loop
            if User (I) = ':' then
               return "https://" & User (I + 1 .. User'Last);
            end if;
         end loop;
      else
         return "https://matrix.org";
      end if;
   end Get_Homeserver;

end Example_Client;
