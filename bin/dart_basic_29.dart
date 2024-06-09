// CLIENT

import 'dart:io';
import 'dart:convert';

Future main() async {
  // #1 Create HttpRequest & HttpResponse objects
  HttpClientRequest httpRequest;
  HttpClientResponse httpResponse;

  // #2 Client HTTP server network information related objects
  var severIP = InternetAddress.loopbackIPv4.host;
  var severPort = 4049;
  var serverPath;

  // #3 GET request transfer with RESTful example
  stdout.writeln('${DateTime.now()}: Send GET');
  serverPath = "";
  httpRequest = await HttpClient().get(severIP, severPort, serverPath);
  httpResponse = await httpRequest.close();
  await utf8.decoder.bind(httpResponse).forEach(print);

  // #4 GET request transfer with RESTful example
  stdout.writeln('${DateTime.now}: Send GET RESTful');
  serverPath = '?q=4&p=5.0&r="Dart"';
  httpRequest = await HttpClient().get(severIP, severPort, serverPath);
  httpResponse = await httpRequest.close();
  await utf8.decoder.bind(httpResponse).forEach(print);

  // #5 POST request transfer with JSON data example
  stdout.writeln('${DateTime.now()}: Send POST JSON');

  Map jsonContent = {
    'C++': 'Bjarne Stroustrup',
    'Dart': 'Lars Bak and Kasper Lund',
    'Go': 'Robert Griesemer, Rob Pike, Ken Thompson',
    'JavaScript': 'Brendan Eich'
  };

  serverPath = "bin/example.txt";
  httpRequest = await HttpClient().post(severIP, severPort, serverPath)
    ..headers.contentType = ContentType.json
    ..write(jsonEncode(jsonContent));
  httpResponse = await httpRequest.close();
  await utf8.decoder.bind(httpResponse).forEach(print);
}
