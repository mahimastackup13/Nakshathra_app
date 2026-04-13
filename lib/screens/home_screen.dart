import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakshatra_app/provider/cart_provider.dart';
import 'package:nakshatra_app/screens/cart_screen.dart';
import 'package:nakshatra_app/screens/profile_screen.dart';
import 'package:nakshatra_app/screens/settings_screen.dart';
import 'package:provider/provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HOME SCREEN
// ─────────────────────────────────────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color emeraldGreen = const Color(0xFF2E513D);
  final Color goldAccent = const Color(0xFFD4AF37);

  // Sample products list (used for search)
  static const List<Map<String, String>> _allProducts = [
    {
      'id': '1',
      'title': 'Bangles Set',
      'subtitle': 'Gold',
      'price': '\$120.00',
      'imagePath': 'assets/images/product1.png',
      'category': 'Bracelets',
    },
    {
      'id': '2',
      'title': 'Wedding Set',
      'subtitle': 'Gold',
      'price': '\$369.00',
      'imagePath': 'assets/images/product5.png',
      'category': 'Wedding Sets',
    },
    {
      'id': '3',
      'title': 'Diamond Ring',
      'subtitle': 'Diamond and Gold',
      'price': '\$369.00',
      'imagePath': 'assets/images/product3.png',
      'category': 'Rings',
    },
    {
      'id': '4',
      'title': 'Necklace Set',
      'subtitle': 'Gold',
      'price': '\$369.00',
      'imagePath': 'assets/images/product2.png',
      'category': 'Necklaces',
    },
    {
      'id': '5',
      'title': 'Gold Earrings',
      'subtitle': 'Gold',
      'price': '\$89.00',
      'imagePath': 'assets/images/earring.png',
      'category': 'Earrings',
    },
    {
      'id': '6',
      'title': 'Gold Bracelet',
      'subtitle': 'Gold',
      'price': '\$149.00',
      'imagePath': 'assets/images/bracelet.png',
      'category': 'Bracelets',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const SideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // ── APP BAR ──────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      // ── SEARCH BUTTON ──────────────────────────────────
                      GestureDetector(
                        onTap: () => _openSearch(context),
                        child: _buildRoundIcon(
                          Icons.search,
                          Colors.white,
                          isPrimary: false,
                        ),
                      ),
                      const SizedBox(width: 10),
                      _buildCartIconWithBadge(context),
                      const SizedBox(width: 10),
                      // ── NOTIFICATION BUTTON ────────────────────────────
                      GestureDetector(
                        onTap: () => _openNotifications(context),
                        child: _buildNotificationIcon(),
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

              // ── PRODUCT GRID ─────────────────────────────────────────────
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

  // ── Open full-screen search ────────────────────────────────────────────────
  void _openSearch(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => SearchScreen(allProducts: _allProducts),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }

  // ── Open notifications bottom sheet ───────────────────────────────────────
  void _openNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NotificationsSheet(),
    );
  }

  // ── Notification icon with red dot ────────────────────────────────────────
  Widget _buildNotificationIcon() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildRoundIcon(
          Icons.notifications_none,
          Colors.white,
          isPrimary: false,
        ),
        Positioned(
          right: 2,
          top: 2,
          child: Container(
            width: 9,
            height: 9,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
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
              MaterialPageRoute(builder: (_) => const CartScreen()),
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

// ─────────────────────────────────────────────────────────────────────────────
// SEARCH SCREEN
// ─────────────────────────────────────────────────────────────────────────────
class SearchScreen extends StatefulWidget {
  final List<Map<String, String>> allProducts;
  const SearchScreen({super.key, required this.allProducts});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  static const Color _gold = Color(0xFFD4AF37);
  static const Color _goldDark = Color(0xFFB8860B);
  static const Color _bgCream = Color(0xFFFAF6EF);
  static const Color _textDark = Color(0xFF2C1A00);
  static const Color _textMuted = Color(0xFF8B6914);

  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Map<String, String>> _results = [];
  bool _hasSearched = false;

  final List<String> _recentSearches = [
    'Gold Necklace',
    'Diamond Ring',
    'Wedding Set',
    'Bangles',
  ];

  final List<String> _trendingTags = [
    'Earrings',
    'Bracelets',
    'Rings',
    'Necklaces',
    'Wedding Sets',
    'Diamond',
  ];

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
    // Auto-focus keyboard
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNode.requestFocus(),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _focusNode.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      setState(() {
        _results = [];
        _hasSearched = false;
      });
      return;
    }
    setState(() {
      _hasSearched = true;
      _results = widget.allProducts.where((p) {
        return p['title']!.toLowerCase().contains(q) ||
            p['subtitle']!.toLowerCase().contains(q) ||
            p['category']!.toLowerCase().contains(q);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(
            children: [
              // ── Search bar ───────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: _textDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Search field
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: _bgCream,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFFFD700).withOpacity(0.4),
                          ),
                        ),
                        child: TextField(
                          controller: _searchCtrl,
                          focusNode: _focusNode,
                          onChanged: _onSearch,
                          onSubmitted: _onSearch,
                          style: const TextStyle(
                            color: _textDark,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search jewellery...',
                            hintStyle: const TextStyle(
                              color: _textMuted,
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: _goldDark,
                              size: 20,
                            ),
                            suffixIcon: _searchCtrl.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _searchCtrl.clear();
                                      _onSearch('');
                                    },
                                    child: const Icon(
                                      Icons.close_rounded,
                                      color: _textMuted,
                                      size: 18,
                                    ),
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Body ────────────────────────────────────────────────────
              Expanded(
                child: _hasSearched
                    ? _buildSearchResults()
                    : _buildDiscoveryView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Discovery (pre-search) view ───────────────────────────────────────────
  Widget _buildDiscoveryView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent searches
          if (_recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Searches',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _recentSearches.clear()),
                  child: const Text(
                    'Clear all',
                    style: TextStyle(fontSize: 12, color: _goldDark),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._recentSearches.map(
              (s) => ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: const Icon(
                  Icons.history_rounded,
                  color: _textMuted,
                  size: 20,
                ),
                title: Text(
                  s,
                  style: const TextStyle(fontSize: 14, color: _textDark),
                ),
                trailing: const Icon(
                  Icons.north_west_rounded,
                  size: 16,
                  color: _textMuted,
                ),
                onTap: () {
                  _searchCtrl.text = s;
                  _onSearch(s);
                },
              ),
            ),
            const Divider(height: 28),
          ],

          // Trending tags
          const Text(
            'Trending',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _textDark,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _trendingTags
                .map(
                  (tag) => GestureDetector(
                    onTap: () {
                      _searchCtrl.text = tag;
                      _onSearch(tag);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _gold.withOpacity(0.4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            size: 14,
                            color: _goldDark,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            tag,
                            style: const TextStyle(
                              fontSize: 13,
                              color: _goldDark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ── Search results view ───────────────────────────────────────────────────
  Widget _buildSearchResults() {
    if (_results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: _gold.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'No results found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _textDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try a different keyword',
              style: TextStyle(fontSize: 13, color: _textMuted),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '${_results.length} result${_results.length == 1 ? '' : 's'} found',
            style: const TextStyle(fontSize: 13, color: _textMuted),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: _results.length,
            itemBuilder: (_, i) {
              final p = _results[i];
              return ProductCard(
                id: p['id']!,
                title: p['title']!,
                subtitle: p['subtitle']!,
                price: p['price']!,
                imagePath: p['imagePath']!,
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NOTIFICATIONS BOTTOM SHEET
// ─────────────────────────────────────────────────────────────────────────────
class NotificationsSheet extends StatefulWidget {
  const NotificationsSheet({super.key});

  @override
  State<NotificationsSheet> createState() => _NotificationsSheetState();
}

class _NotificationsSheetState extends State<NotificationsSheet> {
  static const Color _goldDark = Color(0xFFB8860B);
  static const Color _goldLight = Color(0xFFFFD700);
  static const Color _bgCream = Color(0xFFFAF6EF);
  static const Color _textDark = Color(0xFF2C1A00);
  static const Color _textMuted = Color(0xFF8B6914);

  final List<Map<String, dynamic>> _notifications = [
    {
      'icon': Icons.local_shipping_outlined,
      'title': 'Order Shipped!',
      'body': 'Your Bangles Set is on the way. Expected by tomorrow.',
      'time': '2 min ago',
      'isRead': false,
      'color': const Color(0xFF2E513D),
    },
    {
      'icon': Icons.local_offer_outlined,
      'title': '40% Off — Today Only!',
      'body': 'Flash sale on all Gold Necklaces. Don\'t miss out!',
      'time': '1 hr ago',
      'isRead': false,
      'color': Color(0xFFB8860B),
    },
    {
      'icon': Icons.star_rounded,
      'title': 'Review Your Purchase',
      'body': 'How was the Diamond Ring? Share your experience.',
      'time': '3 hrs ago',
      'isRead': true,
      'color': const Color(0xFFD4AF37),
    },
    {
      'icon': Icons.check_circle_outline_rounded,
      'title': 'Order Delivered',
      'body': 'Your Wedding Set has been delivered successfully.',
      'time': 'Yesterday',
      'isRead': true,
      'color': Colors.green,
    },
    {
      'icon': Icons.card_giftcard_outlined,
      'title': 'Refer & Earn ₹500',
      'body': 'Invite a friend and earn rewards on their first purchase.',
      'time': '2 days ago',
      'isRead': true,
      'color': const Color(0xFFB8860B),
    },
  ];

  int get _unreadCount =>
      _notifications.where((n) => !(n['isRead'] as bool)).length;

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n['isRead'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        children: [
          // ── Handle ───────────────────────────────────────────────────────
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // ── Header ───────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _textDark,
                      ),
                    ),
                    if (_unreadCount > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _goldDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$_unreadCount new',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (_unreadCount > 0)
                  GestureDetector(
                    onTap: _markAllRead,
                    child: const Text(
                      'Mark all read',
                      style: TextStyle(
                        fontSize: 13,
                        color: _goldDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Divider(height: 1, color: _goldLight.withOpacity(0.2)),

          // ── List ─────────────────────────────────────────────────────────
          Expanded(
            child: _notifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.notifications_off_outlined,
                          size: 56,
                          color: _goldLight.withOpacity(0.5),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No notifications yet',
                          style: TextStyle(
                            fontSize: 15,
                            color: _textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _notifications.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      indent: 72,
                      endIndent: 20,
                      color: _goldLight.withOpacity(0.15),
                    ),
                    itemBuilder: (_, i) {
                      final n = _notifications[i];
                      final isRead = n['isRead'] as bool;
                      return Dismissible(
                        key: ValueKey(i),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red.shade50,
                          child: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          ),
                        ),
                        onDismissed: (_) =>
                            setState(() => _notifications.removeAt(i)),
                        child: InkWell(
                          onTap: () => setState(() => n['isRead'] = true),
                          child: Container(
                            color: isRead ? Colors.transparent : _bgCream,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Icon circle
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: (n['color'] as Color).withOpacity(
                                      0.12,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    n['icon'] as IconData,
                                    color: n['color'] as Color,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                // Text
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              n['title'] as String,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: isRead
                                                    ? FontWeight.w500
                                                    : FontWeight.w700,
                                                color: _textDark,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            n['time'] as String,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: _textMuted,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        n['body'] as String,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: _textMuted,
                                          height: 1.4,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                // Unread dot
                                if (!isRead)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.only(
                                      top: 4,
                                      left: 8,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: _goldDark,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SIDE MENU (DRAWER)
// ─────────────────────────────────────────────────────────────────────────────
class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  final Color goldAccent = const Color(0xFFD4AF37);
  final Color charcoalText = const Color(0xFF2C2C2C);

  @override
  Widget build(BuildContext context) {
    double drawerWidth = MediaQuery.of(context).size.width * 0.70;

    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            // ── Gold gradient header ─────────────────────────────────────
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
                    Color(0xFFBF953F),
                    Color(0xFFFCF6BA),
                    Color(0xFFB38728),
                    Color(0xFFFBF5B7),
                    Color(0xFFAA771C),
                  ],
                  stops: [0.0, 0.2, 0.5, 0.8, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

            // ── Menu items ───────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerTile(
                    Icons.grid_view_rounded,
                    "Categories",
                    () => Navigator.pop(context),
                  ),
                  _drawerTile(Icons.person_outline, "My Profile", () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  }),
                  _drawerTile(Icons.settings_outlined, "Settings", () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  }),
                  const Divider(indent: 20, endIndent: 20, thickness: 0.5),
                ],
              ),
            ),

            // ── Logout ───────────────────────────────────────────────────
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

  Widget _drawerTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: goldAccent),
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

// ─────────────────────────────────────────────────────────────────────────────
// PRODUCT CARD
// ─────────────────────────────────────────────────────────────────────────────
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
