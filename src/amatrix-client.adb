with Http;
with JWX.JSON;

package body Amatrix.Client is

   -----------
   -- Login --
   -----------

   Invalid_Token : Access_Token_Type := (others => Character'Val (0));
   Access_Token : Access_Token_Type;
   Invalid_Homeserver : Homeserver_Type := (others => Character'Val (0));
   Homeserver : Homeserver_Type;

   procedure Login (
                    User : String;
                    Pass : String
                   )
   is
      Hs       : String := Get_Homeserver (User);
      Response : String := Http.Post (Hs
                                      & "/_matrix/client/r0/login",
                                      "{""initial_device_display_name"": ""amatrix test"","
                                      & """password"": """ & Pass & ""","
                                      & """type"": ""m.login.password"","
                                      & """user"": """ & Get_Username (User)
                                      & """}");
      package Response_Object is new JWX.JSON (Response);
      M        : Response_Object.Match_Type;
   begin
      Set_Homeserver (Hs);
      Response_Object.Parse (M);
      Set_Access_Token (Response_Object.Get_String (Response_Object.Query_Object ("access_token")));
   end Login;

   procedure Set_Access_Token (
                               Token : String
                              )
   is
   begin
      Access_Token := Invalid_Token;
      for I in Integer range 0 .. Token'Length - 1 loop
         Access_Token (Access_Token'First + I) := Token (Token'First + I);
      end loop;
   end;

   function Get_Access_Token return String
   is
   begin
      for I in Access_Token'Range loop
         if Access_Token (I) = Character'Val (0) then
            return String (Access_Token (1 .. I - 1));
         end if;
      end loop;
      return String (Invalid_Token);
   end Get_Access_Token;

   procedure Set_Homeserver (
                             Server : String
                            )
   is
   begin
      Homeserver := Invalid_Homeserver;
      for I in Server'Range loop
         Homeserver (I) := Server (I);
      end loop;
   end Set_Homeserver;

   function Get_Homeserver return String
   is
   begin
      for I in Homeserver'Range loop
         if Homeserver (I) = Character'Val (0) then
            return String (Homeserver (1 .. I - 1));
         end if;
      end loop;
      return String (Invalid_Homeserver);
   end Get_Homeserver;

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

   function Image (
                   Value : Transaction_Type
                  ) return String
   is
      function Len (
                    Val : Transaction_Type
                   ) return Integer
      is
         Length : Integer := 0;
         V      : Natural := Natural (Val);
      begin
         Lloop :
         loop
            Length := Length + 1;
            if V > 0 then
               V := V / 10;
            end if;
            exit Lloop when V = 0;
         end loop Lloop;
         return Length;
      end Len;

      V   : Natural := Natural (Value);
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
            when others => Img (I) := 'X';
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
      Response : String := Http.Put (Get_Homeserver &
                                       "/_matrix/client/r0/rooms/"
                                     & String (Room_Id)
                                     & "/send/m.room.message/"
                                     & Image (Transaction_Id),
                                     "{ ""body"":"""
                                     & Message
                                     & """, ""msgtype"":""m.text""}",
                                     Get_Access_Token);
   begin
      null;
   end Send_Message;

end Amatrix.Client;
