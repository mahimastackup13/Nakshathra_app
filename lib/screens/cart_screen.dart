import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakshatra_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Bag",
          style: GoogleFonts.cormorantGaramond(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text("Your bag is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: Image.asset(item.imagePath, width: 50),
                        title: Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          item.price,
                          style: const TextStyle(color: Color(0xFFD4AF37)),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => cart.removeItem(item.id),
                        ),
                      );
                    },
                  ),
                ),
                _buildCheckoutSection(context, cart),
              ],
            ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Total",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Calculating...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _showOrderedMessage(context, cart),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E513D),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Checkout Now",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderedMessage(BuildContext context, CartProvider cart) {
    cart.clearCart();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(
          Icons.check_circle,
          color: Color(0xFF2E513D),
          size: 60,
        ),
        content: const Text(
          "Order Placed Successfully!\nYour jewelry is being prepared.",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text("Back to Home"),
          ),
        ],
      ),
    );
  }
}
