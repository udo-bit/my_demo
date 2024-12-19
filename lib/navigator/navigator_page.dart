import 'package:flutter/material.dart';
import 'package:my_demo/pages/home_page.dart';
import 'package:my_demo/pages/my_page.dart';
import 'package:my_demo/pages/search_page.dart';
import 'package:my_demo/pages/trip_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  final PageController _controller = PageController(initialPage: 1);
  int _current = 1;

  get _navigationItems {
    return [
      _item('首页', Icons.home, 0),
      _item('搜索', Icons.search, 1),
      _item('旅拍', Icons.camera, 2),
      _item('我的', Icons.person, 3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (int index) {
          setState(() {
            _current = index;
          });
        },
        children: const [HomePage(), SearchPage(), TripPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _controller.jumpToPage(index);
        },
        currentIndex: _current,
        type: BottomNavigationBarType.fixed,
        items: _navigationItems,
      ),
    );
  }

  BottomNavigationBarItem _item(String title, IconData iconDate, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Icon(
          iconDate,
          size: 25,
          color: Colors.grey,
        ),
        activeIcon: Icon(
          iconDate,
          size: 25,
          color: Colors.teal,
        ));
  }
}
