import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import 'login_screen.dart';
import 'fuel_request_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const UserHomeScreen(),
    const OrderHistoryScreen(),
    const InvoicesScreen(),
    const NotificationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Refuelix'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              setState(() {
                _selectedIndex = 3; // Switch to notifications tab
              });
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
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Order History',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_outlined),
            selectedIcon: Icon(Icons.receipt),
            label: 'Invoices',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}

// User Home Screen
class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

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
                    'Welcome to Refuelix!',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fuel delivery at your fingertips',
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
          // Quick Actions
          Text(
            'Quick Actions',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _QuickActionCard(
                  title: 'New Order',
                  icon: Icons.add,
                  color: AppTheme.primaryColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FuelRequestScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _QuickActionCard(
                  title: 'Track Order',
                  icon: Icons.location_on,
                  color: AppTheme.secondaryColor,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Track order - Coming soon')),
                    );
                  },
                ),
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
                  fuelType: 'Petrol',
                  quantity: '10L',
                  status: 'Delivered',
                  statusColor: AppTheme.successColor,
                  date: 'Today, 2:30 PM',
                ),
                const Divider(height: 1),
                _OrderListItem(
                  orderId: '#ORD-002',
                  fuelType: 'Diesel',
                  quantity: '15L',
                  status: 'In Progress',
                  statusColor: AppTheme.warningColor,
                  date: 'Yesterday, 4:15 PM',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Quick Action Card
class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Order List Item for User
class _OrderListItem extends StatelessWidget {
  final String orderId;
  final String fuelType;
  final String quantity;
  final String status;
  final Color statusColor;
  final String date;

  const _OrderListItem({
    required this.orderId,
    required this.fuelType,
    required this.quantity,
    required this.status,
    required this.statusColor,
    required this.date,
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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$fuelType • $quantity',
            style: GoogleFonts.poppins(fontSize: 12),
          ),
          Text(
            date,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
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

// Order History Screen
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 10, // Mock data
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: _DetailedOrderItem(
              orderId: '#ORD-${(index + 1).toString().padLeft(3, '0')}',
              fuelType: index % 2 == 0 ? 'Petrol' : 'Diesel',
              quantity: '${(index + 1) * 5}L',
              status: index == 0 ? 'In Progress' : index < 3 ? 'Delivered' : 'Completed',
              statusColor: index == 0 ? AppTheme.warningColor : AppTheme.successColor,
              date: '2024-01-${(15 - index).toString().padLeft(2, '0')}',
              amount: '৳${((index + 1) * 5 * 120)}',
              station: 'Station ${index + 1}',
            ),
          );
        },
      ),
    );
  }
}

// Detailed Order Item
class _DetailedOrderItem extends StatelessWidget {
  final String orderId;
  final String fuelType;
  final String quantity;
  final String status;
  final Color statusColor;
  final String date;
  final String amount;
  final String station;

  const _DetailedOrderItem({
    required this.orderId,
    required this.fuelType,
    required this.quantity,
    required this.status,
    required this.statusColor,
    required this.date,
    required this.amount,
    required this.station,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Container(
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
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '$fuelType • $quantity • $station',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppTheme.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppTheme.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

// Invoices Screen
class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 8, // Mock data
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.receipt,
                  color: AppTheme.primaryColor,
                ),
              ),
              title: Text(
                'Invoice #INV-${(index + 1).toString().padLeft(3, '0')}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                'Order #ORD-${(index + 1).toString().padLeft(3, '0')} • ৳${((index + 1) * 5 * 120)}',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading invoice...')),
                  );
                },
              ),
              onTap: () {
                // View invoice details
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Viewing invoice details')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Notifications Screen
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _NotificationItem(
            title: 'Order Confirmed',
            message: 'Your order #ORD-001 has been confirmed and is being processed.',
            time: '2 hours ago',
            type: 'confirmation',
          ),
          _NotificationItem(
            title: 'Delivery Update',
            message: 'Your fuel delivery is on the way. ETA: 15 minutes.',
            time: '1 hour ago',
            type: 'delivery',
          ),
          _NotificationItem(
            title: 'Order Delivered',
            message: 'Your order #ORD-001 has been successfully delivered.',
            time: '30 minutes ago',
            type: 'delivered',
          ),
          _NotificationItem(
            title: 'Payment Successful',
            message: 'Payment of ৳1,200 for order #ORD-001 has been processed.',
            time: '25 minutes ago',
            type: 'payment',
          ),
          _NotificationItem(
            title: 'New Station Available',
            message: 'A new fuel station is now available in your area.',
            time: '1 day ago',
            type: 'info',
          ),
        ],
      ),
    );
  }
}

// Notification Item
class _NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final String type;

  const _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (type) {
      case 'confirmation':
        icon = Icons.check_circle;
        color = AppTheme.successColor;
        break;
      case 'delivery':
        icon = Icons.local_shipping;
        color = AppTheme.primaryColor;
        break;
      case 'delivered':
        icon = Icons.done_all;
        color = AppTheme.successColor;
        break;
      case 'payment':
        icon = Icons.payment;
        color = AppTheme.accentColor;
        break;
      default:
        icon = Icons.info;
        color = AppTheme.secondaryColor;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: GoogleFonts.poppins(fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}