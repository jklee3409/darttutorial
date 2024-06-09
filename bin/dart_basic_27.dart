import 'dart:ffi';
import 'dart:io';
import 'dart:async';

// Handler for HTTP Get Request
Future<void> handleGetRequest(HttpRequest req) async {
  // #1 Retrieve an associated HttpResponse object in HttpRequest object.
  HttpResponse res = req.response;

  // #2 Do something : Example - Write text body in the response.
  res.write('${DateTime.now()}: Hello, World!');

  // #4 Close the response and send it to the client.
  res.close();
}

// Handler for not allowed HTTP Request.
Future<void> handleNotAllowedRequest(HttpRequest req) async {
  // #1 Retrieve an associated HttpResponse object in HttpRequest object.
  HttpResponse res = req.response;

  // #2 Do something : Example - Write text body in the response.
  res
    ..statusCode = HttpStatus.methodNotAllowed
    ..write('${DateTime.now()}: Unsupported request: ${req.method}');

  // #3 Close the response and send it to the client,
  res.close();
}

// Handler for HTTP Request.
Future handleRequest(HttpRequest req) async {
  // #1 Do something based on HTTP Request types.
  switch (req.method) {
    // #2 Get Request.
    case 'GET':
      // Print log message and activate HTTP Get Request handler.
      stdout.writeln("${DateTime.now()}: GET ${req.uri.path}");
      await handleGetRequest(req);
      break;
    // #3 Other Requests.
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
