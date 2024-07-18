import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/coffee_tile.dart';
import '../models/coffee.dart';
import '../models/coffee_shop.dart';
import 'coffee_order_screen.dart';

class ShopScreen extends StatefulWidget {
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  void goToCoffeePage(Coffee coffee){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoffeeOrderScreen(coffee: coffee),
        ),
    );
  }

  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 25,
              top: 25,
            ),
            child: Text(
              'How do you like your coffee?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: value.coffeeShop.length,
              itemBuilder: (context, index) {
                Coffee eachCoffee = value.coffeeShop[index];
                return CoffeeTile(
                  coffee: eachCoffee,
                  onPressed: () => goToCoffeePage(eachCoffee),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
