package Example_Client is

   procedure Send_Test_Message (
                                Username : String;
                                Password : String;
                                Room : String
                               );

private

   function Get_Username (
                          User : String
                         ) return String;

   function Get_Homeserver (
                            User : String
                           ) return String;

end Example_Client;
