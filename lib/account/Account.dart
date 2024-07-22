import 'package:flutter/material.dart';

import 'OrderHistoryPage.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> orders = OrderHistory.getOrders(); // Retrieve orders from history

    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            onTap: () {
              print('Edit Profile Tapped!');
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Order History'),
            onTap: () {
              // Navigate to a page that displays the order history
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OrderHistoryPage(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('View Orders'),
            onTap: () {
              print('View Orders Tapped!');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              print('Logout Tapped!');
            },
          ),
        ],
      ),
    );
  }
}



