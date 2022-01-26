///
/// Thanks to https://medium.com/flutter-community/building-a-dart-server-from-scratch-2ee0cf88948
///
import 'dart:convert';
import 'dart:io';

import 'package:job_feed_crawler_dart/controller/remote_io_crawler.dart';

Future<void> main() async {
  final server = await createServer();
  print('Server started: ${server.address} port ${server.port}');
  await handleRequests(server);
}

Future<HttpServer> createServer() async {
  final address = InternetAddress.loopbackIPv4;
  const port = 4040;
  return await HttpServer.bind(address, port);
}

Future<void> handleRequests(HttpServer server) async {
  await for (HttpRequest request in server) {
    switch (request.method) {
      case 'GET':
        await handleGet(request);
        break;
      // case 'POST':
      //   await handlePost(request);
      //   break;
      default:
        handleDefault(request);
    }
  }
}

Future<void> handleGet(HttpRequest request) async {
  //TODO: adapt after testing
  final crawler = RemoteIOStrategy();
  final result = await crawler(
      siteUrl:
          'file:///work/Code/job_feed_craweler_dart/job_feed_crawler_dart/lib/fixtures/remote_io_empty.html');
  final res = request.response..write(result);
  await res.close();
}

// Future<void> handlePost(HttpRequest request) async {
//   myStringStorage = await utf8.decoder.bind(request).join();
//   final res = request.response..write('Got it. Thanks.');
//   await res.close();
// }

void handleDefault(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.methodNotAllowed
    ..write('Unsupported request: ${request.method}.')
    ..close();
}
