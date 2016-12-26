import 'dart:io';
import 'dart:isolate';
import 'package:angel_diagnostics/angel_diagnostics.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_static/angel_static.dart';

main(args, [SendPort sendPort]) async {
  var app = new Angel();

  await app.configure(new VirtualDirectory(source: new Directory('static'), publicPath: '/static'));
  // app.all('*', () => throw new AngelHttpException.NotFound());
  app.dumpTree();

  var server =
      await new DiagnosticsServer(app, new File('log.txt')).startServer();
  sendPort?.send([server.address.address, server.port]);
}
