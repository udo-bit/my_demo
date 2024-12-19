import 'package:flutter/material.dart';

enum SearchType { home, homeLight, normal }

class SearchWidget extends StatefulWidget {
  final SearchType? searchType;
  final String? hint;
  final String? defaultText;
  final bool? hideLeft;
  final VoidCallback? leftButtonClick;
  final VoidCallback? rightButtonClick;
  final VoidCallback? inputBoxClick;
  final ValueChanged<String>? onChanged;

  const SearchWidget(
      {super.key,
      this.hint = '请输入内容',
      this.defaultText = '北京欢迎你',
      this.hideLeft = false,
      this.leftButtonClick,
      this.rightButtonClick,
      this.inputBoxClick,
      this.onChanged,
      this.searchType = SearchType.normal});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool? showClear;
  TextEditingController controller = TextEditingController();

  Widget get _normalSearchBar => Row(
        children: [
          _wrapTap(
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: _backBtn,
              ),
              widget.leftButtonClick),
          Expanded(child: _inputBox),
          _wrapTap(
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
              widget.rightButtonClick)
        ],
      );

  get _backBtn => widget.hideLeft ?? false
      ? null
      : const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 20);

  get _homeFontColor =>
      widget.searchType == SearchType.homeLight ? Colors.black54 : Colors.white;

  get _homeSearchBar => Row(
        children: [
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(6, 5, 6, 5),
                child: Row(
                  children: [
                    Text(
                      '北京',
                      style: TextStyle(color: _homeFontColor, fontSize: 16),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: _homeFontColor,
                      size: 16,
                    )
                  ],
                ),
              ),
              widget.leftButtonClick),
          Expanded(child: _inputBox),
          _wrapTap(
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '登出',
                  style: TextStyle(color: _homeFontColor, fontSize: 16),
                ),
              ),
              widget.rightButtonClick)
        ],
      );

  get _inputBox {
    Color inputBoxColor;
    if (widget.searchType == SearchType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = const Color(0xffededed);
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
              widget.searchType == SearchType.normal ? 5 : 15)),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchType == SearchType.normal
                ? const Color(0xffa9a9a9)
                : Colors.blue,
          ),
          Expanded(child: _textField),
          if (showClear ?? false)
            _wrapTap(
                const Icon(
                  Icons.clear,
                  size: 22,
                  color: Colors.grey,
                ), () {
              setState(() {
                controller.clear();
              });
              _onChanged("");
            })
        ],
      ),
    );
  }

  get _textField => widget.searchType == SearchType.normal
      ? TextField(
          onChanged: _onChanged,
          style: const TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300),
          cursorColor: Colors.blue,
          cursorHeight: 20,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 12),
              hintText: widget.hint,
              hintStyle: const TextStyle(fontSize: 15)),
        )
      : _wrapTap(
          Text(
            widget.defaultText ?? "",
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          widget.inputBoxClick);

  Widget _wrapTap(Widget child, VoidCallback? callback) {
    return GestureDetector(
      onTap: callback,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchType == SearchType.normal
        ? _normalSearchBar
        : _homeSearchBar;
  }

  void _onChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }
}
