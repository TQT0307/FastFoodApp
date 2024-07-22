import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> orders = OrderHistory.getOrders();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Order \$${orders[index]['totalPrice']}'),
            subtitle: Text('Address: ${orders[index]['address']} - Phone: ${orders[index]['phoneNumber']}'),
          );
        },
      ),
    );
  }
}


class OrderHistory {
  static final List<Map<String, dynamic>> _orders = [];

  static void addOrder(Map<String, dynamic> orderDetails) {
    _orders.add(orderDetails);
  }

  static List<Map<String, dynamic>> getOrders() {
    return _orders;
  }
}