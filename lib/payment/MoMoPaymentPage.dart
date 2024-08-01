import 'package:flutter/material.dart';

class BankPaymentPage extends StatelessWidget {
  const BankPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh Toán Qua Thẻ Ngân Hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nhập thông tin thẻ ngân hàng của bạn:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Số thẻ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              obscureText: true, // Có thể thay đổi dựa trên yêu cầu
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Họ tên chủ thẻ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Ngày hết hạn (MM/YY)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Mã CVV',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              obscureText: true, // Có thể thay đổi dựa trên yêu cầu
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Xử lý thanh toán qua thẻ ngân hàng
                // Bạn có thể thêm mã xử lý thanh toán ở đây
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Thanh toán qua thẻ ngân hàng đã được xử lý thành công!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Thanh Toán'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0)),
                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
