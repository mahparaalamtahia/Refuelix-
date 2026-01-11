import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import 'tracking_screen.dart';

class FuelRequestScreen extends StatefulWidget {
  const FuelRequestScreen({super.key});

  @override
  State<FuelRequestScreen> createState() => _FuelRequestScreenState();
}

class _FuelRequestScreenState extends State<FuelRequestScreen> {
  String _selectedFuelType = 'Petrol';
  double _quantity = 10.0;
  bool _isLoading = false;

  final List<String> _fuelTypes = ['Petrol', 'Diesel'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Request Fuel',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fuel Type Selection
            Text(
              'Select Fuel Type',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: _fuelTypes.map((type) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _FuelTypeCard(
                      type: type,
                      isSelected: _selectedFuelType == type,
                      onTap: () {
                        setState(() {
                          _selectedFuelType = type;
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Quantity Selection
            Text(
              'Select Quantity (Liters)',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '${_quantity.toStringAsFixed(1)} L',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: _quantity,
                      min: 5.0,
                      max: 50.0,
                      divisions: 45,
                      activeColor: AppTheme.primaryColor,
                      inactiveColor: AppTheme.primaryColor.withOpacity(0.3),
                      onChanged: (value) {
                        setState(() {
                          _quantity = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '5L',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                        Text(
                          '50L',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Estimated Price
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Estimated Price',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '৳${(_quantity * 120).toStringAsFixed(0)}',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cash on Delivery',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Request Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitRequest,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Request Fuel',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitRequest() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Navigate to tracking screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrackingScreen(
          fuelType: _selectedFuelType,
          quantity: _quantity,
          orderId: '#ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        ),
      ),
    );
  }
}

class _FuelTypeCard extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const _FuelTypeCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppTheme.primaryColor : Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              Icon(
                type == 'Petrol' ? Icons.local_gas_station : Icons.oil_barrel,
                color: isSelected ? Colors.white : AppTheme.primaryColor,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                type,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}