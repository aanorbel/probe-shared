import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared/pages/about/about.dart';

part 'theme_utils.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OONI Probe',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: _themeData(ThemeMode.light, context),
      darkTheme: _themeData(ThemeMode.dark, context),
      initialRoute: '/about',
      routes: {
        '/about': (context) => const AboutPage(),
      },
    );
  }
}
