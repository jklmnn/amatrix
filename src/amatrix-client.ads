generic
   Username : String;
   Password : String;
   Homeserver : String;
package Amatrix.Client is

   type Transaction_Type is new Positive;
   type Room_Type is new String;
   type Access_Token_Type is new String;

   procedure Send_Message (
                           Message : String;
                           Room_Id : Room_Type
                          );

private

   function Login (
                   User : String;
                   Pass : String
                  ) return String;

   function Image (
                   Value : Transaction_Type
                  ) return String;

end Amatrix.Client;
