import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          height: 80,
                          width: 200,
                          child: SvgPicture.network(
                            'https://raw.githubusercontent.com/ooni/design-system/master/components/svgs/logos/Probe-HorizontalMonochromeInverted.svg',
                            semanticsLabel: 'OONI-HorizontalMonochromeInverted',
                            placeholderBuilder: (BuildContext context) =>
                                Container(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ShapeOfView(
                          elevation: 0,
                          shape: ArcShape(
                            direction: ArcDirection.Inside,
                            height: 30,
                            position: ArcPosition.Bottom,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Dashboard.Overview.LatestTest').tr(),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned.fill(
                    top: 60,
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Dashboard.Card.Run',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                            ),
                          ).tr(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: 6,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: Text('as'),
                      title: Text('item $index'),
                      subtitle: Text('description $index'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ) /* CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Column(
              children: [
                SizedBox(
                  height: 80,
                  width: 200,
                  child: SvgPicture.network(
                    'https://raw.githubusercontent.com/ooni/design-system/master/components/svgs/logos/Probe-HorizontalMonochromeInverted.svg',
                    semanticsLabel: 'OONI-HorizontalMonochromeInverted',
                    placeholderBuilder: (BuildContext context) => Container(),
                  ),
                ),
              ],
            ),
            centerTitle: false,
            expandedHeight: 110,
            collapsedHeight: 110,
            flexibleSpace: FlexibleSpaceBar(
              title: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    'run',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30
                    ),
                  ),
                ),
              ),
              titlePadding: const EdgeInsets.only(top: 40),
              background: Container(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(height: 55),
                      Container(
                        width: double.infinity,
                        child: ShapeOfView(
                          shape: ArcShape(
                            direction: ArcDirection.Inside,
                            height: 30,
                            position: ArcPosition.Bottom,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: Text('as'),
                      title: Text('item $index'),
                      subtitle: Text('description $index'),
                    ),
                  ),
                );
              },
              childCount: 6,
            ),
          ),
        ],
      )*/
      ,
    );
  }
}
