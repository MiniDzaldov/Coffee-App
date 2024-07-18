import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../components/my_button.dart';
import '../const.dart';
import 'home_screen.dart';

class PaymentScreen extends StatefulWidget {
  final VoidCallback onPaymentSuccess;
  PaymentScreen({required this.onPaymentSuccess});
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  String cardHolderName = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel CreditCardModel) {
    setState(() {
      cardNumber = CreditCardModel.cardNumber;
      expiryDate = CreditCardModel.expiryDate;
      cardHolderName = CreditCardModel.cardHolderName;
      cvvCode = CreditCardModel.cvvCode;
      isCvvFocused = CreditCardModel.isCvvFocused;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Payment',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cvvCode: cvvCode,
              cardHolderName: cardHolderName,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (CreditCardButton) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      onCreditCardModelChange: onCreditCardModelChange,
                      themeColor: Colors.blue,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.onPaymentSuccess();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Payment Success'),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          print('invalid');
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => HomeScreen())
                        // );
                      },
                      child: Text(
                        'Pay Now',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
