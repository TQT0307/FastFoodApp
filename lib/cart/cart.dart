import 'package:flutter/material.dart';
import 'OrderSummaryPage.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();

  static List<Map<String, dynamic>> cartItems = [];

  static void addItem(Map<String, dynamic> item) {
    item['category'] = "Food";
    item['price'] = 10.0;
    bool found = false;
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i]['name'] == item['name']) {
        cartItems[i]['quantity'] += 1;
        found = true;
        break;
      }
    }
    if (!found) {
      item['quantity'] = 1;
      cartItems.add(item);
    }
    if (_cartState != null) {
      _cartState!.updateCart();
    }
  }

  static void removeItem(int index, BuildContext context) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
      if (_cartState != null) {
        _cartState!.updateCart();
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
                    _cartState!.updateCart();
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.purple.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: Cart.cartItems.length,
                itemBuilder: (context, index) {
                  var item = Cart.cartItems[index];
                  return buildCartItem(item, context, index);
                },
              ),
            ),
            buildTotalSection(totalPrice, context),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(Map<String, dynamic> item, BuildContext context, int index) {
    int quantity = item['quantity'];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
                  color: Colors.red,
                  onPressed: () => adjustQuantity(item, false),
                ),
                Text('$quantity', style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.green,
                  onPressed: () => adjustQuantity(item, true),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => confirmDelete(item['name'], index, context),
                ),
              ],
            ),
          ],
        ),
        subtitle: Text('Price: \$${item['price']} x $quantity', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget buildTotalSection(double totalPrice, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () => navigateToSummaryPage(totalPrice, context),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
        child: Text('Checkout (\$${totalPrice.toStringAsFixed(2)})', style: TextStyle(fontSize: 20))

      ),
    );
  }

  void adjustQuantity(Map<String, dynamic> item, bool increase) {
    setState(() {
      if (increase) {
        item['quantity'] += 1;
      } else {
        if (item['quantity'] > 1) {
          item['quantity'] -= 1;
        } else {
          Cart.removeItem(Cart.cartItems.indexOf(item), context);
        }
      }
    });
  }

  void confirmDelete(String name, int index, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to remove $name from your cart?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
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
  }

  void navigateToSummaryPage(double totalPrice, BuildContext context) async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(
        builder: (context) => OrderSummaryPage(totalPrice: totalPrice),
      ),
    );
    if (result != null) {
      print('Payment Method: ${result['paymentMethod']}');
      print('Address: ${result['address']}');
      print('Phone Number: ${result['phoneNumber']}');
    }
  }
}
