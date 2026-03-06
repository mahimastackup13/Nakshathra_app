import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakshatra_app/provider/cart_provider.dart';
import 'package:nakshatra_app/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color emeraldGreen = const Color(0xFF2E513D);
  final Color goldAccent = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- INTEGRATED SIDE MENU ---
      drawer: const SideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // --- PREMIUM APP BAR ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Updated Notes Icon to trigger Drawer
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: _buildRoundIcon(
                        Icons.notes,
                        goldAccent,
                        isPrimary: true,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _buildRoundIcon(
                        Icons.search,
                        Colors.white,
                        isPrimary: false,
                      ),
                      const SizedBox(width: 10),
                      _buildCartIconWithBadge(context),
                      const SizedBox(width: 10),
                      _buildRoundIcon(
                        Icons.notifications_none,
                        Colors.white,
                        isPrimary: false,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),
              _buildPromoBanner(),
              const SizedBox(height: 25),
              const Text(
                "Category",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 15),
              _buildCategoryList(),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recommendation",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),

              // --- PRODUCT GRID ---
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: const [
                  ProductCard(
                    id: '1',
                    title: "Bangles Set",
                    subtitle: "Gold",
                    price: "\$120.00",
                    imagePath: 'assets/images/product1.png',
                  ),
                  ProductCard(
                    id: '2',
                    title: "Wedding Set",
                    subtitle: "Gold",
                    price: "\$369.00",
                    imagePath: 'assets/images/product5.png',
                  ),
                  ProductCard(
                    id: '3',
                    title: "Diamond Ring",
                    subtitle: "Diamond and Gold",
                    price: "\$369.00",
                    imagePath: 'assets/images/product3.png',
                  ),
                  ProductCard(
                    id: '4',
                    title: "Necklace Set",
                    subtitle: "Gold",
                    price: "\$369.00",
                    imagePath: 'assets/images/product2.png',
                  ),
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  // --- HELPER UI BUILDERS ---

  Widget _buildRoundIcon(
    IconData icon,
    Color bgColor, {
    required bool isPrimary,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: isPrimary ? Colors.white : Colors.black87,
        size: 24,
      ),
    );
  }

  Widget _buildCartIconWithBadge(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) => Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            ),
            child: _buildRoundIcon(
              Icons.shopping_cart_outlined,
              Colors.white,
              isPrimary: false,
            ),
          ),
          if (cart.items.isNotEmpty)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  '${cart.items.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: emeraldGreen,
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          image: AssetImage('assets/images/cat2.png'),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Get 40% Off\nFor All Items",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Shop Now",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _categoryItem("Necklaces", 'assets/images/necklace2.png'),
          _categoryItem("Earrings", 'assets/images/earring.png'),
          _categoryItem("Rings", 'assets/images/rings.png'),
          _categoryItem("Bracelets", 'assets/images/bracelet.png'),
          _categoryItem("Wedding Sets", 'assets/images/wed5.png'),
        ],
      ),
    );
  }

  Widget _categoryItem(String title, String path) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFF5F5F5),
            child: Image.asset(path, width: 80, height: 60),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// --- HALF-SCREEN SIDE MENU (DRAWER) ---
//
class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  // Premium Palette
  final Color goldAccent = const Color(0xFFD4AF37);
  final Color charcoalText = const Color(0xFF2C2C2C);

  @override
  Widget build(BuildContext context) {
    // Media Query to ensure it only takes roughly 70% of the screen
    double drawerWidth = MediaQuery.of(context).size.width * 0.70;

    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            // --- DIAMOND GRADIENT HEADER ---
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFBF953F), // Deep Gold/Bronze
                    Color(0xFFFCF6BA), // Pale Gold (Shine)
                    Color(0xFFB38728), // Golden Brown (Shadow)
                    Color(0xFFFBF5B7), // Pale Gold (Reflection)
                    Color(0xFFAA771C), // Rich Gold
                  ],
                  stops: [0.0, 0.2, 0.5, 0.8, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image with Gold Border
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: goldAccent, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Color(0xFFD4AF37),
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Sarah Williams",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: charcoalText,
                    ),
                  ),
                  Text(
                    "sarah.w@jewels.com",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // --- MENU ITEMS ---
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerTile(
                    Icons.grid_view_rounded,
                    "Categories",
                    () => Navigator.pop(context),
                  ),
                  _drawerTile(Icons.person_outline, "My Profile", () {}),
                  _drawerTile(Icons.settings_outlined, "Settings", () {}),
                  const Divider(indent: 20, endIndent: 20, thickness: 0.5),
                ],
              ),
            ),

            // --- LOGOUT OPTION ---
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for consistent tile styling
  Widget _drawerTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: goldAccent), // Icons now use Gold
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: charcoalText,
        ),
      ),
      onTap: onTap,
    );
  }
}

// --- PRODUCT CARD COMPONENT ---
class ProductCard extends StatefulWidget {
  final String id, title, subtitle, price, imagePath;
  const ProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isWishlisted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  height: 130,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => setState(() => isWishlisted = !isWishlisted),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isWishlisted ? Icons.favorite : Icons.favorite_border,
                      color: isWishlisted
                          ? const Color(0xFFD4AF37)
                          : Colors.black54,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                Text(
                  widget.subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).addToCart(
                      CartItem(
                        id: widget.id,
                        title: widget.title,
                        price: widget.price,
                        imagePath: widget.imagePath,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to Bag"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    minimumSize: const Size(double.infinity, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
