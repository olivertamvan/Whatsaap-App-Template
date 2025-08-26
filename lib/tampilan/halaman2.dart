import 'package:flutter/material.dart';
import 'halaman3.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF725CAD).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.disabled_visible,
                        size: 100,
                        color: Color(0xFF725CAD),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Selamat Datang Di Vikontak',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Hubungan Baik Berawal Dari Cara Kita Berkomunikasi.\nTetap Terhubung Siapapun , Dimanapun , Dan Kapanpun',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF725CAD),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Mulai Sekarang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}