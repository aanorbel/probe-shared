import 'package:flutter/material.dart';
import 'package:shared/pages/home/home.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _pageViewController = PageController();

  int _activePage = 0;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: <Widget>[
          const Dashboard(),
          Container(color: Colors.green),
          const Settings()
        ],
        onPageChanged: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activePage,
        onTap: (index) {
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceOut);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Text("R"),
            activeIcon: Text("Active"),
            label: "Red",
          ),
          BottomNavigationBarItem(
            icon: Text("G"),
            activeIcon: Text("Active"),
            label: "Green",
          ),
          BottomNavigationBarItem(
            icon: Text("B"),
            activeIcon: Text("Active"),
            label: "Blue",
          ),
        ],
      ),
    );
  }
}
