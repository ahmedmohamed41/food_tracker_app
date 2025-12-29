import 'package:flutter/material.dart';
import 'package:food_tracker_app/features/home/widgets/custom_item_food.dart';
import 'package:food_tracker_app/features/home/widgets/custom_text.dart';
import 'package:food_tracker_app/features/home/widgets/custom_text_form_field.dart';
import 'package:food_tracker_app/features/models/item_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameFoodController = TextEditingController();
  final _expireDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<ItemModel> items = [];
  DateTime? picked = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText(
          title: 'Food Savior',
          size: 25,
          fontWeight: FontWeight.w900,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: 'My Food',
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 15,
            ),
            items.isEmpty
                ? Expanded(
                    child: Center(
                      child: CustomText(
                        title: 'My Food is Empty',
                        size: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => CustomItemFood(
                        itemModel: items[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                      itemCount: items.length,
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          addItemShowBottomSheet(context);
          _nameFoodController.clear();
          _expireDateController.clear();
        },
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }

  void addItemShowBottomSheet(BuildContext context1) {
    showModalBottomSheet(
      context: context1,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  title: 'Food Name',
                  size: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  controller: _nameFoodController,
                  hintText: 'Food Name',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomText(
                  title: 'Expiration Date',
                  size: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  controller: _expireDateController,
                  readOnly: true,
                  hintText: 'Expiration Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.timer_outlined),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String expiryText = "";
                      final now = DateTime.now();

                      if (picked!.year == now.year &&
                          picked!.month == now.month &&
                          picked!.day == now.day) {
                        expiryText = 'Expires: Today';
                      } else {
                        expiryText = 'Expires: ${_expireDateController.text}';
                      }
                      setState(() {
                        items.add(
                          ItemModel(
                            title: _nameFoodController.text,
                            desc: expiryText,
                            colorExpire: selectedColor(
                              picked!,
                            ),
                          ),
                        );
                      });

                      Navigator.pop(context1);
                    }
                  },
                  child: CustomText(
                    title: 'Add New Food Item',
                    size: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color selectedColor(DateTime pickedDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expiry = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
    final difference = expiry.difference(today).inDays;

    if (difference <= 2) {
      return Colors.red;
    } else if (difference <= 5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _expireDateController.text =
            "${picked!.year}-${picked!.month}-${picked!.day}";
      });
    }
  }
}
