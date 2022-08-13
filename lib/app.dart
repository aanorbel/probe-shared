import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared/pages/about/about.dart';
import 'package:shared/pages/home/home.dart';

import "package:ooniengine/abi.pb.dart";
import "package:ooniengine/engine.dart";
import 'package:path/path.dart' as filepath;
import 'package:path_provider/path_provider.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;

part 'theme_utils.dart';

/// Returns the HOME directory path.
Future<String> homeDirectory() async{
  return (await getTemporaryDirectory()).path;
}

/// Returns the location of the OONI_HOME directory. If [maybeHome]
/// is not the empty string, we'll use it for computing the OONI_HOME,
/// otherwise we use $HOME (or %USERPROFILE%) as the base dir.
Future<String> ooniHome(String maybeHome) async{
  if (maybeHome == "") {
    maybeHome = await homeDirectory();
  }
  return filepath.join(maybeHome, ".ooniprobe");
}

/// Creates and exports directories that should be used by a session.
class SessionDirectories {
  /// Directory that contains state.
  late String stateDir;

  /// Directory that contains temporary data.
  late String tempDir;

  /// Directory that contains tunnel state.
  late String tunnelDir;

  /// Generates the directory names and possibly creates them.
  SessionDirectories(String ooniHome) {
    stateDir = filepath.join(ooniHome, "engine");
    new Directory(stateDir).create(recursive: true);
    tunnelDir = filepath.join(ooniHome, "tunnel");
    new Directory(tunnelDir).create(recursive: true);
    tempDir = Directory.systemTemp.createTempSync().path;
  }
}

/// Creates a new instance of the OONI Engine and runs it inside an Isolate.
Engine newEngine() {
  final goos = operatingSystem();
  final goarch = architecture();
  final ext = libraryExtension();
  return Engine("libooniengine.${ext}");
}

/// Name of this software
const softwareName = "ooniengine-tool";

/// Version of this software
const softwareVersion = "0.1.0-dev";

/// Returns the correct proxy URL given command line flags.
String proxyURL() {
  final tunnel = '';
  var proxy = '';
  if (tunnel != "" && proxy != "") {
    throw Exception("you cannot specify --tunnel and --proxy-url together");
  }
  if (tunnel != "") {
    proxy = tunnel + ":///";
  }
  return proxy;
}

/// Creates a SessionConfig given command line flags.
Future<SessionConfig> newSessionConfig() async {
  final dirs = SessionDirectories(await ooniHome(''));
  return SessionConfig(
    logLevel: LogLevel.DEBUG,
    probeServicesUrl: '',
    proxyUrl: proxyURL(),
    softwareName: softwareName,
    softwareVersion: softwareVersion,
    stateDir: dirs.stateDir,
    tempDir: dirs.tempDir,
    torArgs: [],
    torBinary: '',
    tunnelDir: dirs.tunnelDir,
  );
}

/// Stops the given task on SIGINT. You must cancel the subscription
/// when you're done executing the given task, or Dart will hang.
StreamSubscription<ProcessSignal> freeOnSIGINT(Task task) {
  return ProcessSignal.sigint.watch().listen((event) {
    task.free();
  });
}


/// Parses key-value pairs from a list of strings.
Map<String, String> keyValuePairs(List<String> inputs) {
  var out = Map<String, String>();
  for (final input in inputs) {
    final v = input.split("=");
    if (v.length < 2) {
      throw Exception("cannot find the `=' separator in: ${input}");
    }
    final key = v[0];
    final value = v.sublist(1).join("=");
    out[key] = value;
  }
  return out;
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  geoIP() async {
    final cfg = GeoIPConfig(
      session: await newSessionConfig(),
    );
    Engine? engine;
    Task? task;
    StreamSubscription<ProcessSignal>? subscription;
    try {
      engine = newEngine();
      task = await engine.startGeoIPTask(cfg);
      subscription = freeOnSIGINT(task);
      var _geoIP = await task.findFirst<GeoIPEvent>(silent: false);
      print(_geoIP);
    } finally {
      subscription?.cancel();
      task?.free();
      engine?.shutdown();
    }
  }

  webConnectivity() async {
    final cfg = OONIRunV2MeasureDescriptorConfig(
      maxRuntime: $fixnum.Int64(0),
      noCollector: null,
      noJson: null,
      random: false,
      reportFile: 'report.jsonl',
      session: await newSessionConfig(),
      v2Descriptor: OONIRunV2Descriptor(
        name: 'websites',
        description: "Measures whether a list of websites is blocked",
        author: "Simone Basso <simone@openobservatory.org>",
        nettests: [
          OONIRunV2DescriptorNettest(
            annotations: keyValuePairs([]),
            inputs: [],
            options: jsonEncode(keyValuePairs([])),
            testName: "web_connectivity",
          ),
        ],
      ),
    );
    Engine? engine;
    Task? task;
    StreamSubscription<ProcessSignal>? subscription;
    try {
      engine = newEngine();
      task = await engine.startOONIRunV2MeasureDescriptorTask(cfg);
      subscription = freeOnSIGINT(task);
      await task.foreachEvent((ev) => printMessage(ev));
    } finally {
      subscription?.cancel();
      task?.free();
      engine?.shutdown();
    }
  }
  runIm() async {
    final cfg = OONIRunV2MeasureDescriptorConfig(
      maxRuntime: $fixnum.Int64(0),
      noCollector: null,
      noJson: null,
      random: false,
      reportFile: 'report.jsonl',
      session: await newSessionConfig(),
      v2Descriptor: OONIRunV2Descriptor(
        name: 'im',
        description: "Measures whether instant messaging apps are blocked",
        author: "Simone Basso <simone@openobservatory.org>",
        nettests: [
          OONIRunV2DescriptorNettest(
            annotations: keyValuePairs([]),
            inputs: [],
            options: "{}",
            testName: "facebook_messenger",
          ),
          OONIRunV2DescriptorNettest(
            annotations: keyValuePairs([]),
            inputs: [],
            options: "{}",
            testName: "whatsapp",
          ),
          OONIRunV2DescriptorNettest(
            annotations: keyValuePairs([]),
            inputs: [],
            options: "{}",
            testName: "telegram",
          ),
          OONIRunV2DescriptorNettest(
            annotations: keyValuePairs([]),
            inputs: [],
            options: "{}",
            testName: "signal",
          ),
        ],
      ),
    );
    Engine? engine;
    Task? task;
    StreamSubscription<ProcessSignal>? subscription;
    try {
      engine = newEngine();
      task = await engine.startOONIRunV2MeasureDescriptorTask(cfg);
      subscription = freeOnSIGINT(task);
      await task.foreachEvent((ev) => printMessage(ev));
    } finally {
      subscription?.cancel();
      task?.free();
      engine?.shutdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _os = operatingSystem();
    print("OS: ${_os}");
    // webConnectivity();
    // runIm();
    return MaterialApp(
      title: 'OONI Probe',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: _themeData(ThemeMode.light, context),
      darkTheme: _themeData(ThemeMode.dark, context),
      initialRoute: '/dashboard',
      routes: {
        '/about': (context) => const AboutPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
