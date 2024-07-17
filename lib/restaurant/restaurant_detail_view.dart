import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import '../cart/cart.dart';

class RestaurantDetailView extends StatefulWidget {
  final Map<String, dynamic> fObj;

  const RestaurantDetailView({
    Key? key,
    required this.fObj, required void Function(Map<String, dynamic> fObj) addToCart,
  }) : super(key: key);

  @override
  _RestaurantDetailViewState createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView> {
  List<Map<String, dynamic>> cartItems = [];

  // Phương thức hiển thị thông báo thành công khi thêm sản phẩm vào giỏ hàng
  void showSuccessAlert() {
    CoolAlert.show(
      confirmBtnColor: Colors.blue,
      backgroundColor: Colors.white,
      context: context,
      type: CoolAlertType.success,
      text: "Your dish has been successfully added!",
    );
  }
  // Phương thức thêm sản phẩm vào giỏ hàng
  void addToCart(Map<String, dynamic> fObj) {
    bool found = false;

    // Duyệt qua các sản phẩm trong giỏ hàng
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i]["name"] == fObj["name"]) {
        // Nếu tên sản phẩm đã tồn tại trong giỏ hàng, cập nhật số lượng
        cartItems[i]["quantity"] += 1;
        found = true;
        break;
      }
    }

    // Nếu sản phẩm chưa có trong giỏ hàng, thêm vào với số lượng là 1
    if (!found) {
      cartItems.add({
        "name": fObj["name"],
        "category": fObj["category"],
        "price": fObj["price"],
        "quantity": 1,
      });
    }

    // Hiển thị thông báo thành công khi thêm sản phẩm vào giỏ hàng
    showSuccessAlert();
  }

  final List<Map<String, dynamic>> trendingArr = [
    {
      "name": "Seafood Lee",
      "address": "210 Salt Pond Rd.",
      "category": "Seafood, Spain",
      "image": "assets/img/t1.png"
    },
    {
      "name": "Egg Tomato",
      "address": "East 46th Street",
      "category": "Egg, Italian",
      "image": "assets/img/t2.png"
    },
    {
      "name": "Burger Hot",
      "address": "East 46th Street",
      "category": "Pizza, Italian",
      "image": "assets/img/t3.png"
    }
  ];

  final List<Map<String, dynamic>> collectionsArr = [
    {"name": "Legendary food", "place": "34", "image": "assets/img/c1.png"},
    {"name": "Seafood", "place": "28", "image": "assets/img/c2.png"},
    {"name": "Fizza Meli", "place": "56", "image": "assets/img/c3.png"}
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
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              expandedHeight: media.width * 0.667,
              floating: false,
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      width: media.width,
                      height: media.width * 0.667,
                      color: Colors.blue, // Placeholder color
                      child: Image.asset(
                        widget.fObj["image"].toString(),
                        width: media.width,
                        height: media.width * 0.8,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      left: 8.0,
                      child: IconButton(
                        icon: Image.asset(
                          "assets/img/back.png",
                          width: 24,
                          height: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.fObj["name"].toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.blue, // Placeholder color
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "4.8",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                color: Colors.white,
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.share),
                      label: Text("Share"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.rate_review),
                      label: Text("Review"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.photo),
                      label: Text("Photo"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark),
                      label: Text("Bookmark"),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.white,
                  height: media.width * 0.4,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.fObj["address"].toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.fObj["category"].toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "11:30AM to 11PM",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            // Order now and Add to cart buttons
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 250,
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Center(
                                                child: Text(
                                                  'Your Cart',
                                                  style: TextStyle(
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 16.0),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: cartItems.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var item = cartItems[index];
                                                    return ListTile(
                                                      title: Text(item["name"]),
                                                      subtitle: Text(item["category"]),
                                                      trailing: Text("\$${item["price"]}"),
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 16.0),
                                              Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15, vertical: 10),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all<Color>(
                                                        Colors.green, // Placeholder color
                                                      ),
                                                      minimumSize:
                                                      MaterialStateProperty.all<Size>(
                                                        Size(double.infinity, 50),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => const Cart(),
                                                        ),
                                                      );
                                                    },
                                                    child: Text("Checkout"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text("Order Now"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      addToCart(widget.fObj); // Gọi hàm addToCart với sản phẩm hiện tại
                                    });
                                  },
                                  child: Text("Add to Cart"),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  height: 20,
                  thickness: 4,
                  color: Colors.green, // Placeholder color
                ),
              ),

              // Trending this week
              _buildSectionTitle("Same Restaurants"),
              SizedBox(
                height: media.width * 0.6,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: trendingArr.length,
                  itemBuilder: (context, index) {
                    var fObj = trendingArr[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantDetailView(
                              fObj: fObj, addToCart: (Map<String, dynamic> fObj) {  },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              fObj["image"].toString(),
                              width: media.width * 0.4,
                              height: media.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              fObj["name"].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(fObj["category"].toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  height: 20,
                  thickness: 4,
                  color: Colors.green, // Placeholder color
                ),
              ),

              // Collections
              _buildSectionTitle("Related Collection"),
              SizedBox(
                height: media.width * 0.6,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: collectionsArr.length,
                  itemBuilder: (context, index) {
                    var cObj = collectionsArr[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle collection item tap
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              cObj["image"].toString(),
                              width: media.width * 0.4,
                              height: media.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              cObj["name"].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${cObj["place"]} Places"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
  // Phương thức tạo tiêu đề cho mỗi phần
  Widget _buildSectionTitle(String title) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }


// class Cart extends StatefulWidget {
//   const Cart({Key? key}) : super(key: key);
//
//   @override
//   _CartState createState() => _CartState();
//}

class _CartState extends State<Cart> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          var item = cartItems[index];
          return ListTile(
            title: Text(item["name"]),
            subtitle: Text(item["category"]),
            trailing: Text("\$${item["price"]}"),
          );
        },
      ),
    );
  }
}
