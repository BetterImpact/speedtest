<%@ LANGUAGE="c#" Debug="true" %>
<%
Response.Buffer = false;

// Download follows...
Response.AddHeader("Content-Description", "File Transfer");
Response.AddHeader("Content-Type", "application/octet-stream");
Response.AddHeader("Content-Disposition", "attachment; filename=random.dat");
Response.AddHeader("Content-Transfer-Encoding", "binary");

// Never cache me
Response.AddHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
Response.AddHeader("Cache-Control", "post-check=0, pre-check=0");
Response.AddHeader("Pragma", "no-cache");

// Generate data
var rnd = new Random();
var data = new Byte[1048576];
rnd.NextBytes(data);

// Deliver chunks of 1048576 bytes
var chunks = (!string.IsNullOrEmpty(Request.QueryString["ckSize"])) ? Convert.ToInt32(Request.QueryString["ckSize"]) : 4;

if(chunks > 100) chunks = 100;

for(var i = 0; i < chunks; i++) {
    Response.OutputStream.Write(data, 0, data.Length);
    Response.Flush();
}
%>
