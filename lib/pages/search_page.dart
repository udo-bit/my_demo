import 'package:flutter/material.dart';
import 'package:my_demo/util/navigator_util.dart';
import 'package:my_demo/widgets/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('搜索')),
        body: Column(
          children: [
            SearchWidget(
              searchType: SearchType.homeLight,
              rightButtonClick: () {
                NavigatorUtil.goToLogin(context);
              },
            )
          ],
        ));
  }
}
