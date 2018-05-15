with Http;
with JWX.JSON;

package body Amatrix.Client is

   -----------
   -- Login --
   -----------

   function Login (
                   User : String;
                   Pass : String
                  ) return String
   is
      Response : String := Http.Post (Homeserver & "/_matrix/client/r0/login",
                                      "{""initial_device_display_name"": ""amatrix test"","
                                      & """password"": """ & Pass & ""","
                                      & """type"": ""m.login.password"","
                                      & """user"": """ & User & """}");
      package Response_Object is new JWX.JSON (Response);
      M : Response_Object.Match_Type;
   begin
      Response_Object.Parse (M);
      return Response_Object.Get_String (Response_Object.Query_Object ("access_token"));
   end Login;

   Access_Token : String := Login(Username, Password);

   function Image (
                   Value : Transaction_Type
                  ) return String
   is
      function Len (
                    Val : Transaction_Type
                   ) return Integer
      is
         Length : Integer := 0;
         V : Natural := Natural (Val);
      begin
         Lloop:
         loop
            Length := Length + 1;
            if V > 0 then
               V := V / 10;
            end if;
            exit Lloop when V = 0;
         end loop Lloop;
         return Length;
      end Len;

      V : Natural := Natural (Value);
      Img : String (1 .. Len (Value)) := (others => 'X');
   begin
      for I in reverse Img'Range loop
         case V mod 10 is
            when 0 => Img (I) := '0';
            when 1 => Img (I) := '1';
            when 2 => Img (I) := '2';
            when 3 => Img (I) := '3';
            when 4 => Img (I) := '4';
            when 5 => Img (I) := '5';
            when 6 => Img (I) := '6';
            when 7 => Img (I) := '7';
            when 8 => Img (I) := '8';
            when 9 => Img (I) := '9';
            when others => Img(I) := 'X';
         end case;
         V := V / 10;
      end loop;
      return Img;
   end Image;

   ------------------
   -- Send_Message --
   ------------------

   Transaction_Id : Transaction_Type := 1;

   procedure Send_Message (
                           Message : String;
                           Room_Id : Room_Type
                          )
   is
      Response : String := Http.Put (Homeserver &
                                     "/_matrix/client/r0/rooms/"
                                     & String (Room_Id)
                                     & "/send/m.room.message/"
                                     & Image (Transaction_Id),
                                     "{ ""body"":"""
                                     & Message
                                     & """, ""msgtype"":""m.text""}",
                                    Access_Token);
   begin
      null;
   end Send_Message;

end Amatrix.Client;
