import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/coffee_tile.dart';
import '../components/my_button.dart';
import '../const.dart';
import '../models/coffee.dart';
import '../models/coffee_shop.dart';
import 'payment_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void _removeFromCart(Coffee coffee) {
    setState(() {
      Provider.of<CoffeeShop>(context, listen: false).userCart.remove(coffee);
    });
  }

  void _clearCart() {
    setState(() {
      Provider.of<CoffeeShop>(context, listen: false).userCart.clear();
    });
  }

  double _calculateTotalPrice() {
    return Provider.of<CoffeeShop>(context, listen: false).userCart.fold(
          0.0,
          (total, coffee) => total += (coffee.price * coffee.quantity),
        );
  }

  int _calculateTotalItems() {
    return Provider.of<CoffeeShop>(context, listen: false).userCart.fold(
          0,
          (total, coffee) => total + coffee.quantity,
        );
  }

  @override
  Widget build(BuildContext context) {
    final coffeeShop = Provider.of<CoffeeShop>(context);
    final userCart = coffeeShop.userCart;
    final isCartEmpty = userCart.isEmpty;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Cart',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            if (isCartEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[600],
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: userCart.length,
                  itemBuilder: (context, index) {
                    final coffee = userCart[index];
                    return Container(
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            coffee.imagePath,
                            height: 70,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                coffee.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Quantity: ${coffee.quantity}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Total: \$${(coffee.price * coffee.quantity).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.brown),
                            onPressed: () {
                              _removeFromCart(coffee);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            SizedBox(
              height: 25,
            ),
            if (!isCartEmpty) ...[
              Row(
                children: [
                  Text(
                    'Total Quantity:',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${_calculateTotalItems()}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Total Price:',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              MyButton(
                text: 'Payment',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(onPaymentSuccess: _clearCart),
                    ),
                  );
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
