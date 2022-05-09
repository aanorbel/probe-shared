import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    launchAppUrl(String url) async {
      if (!await launchUrl(Uri.parse(url))) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch ${url.toString()}'),
          ),
        );
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            expandedHeight: 120.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: FlutterLogo(),
              title: Text(
                'title',
                textScaleFactor: 0.8,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Settings.About.Content.Paragraph').tr(),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await launchAppUrl('https://ooni.org/');
                    },
                    child: const Text('Settings.About.Content.LearnMore').tr(),
                  ),
                  TextButton(
                    onPressed: () async {
                      await launchAppUrl('https://ooni.org/blog/');
                    },
                    child: const Text('Settings.About.Content.Blog').tr(),
                  ),
                  TextButton(
                    onPressed: () async {
                      await launchAppUrl('https://ooni.org/reports/');
                    },
                    child: const Text('Settings.About.Content.Reports').tr(),
                  ),
                  TextButton(
                    onPressed: () async {
                      await launchAppUrl('https://ooni.org/about/data-policy/');
                    },
                    child: const Text('Settings.About.Content.DataPolicy').tr(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
