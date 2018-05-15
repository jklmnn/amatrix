with Ada.Text_IO;
with Ada.Command_Line;
with Example_Client;

procedure Example
is
begin
   if Ada.Command_Line.Argument_Count /= 3 then
      Ada.Text_IO.Put_Line ("Usage: ./example <username> <password> <room id>");
      Ada.Command_Line.Set_Exit_Status (1);
      return;
   end if;

   Example_Client.Send_Test_Message (
                                     Ada.Command_Line.Argument (1),
                                     Ada.Command_Line.Argument (2),
                                     Ada.Command_Line.Argument (3)
                                    );
end Example;
