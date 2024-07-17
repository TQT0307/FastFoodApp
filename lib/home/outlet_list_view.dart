import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../../common_widget/outlet_list_row.dart';
import '../../common_widget/popup_layout.dart';

class OutletListView extends StatefulWidget {
  final Map<String, dynamic> fObj;

  const OutletListView({Key? key, required this.fObj}) : super(key: key);

  @override
  State<OutletListView> createState() => _OutletListViewState();
}

class _OutletListViewState extends State<OutletListView> {
  List<Map<String, dynamic>> outletArr = [
    {
      "name": "Lombar Pizza",
      "price": 10.0,
      "address": "East 46th Street",
      "category": "Pizza, Italian",
      "image": "assets/img/l1.png",
      "time": "11:30AM to 11:00PM",
      "rate": 4.8
    },
    {
      "name": "Sushi Bar",
      "price": 2.0,
      "address": "210 Salt Pond Rd.",
      "category": "Sushi, Japan",
      "image": "assets/img/l2.png",
      "time": "11:30AM to 11:00PM",
      "rate": 3.8
    },
    {
      "name": "Steak House",
      "price": 12.0,
      "address": "East 46th Street",
      "category": "Steak, American",
      "image": "assets/img/l3.png",
      "time": "11:30AM to 11:00PM",
      "rate": 2.8
    },
    {
      "name": "Seafood Lee",
      "price": 20.0,
      "address": "210 Salt Pond Rd.",
      "category": "Seafood, Spain",
      "image": "assets/img/t1.png",
      "time": "11:30AM to 11:00PM",
      "rate": 5.0
    },
    {
      "name": "Egg Tomato",
      "price": 2.0,
      "address": "East 46th Street",
      "category": "Egg, Italian",
      "image": "assets/img/t2.png",
      "time": "11:30AM to 11:00PM",
      "rate": 4.8
    },
    {
      "name": "Burger Hot",
      "price": 2.0,
      "address": "East 46th Street",
      "category": "Pizza, Italian",
      "image": "assets/img/t3.png",
      "time": "11:30AM to 11:00PM",
      "rate": 4.8
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.blue,
              elevation: 0,
              expandedHeight: media.width * 0.667,
              floating: false,
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  width: media.width,
                  height: media.width * 0.667,
                  color: Colors.blue,
                  child: Container(
                    padding: EdgeInsets.only(top: media.width * 0.25),
                    height: media.width * 0.8,
                    alignment: Alignment.center,
                    child: Image.asset(
                      widget.fObj["image"].toString(),
                      width: media.width * 0.25,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              leading: IconButton(
                icon: Image.asset(
                  "assets/img/back.png",
                  width: 24,
                  height: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Chia sẻ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${outletArr.length} Cửa hàng",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Xử lý khi nhấn nút lọc
                    },
                    child: Text(
                      "Lọc",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: outletArr.length,
                itemBuilder: (context, index) {
                  var fObj = outletArr[index];
                  return OutletListRow(
                    fObj: fObj,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}