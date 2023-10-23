import 'package:flutter/material.dart';
import 'package:reorderable_listview_demo/model/cartoon_model.dart';

// ------------------------------------------------------
// author：https://allensu.blog.csdn.net
// date  ：2023/10/23 17:28
// usage ：单个动漫卡片
// ------------------------------------------------------

class CartoonItem extends StatelessWidget {
  final int index; // 索引
  final CartoonModel model; // 当前动漫详情

  const CartoonItem({
    Key? key,
    required this.index,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 64,
      padding: const EdgeInsets.only(left: 20, right: 16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 0.5, color: const Color(0xFFEAEDF3)),
        color: Colors.white,
      ),
      child: _mainView(),
    );
  }

  Widget _mainView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              // 排名
              Text("${index + 1}."),
              const SizedBox(width: 10),
              // 动漫名称
              Flexible(
                child: Text(
                  model.name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF394D6A)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            // 动漫图片
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/${model.image}",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 35),
            // 拖动排序组件，设置只有点击拖动按钮时才拖动整个item
            ReorderableDragStartListener(
              index: index,
              child: Image.asset("assets/images/ic_drag.webp", width: 16, height: 16),
            ),
          ],
        )
      ],
    );
  }
}
