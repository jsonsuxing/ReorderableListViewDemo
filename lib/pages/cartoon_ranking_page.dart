import 'package:flutter/material.dart';
import 'package:reorderable_listview_demo/model/cartoon_model.dart';
import 'package:reorderable_listview_demo/widgets/cartoon_item.dart';

// ------------------------------------------------------
// author：https://allensu.blog.csdn.net
// date  ：2023/10/23 17:36
// usage ：测试拖拽排序案例（以动漫排名为例）
// ------------------------------------------------------

class CartoonRankingPage extends StatefulWidget {
  const CartoonRankingPage({Key? key}) : super(key: key);

  @override
  State<CartoonRankingPage> createState() => _CartoonRankingPageState();
}

class _CartoonRankingPageState extends State<CartoonRankingPage> {
  final List<CartoonModel> list = [
    CartoonModel(id: 1, name: "完美世界", image: "cartoon_01.png"),
    CartoonModel(id: 2, name: "咒术回战", image: "cartoon_02.webp"),
    CartoonModel(id: 3, name: "斗破苍穹", image: "cartoon_03.jpeg"),
    CartoonModel(id: 4, name: "吞噬星空", image: "cartoon_04.webp"),
    CartoonModel(id: 5, name: "火影忍者", image: "cartoon_05.webp"),
    CartoonModel(id: 6, name: "狐妖小红娘", image: "cartoon_06.webp"),
    CartoonModel(id: 7, name: "画江湖之不良人", image: "cartoon_07.jpeg"),
  ];

  /// 拖拽完成回调
  Future<void> onReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      setState(() {
        newIndex -= 1;
        list.insert(newIndex, list.removeAt(oldIndex));
      });
    }
  }

  /// 代理装饰，消除拖动时 item 自身的外边距和装饰盒子时的圆角的影响
  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("你心目中的动漫排名"), centerTitle: true),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          const SizedBox(height: 15),
          Expanded(
            child: ReorderableListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 17),
              itemCount: list.length,
              itemBuilder: (_, index) {
                return CartoonItem(key: ValueKey(list[index].id), index: index, model: list[index]);
              },
              onReorder: onReorder,
              proxyDecorator: _proxyDecorator,
              buildDefaultDragHandles: false, // 如果想拖拽任意位置，注释掉此属性即可
            ),
          ),
        ],
      ),
    );
  }
}
