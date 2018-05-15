with AWS.Client;
with AWS.Response;

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
                 Content : String
                ) return String
   is
   begin
      return AWS.Response.Message_Body (AWS.Client.Put (
                                        URL  => Url,
                                        Data => Content));
   end Put;

   function Post (
                  Url     : String;
                  Content : String
                 ) return String
   is
   begin
      return AWS.Response.Message_Body (AWS.Client.Post (
                                        URL  => Url,
                                        Data => Content));
   end Post;

end Http;
