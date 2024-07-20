import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderSummaryPage extends StatefulWidget {
  final double totalPrice;

  const OrderSummaryPage({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);

  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  String? selectedPaymentMethod;
  bool paymentInfoEntered = false;
  bool paymentInfoConfirmed = false;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _momoPhoneController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _isPhoneNumberValid = false;
  bool _isMomoPhoneNumberValid = false;
  bool _isCardNumberValid = false;
  bool _isExpiryDateValid = false;
  bool _isCVVValid = false;

  bool _isValidPhoneNumber(String phoneNumber) {
    final phoneNumberPattern = RegExp(r'^[0-9]{10,15}$');
    return phoneNumberPattern.hasMatch(phoneNumber);
  }

  bool _isValidCardNumber(String cardNumber) {
    final cardNumberPattern = RegExp(r'^[0-9]{10}$');
    return cardNumberPattern.hasMatch(cardNumber);
  }

  bool _isValidExpiryDate(String expiryDate) {
    final expiryDatePattern = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
    return expiryDatePattern.hasMatch(expiryDate);
  }

  bool _isValidCVV(String cvv) {
    final cvvPattern = RegExp(r'^[0-9]{3}$');
    return cvvPattern.hasMatch(cvv);
  }

  void _onCardNumberChange() {
    String cardNumberText = _cardNumberController.text;
    if (cardNumberText.length > 16) {
      cardNumberText = cardNumberText.substring(0, 16);
    }
    setState(() {
      _cardNumberController.text = cardNumberText;
      _cardNumberController.selection = TextSelection.fromPosition(
        TextPosition(offset: cardNumberText.length),
      );
    });
  }

  void _onExpiryDateChange() {
    String expiryDateText = _expiryDateController.text;
    if (expiryDateText.length == 2 && !expiryDateText.contains('/')) {
      setState(() {
        _expiryDateController.text = '$expiryDateText/';
        _expiryDateController.selection = TextSelection.fromPosition(
          TextPosition(offset: _expiryDateController.text.length),
        );
      });
    }
  }

  void _selectPaymentMethod(String? method) {
    setState(() {
      selectedPaymentMethod = method;
      paymentInfoEntered = false;
      paymentInfoConfirmed = false;
    });
  }

  void _handlePaymentInfo() {
    _validateFields();
    if (selectedPaymentMethod == 'Momo') {
      if (_isMomoPhoneNumberValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thông tin MoMo đã được liên kết thành công!'),
            duration: Duration(seconds: 2),
          ),
        );
        setState(() {
          paymentInfoEntered = true;
          paymentInfoConfirmed = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vui lòng nhập số điện thoại hợp lệ!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else if (selectedPaymentMethod == 'Bank card') {
      if (_isCardNumberValid && _isExpiryDateValid && _isCVVValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thông tin thẻ ngân hàng đã được liên kết thành công!'),
            duration: Duration(seconds: 2),
          ),
        );
        setState(() {
          paymentInfoEntered = true;
          paymentInfoConfirmed = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vui lòng nhập thông tin thẻ hợp lệ!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else if (selectedPaymentMethod == 'Cash payment') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thanh toán bằng tiền mặt đã được liên kết thành công!'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        paymentInfoEntered = true;
        paymentInfoConfirmed = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập thông tin thanh toán đầy đủ!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _confirmOrder() {
    if (selectedPaymentMethod != null &&
        _addressController.text.isNotEmpty &&
        _isPhoneNumberValid) {
      if (paymentInfoConfirmed) {
        Navigator.of(context).pop({
          'paymentMethod': selectedPaymentMethod,
          'address': _addressController.text,
          'phoneNumber': _phoneNumberController.text,
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vui lòng hoàn tất thông tin thanh toán trước khi xác nhận đơn hàng!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng chọn phương thức thanh toán và nhập địa chỉ cùng số điện thoại hợp lệ!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _validateFields() {
    setState(() {
      _isPhoneNumberValid = _phoneNumberController.text.isNotEmpty && _isValidPhoneNumber(_phoneNumberController.text);
      _isMomoPhoneNumberValid = _momoPhoneController.text.isNotEmpty && _isValidPhoneNumber(_momoPhoneController.text);
      _isCardNumberValid = _cardNumberController.text.isNotEmpty && _isValidCardNumber(_cardNumberController.text);
      _isExpiryDateValid = _expiryDateController.text.isNotEmpty && _isValidExpiryDate(_expiryDateController.text);
      _isCVVValid = _cvvController.text.isNotEmpty && _isValidCVV(_cvvController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Total amount: \$${widget.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Enter Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                hintText: 'Enter your address',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter Phone Number:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isPhoneNumberValid ? Colors.green : Colors.red,
                    width: 2.0,
                  ),
                ),
                hintText: 'Enter your phone number',
                errorText: !_isPhoneNumberValid && _phoneNumberController.text.isNotEmpty ? 'Invalid phone number' : null,
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) => _validateFields(),
            ),
            SizedBox(height: 20),
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Momo',
                  groupValue: selectedPaymentMethod,
                  onChanged: _selectPaymentMethod,
                ),
                Text('MoMo'),
                SizedBox(width: 20),
                Radio<String>(
                  value: 'Bank card',
                  groupValue: selectedPaymentMethod,
                  onChanged: _selectPaymentMethod,
                ),
                Text('Bank Card'),
                SizedBox(width: 20),
                Radio<String>(
                  value: 'Cash payment',
                  groupValue: selectedPaymentMethod,
                  onChanged: _selectPaymentMethod,
                ),
                Text('Cash Payment'),
              ],
            ),
            if (selectedPaymentMethod == 'Momo') ...[
              SizedBox(height: 20),
              Text(
                'Enter MoMo Phone Number:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _momoPhoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isMomoPhoneNumberValid ? Colors.green : Colors.red,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Enter MoMo phone number',
                  errorText: !_isMomoPhoneNumberValid && _momoPhoneController.text.isNotEmpty ? 'Invalid phone number' : null,
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) => _validateFields(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handlePaymentInfo,
                child: Text('Phone number link'),
              ),
            ] else if (selectedPaymentMethod == 'Bank card') ...[
              SizedBox(height: 20),
              Text(
                'Enter Card Number:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _cardNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isCardNumberValid ? Colors.green : Colors.red,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Enter card number',
                  errorText: !_isCardNumberValid && _cardNumberController.text.isNotEmpty ? 'Invalid card number' : null,
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                onChanged: (value) => _onCardNumberChange(),
              ),
              SizedBox(height: 20),
              Text(
                'Enter Expiry Date (MM/YY):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isExpiryDateValid ? Colors.green : Colors.red,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Enter expiry date',
                  errorText: !_isExpiryDateValid && _expiryDateController.text.isNotEmpty ? 'Invalid expiry date' : null,
                ),
                keyboardType: TextInputType.datetime,
                onChanged: (value) => _onExpiryDateChange(),
              ),
              SizedBox(height: 20),
              Text(
                'Enter CVV:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _cvvController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isCVVValid ? Colors.green : Colors.red,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Enter CVV',
                  errorText: !_isCVVValid && _cvvController.text.isNotEmpty ? 'Invalid CVV' : null,
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                onChanged: (value) => _validateFields(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handlePaymentInfo,
                child: Text('Link Bank Card'),
              ),
            ] else if (selectedPaymentMethod == 'Cash payment') ...[
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handlePaymentInfo,
                child: Text('Confirm Cash Payment'),
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmOrder,
              child: Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
  }
