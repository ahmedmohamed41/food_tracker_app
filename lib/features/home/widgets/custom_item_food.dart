import 'package:flutter/material.dart';
import 'package:food_tracker_app/features/home/widgets/custom_text.dart';
import 'package:food_tracker_app/features/models/item_model.dart';

class CustomItemFood extends StatelessWidget {
  const CustomItemFood({
    super.key,
    required this.itemModel,
  });
  final ItemModel itemModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: itemModel.colorExpire,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                title: itemModel.title,
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                title: itemModel.desc,
                size: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
