
package Http is

   function Get (
                 Url : String
                ) return String;

   function Put (
                 Url     : String;
                 Content : String;
                 Authentication : String
                ) return String;

   function Post (
                  Url     : String;
                  Content : String
                 ) return String;

end Http;
