generic
   Client_Name : String;
package Amatrix.Client is

   type Transaction_Type is new Positive;
   type Room_Type is new String;
   type Access_Token_Type is array (Integer range 1 .. 8192) of Character;
   type Homeserver_Type is array (Integer range 1 .. 512) of Character;

   procedure Send_Message (
                           Message : String;
                           Room_Id : Room_Type
                          );

   procedure Login (
                    User : String;
                    Pass : String
                   );

private

   procedure Set_Access_Token (
                               Token : String
                              );

   function Get_Access_Token return String;

   procedure Set_Homeserver (
                             Server : String
                            );

   function Get_Homeserver return String;

   function Get_Username (
                          User : String
                         ) return String;

   function Get_Homeserver (
                            User : String
                           ) return String;

   function Image (
                   Value : Transaction_Type
                  ) return String;

end Amatrix.Client;
