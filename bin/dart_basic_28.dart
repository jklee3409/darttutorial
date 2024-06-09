import 'dart:io';
import 'dart:async';
import 'dart:convert';

// Handler for HTTP Get Request
Future handleGetRequest(HttpRequest req) async {
  // #1 Retrieve an associated HttpResponse object in HttpRequest object.
  HttpResponse res = req.response;

  // #2 Do something : Example - Write text body in the response.
  res.write('${DateTime.now()}: Hello, World!');

  // #4 Close the response and send it to the client.
  await res.close();
}

Future handlePostRequest(HttpRequest req) async {
  // #1 Retrieve an associated HttpResponse object in HttpRequest object.
  HttpResponse res = req.response;

  // #2 Do something : Example - Write file based on received JSON.
  if (req.headers.contentType?.mimeType == 'application/json') {
    try {
      // #2.1 utf8.decoder.bind(req) : Retrieve multiple chunks within a same HTTP Request.
      // #2.2 .join() : Puts the chunk together.
      String jsonContent = await utf8.decoder.bind(req).join();

      // #2.3 Retrieve file name from HTTP POST Request
      var jsonFileName = req.uri.pathSegments.last;

      // #2.4 Save the received JSON content into a file in a current working directory
      await File(jsonFileName).writeAsString(jsonContent, mode: FileMode.write);

      // #2.5 Decode the received JSON content and concert into MAP format
      var jsonData = jsonDecode(jsonContent) as Map;

      // #2.6 Make a response for success case
      req.response
        ..statusCode = HttpStatus.ok
        ..write('${DateTime.now()}: Wrote data for ${jsonData}');
    } catch (e) {
      // #2.7 Make a response failed case
      res
        ..statusCode = HttpStatus.internalServerError
        ..write('${DateTime.now()}: Exception during file I/O: $e.');
    }
  } else {
    // #2.8 Make a response for not supported POST Request (not a JSON format)
    res
      ..statusCode = HttpStatus.methodNotAllowed
      ..write(
          '${DateTime.now()}: Unsupported POST type: ${req.headers.contentType?.mimeType}.');
  }

  // #3 Close the response and send it to the client.
  await res.close();
}

// Handler for not allowed HTTP Request.
Future handleNotAllowedRequest(HttpRequest req) async {
  // #1 Retrieve an associated HttpResponse object in HttpRequest object.
  HttpResponse res = req.response;

  // #2 Do something : Example - Write text body in the response.
  res
    ..statusCode = HttpStatus.methodNotAllowed
    ..write('${DateTime.now()}: Unsupported request: ${req.method}');

  // #3 Close the response and send it to the client,
  await res.close();
}

// Handler for HTTP Request.
Future handleRequest(HttpRequest req) async {
  // #1 Do something based on HTTP Request types.
  switch (req.method) {
    // #1.1 GET Request.
    case 'GET':
      // Print log message and activate HTTP Get Request handler.
      stdout.writeln("${DateTime.now()}: GET ${req.uri}");
      await handleGetRequest(req);
      break;
    // #1.2 POST Requests.
    case 'POST':
      // Print lof message and activate HTTP POST Request handler.
      stdout.writeln("${DateTime.now()}: POST ${req.uri}");
      await handlePostRequest(req);
      break;
    // #1.3 Other Requests.
    default:
      stdout.writeln("${DateTime.now()}: ${req.method} not allowed.");
      await handleNotAllowedRequest(req);
  }
}

Future main() async {
  // #1 Specify HTTP Server address (localhost) and port.
  final HOST = InternetAddress.loopbackIPv4;
  final PORT = 4040;

  // #2 Starts listening for HTTP requests on the address and port.
  var httpServer = await HttpServer.bind(HOST, PORT);
  stdout.writeln("${DateTime.now()}: HTTP Server running at ${HOST.address}.");

  // #3 Listening for HTTP requests and handle requests.
  await for (HttpRequest httpRequest in httpServer) {
    try {
      // #3.1 Activate a HTTP Request handler.
      handleRequest(httpRequest);
    } catch (e) {
      // #3.2 Print message at exception handling case.
      stdout.writeln("${DateTime.now()}: Exception in handleRequest: $e");
    }
  }
}
