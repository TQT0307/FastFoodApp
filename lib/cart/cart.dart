import 'package:flutter/material.dart';
import 'OrderSummaryPage.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();

  static List<Map<String, dynamic>> cartItems = []; // Danh sách sản phẩm trong giỏ hàng

  static void addItem(Map<String, dynamic> item) {
    item['category'] = "Food"; // Thay "Thực phẩm" bằng danh mục thực tế của sản phẩm
    item['price'] = 10.0; // Thay 10.0 bằng giá thực tế của sản phẩm

    bool found = false;
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i]['name'] == item['name']) { // So sánh dựa trên tên sản phẩm
        cartItems[i]['quantity'] += 1;
        found = true;
        break;
      }
    }

    if (!found) {
      item['quantity'] = 1; // Mặc định số lượng là 1
      cartItems.add(item);
      print('Add product to cart: $item');
    }

    if (_cartState != null) {
      _cartState!.updateCart(); // Gọi phương thức cập nhật giỏ hàng
    }
  }

  static void removeItem(int index, BuildContext context) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
      print('Delete product at location $index');
      if (_cartState != null) {
        _cartState!.updateCart(); // Gọi phương thức cập nhật giỏ hàng
      }
    }
  }

  static void clearCart(BuildContext context) {
    if (cartItems.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Delete All'),
            content: Text('Are you sure you want to delete all products in your cart?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete All'),
                onPressed: () {
                  cartItems.clear();
                  if (_cartState != null) {
                    _cartState!.updateCart(); // Gọi phương thức cập nhật giỏ hàng
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Tham chiếu đến trạng thái của Cart để cập nhật
  static _CartState? _cartState;
}

class _CartState extends State<Cart> {
  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var item in Cart.cartItems) {
      totalPrice += item['price'] * (item['quantity'] ?? 1);
    }
    return totalPrice;
  }

  void updateCart() {
    setState(() {}); // Gọi setState để rebuild widget
  }

  @override
  void initState() {
    super.initState();
    Cart._cartState = this;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = getTotalPrice(); // Lấy tổng tiền

    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ Hàng'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Cart.clearCart(context);
            },
            iconSize: 40,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Cart.cartItems.length,
              itemBuilder: (context, index) {
                var item = Cart.cartItems[index];
                int quantity = item['quantity'] ?? 1;

                void increaseQuantity() {
                  setState(() {
                    quantity++;
                    item['quantity'] = quantity;
                  });
                }

                void decreaseQuantity() {
                  setState(() {
                    if (quantity > 1) {
                      quantity--;
                      item['quantity'] = quantity;
                    } else {
                      Cart.removeItem(index, context);
                    }
                  });
                }

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['name'].toString(),
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: decreaseQuantity,
                            ),
                            Text(
                              '$quantity',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: increaseQuantity,
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirm Delete'),
                                      content: Text('Are you sure you want to remove ${item['name']} from your cart?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Delete'),
                                          onPressed: () {
                                            Cart.removeItem(index, context);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category: ${item['category'].toString()}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Price: \$${item['price'].toString()}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Column(
              children: [
                Text(
                  'Total amount: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    // Chuyển đến trang OrderSummaryPage và đợi kết quả
                    final result = await Navigator.of(context).push<Map<String, dynamic>>(
                      MaterialPageRoute(
                        builder: (context) => OrderSummaryPage(
                          totalPrice: totalPrice, // Truyền tổng tiền đến OrderSummaryPage
                        ),
                      ),
                    );

                    if (result != null) {
                      // Xử lý thông tin trả về từ OrderSummaryPage
                      final paymentMethod = result['paymentMethod'];
                      final address = result['address'];
                      final phoneNumber = result['phoneNumber'];

                      // Tiếp tục xử lý đơn hàng với thông tin đã chọn
                      print('Payment Method: $paymentMethod');
                      print('Address: $address');
                      print('Phone Number: $phoneNumber');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    elevation: MaterialStateProperty.all<double>(5.0),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      'Pay',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
