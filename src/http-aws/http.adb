with AWS.Client;
with AWS.Response;
with AWS.Headers.Set;
with Ada.Text_IO;

package body Http is

   function Get (
                 Url : String
                ) return String
   is
   begin
      return AWS.Response.Message_Body (AWS.Client.Get (
                                        URL => Url));
   end Get;

   function Put (
                 Url     : String;
                 Content : String;
                 Authentication : String
                ) return String
   is
      Headers : AWS.Client.Header_List;
   begin
      AWS.Headers.Set.Add (Headers, "Authorization", "Bearer " & Authentication);
      Ada.Text_IO.Put_Line ("calling put: " & Url);
      return AWS.Response.Message_Body (AWS.Client.Put (
                                        URL  => Url,
                                        Data => Content,
                                        Headers => Headers));
   end Put;

   function Post (
                  Url     : String;
                  Content : String
                 ) return String
   is
   begin
      Ada.Text_IO.Put_Line ("calling post: " & Url);
      return AWS.Response.Message_Body (AWS.Client.Post (
                                        URL  => Url,
                                        Data => Content));
   end Post;

end Http;
