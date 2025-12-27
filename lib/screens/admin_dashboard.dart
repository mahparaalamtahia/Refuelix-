import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import 'login_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardHome(),
    const OrdersScreen(),
    const AgentsScreen(),
    const StationsScreen(),
    const AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle),
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, size: 20),
                    SizedBox(width: 8),
                    Text('Profile'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 20),
                    SizedBox(width: 8),
                    Text('Settings'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20, color: AppTheme.errorColor),
                    SizedBox(width: 8),
                    Text('Logout', style: TextStyle(color: AppTheme.errorColor)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outlined),
            selectedIcon: Icon(Icons.people),
            label: 'Agents',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_gas_station_outlined),
            selectedIcon: Icon(Icons.local_gas_station),
            label: 'Stations',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}

// Dashboard Home Screen
class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Card
          Card(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back, Admin!',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Here\'s what\'s happening with Refuelix today',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Stats Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _StatCard(
                title: 'Total Orders',
                value: '1,234',
                icon: Icons.shopping_cart,
                color: AppTheme.primaryColor,
                change: '+12%',
              ),
              _StatCard(
                title: 'Active Agents',
                value: '48',
                icon: Icons.people,
                color: AppTheme.secondaryColor,
                change: '+5',
              ),
              _StatCard(
                title: 'Fuel Stations',
                value: '23',
                icon: Icons.local_gas_station,
                color: AppTheme.successColor,
                change: '+2',
              ),
              _StatCard(
                title: 'Revenue',
                value: '৳125K',
                icon: Icons.attach_money,
                color: AppTheme.accentColor,
                change: '+18%',
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Recent Orders
          Text(
            'Recent Orders',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                _OrderListItem(
                  orderId: '#ORD-001',
                  customer: 'John Doe',
                  fuelType: 'Petrol',
                  quantity: '10L',
                  status: 'Delivered',
                  statusColor: AppTheme.successColor,
                ),
                const Divider(height: 1),
                _OrderListItem(
                  orderId: '#ORD-002',
                  customer: 'Jane Smith',
                  fuelType: 'Diesel',
                  quantity: '15L',
                  status: 'In Progress',
                  statusColor: AppTheme.warningColor,
                ),
                const Divider(height: 1),
                _OrderListItem(
                  orderId: '#ORD-003',
                  customer: 'Mike Johnson',
                  fuelType: 'Petrol',
                  quantity: '20L',
                  status: 'Pending',
                  statusColor: AppTheme.textSecondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String change;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    change,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.successColor,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Order List Item
class _OrderListItem extends StatelessWidget {
  final String orderId;
  final String customer;
  final String fuelType;
  final String quantity;
  final String status;
  final Color statusColor;

  const _OrderListItem({
    required this.orderId,
    required this.customer,
    required this.fuelType,
    required this.quantity,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.local_gas_station,
          color: AppTheme.primaryColor,
        ),
      ),
      title: Text(
        orderId,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        '$customer • $fuelType • $quantity',
        style: GoogleFonts.poppins(fontSize: 12),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: statusColor,
          ),
        ),
      ),
    );
  }
}

// Orders Screen
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Orders Management',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'View and manage all fuel orders',
              style: GoogleFonts.poppins(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Agents Screen
class AgentsScreen extends StatelessWidget {
  const AgentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outlined,
              size: 80,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Agents Management',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage delivery agents and their activities',
              style: GoogleFonts.poppins(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Stations Screen
class StationsScreen extends StatelessWidget {
  const StationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_gas_station_outlined,
              size: 80,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Fuel Stations',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage partner fuel stations',
              style: GoogleFonts.poppins(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Analytics Screen
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 80,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Analytics & Reports',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'View detailed analytics and insights',
              style: GoogleFonts.poppins(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

