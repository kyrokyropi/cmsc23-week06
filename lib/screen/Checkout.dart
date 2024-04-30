import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class Checkout extends StatelessWidget{
  const Checkout({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Center(
                  child: Column(children: [
            Text("Item Details"),
            const Divider(),
            getItems(context)
            
          ]))),
        ],
      ),
    );
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
       return Text("Total: ${cart.cartTotal}");
    });
  }

  Widget getItems(BuildContext context){
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
    ? const Text('No items to checkout!')
    :Expanded(child: 
    Column(
      children: [
        Flexible(
          child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(products[index].name),
              trailing: Text("${products[index].price}"),
            );
          },
        )),
        Flexible(
          child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                const Divider(),
                computeCost(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue, // Change this to Colors.lightBlue
                    ),
                    onPressed: () {
                      context.read<ShoppingCart>().removeAll();
                      Navigator.pop(context, "/checkout");
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Payment Succesful!"),
                        duration:
                            const Duration(seconds: 1, milliseconds: 100),
                      ));
                    },
                    child: const Text("Pay Now")),
                  ]))
        )
      ],
    ),);
  }
}
  