import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
              child: Container(
                height: screenHeight * 0.75,
                child: Image.asset(
                  'assets/yelbck.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0), // Set the desired border radius
                    child: Image.asset(
                      'assets/park.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    _selectedDate == null
                        ? 'Select date'
                        : 'Selected date: ${DateFormat.yMMMd().format(_selectedDate!)}',
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      HeadingCard(heading: 'Number of Vehicles', centered: true),
                      HeadingCard(heading: 'Earnings', centered: true),
                      SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        children: [
                          SquareCard(
                              title: 'Card 1',
                              imagePath: 'assets/car.png'),
                          SquareCard(
                              title: 'Card 2',
                              imagePath: 'assets/bike.png'),
                          SquareCard(
                              title: 'Card 3',
                              imagePath: 'assets/lorry.png'),
                          SquareCard(
                              title: 'Card 4',
                              imagePath: 'assets/bus.png'),
                        ],
                      ),
                    ],
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

class HeadingCard extends StatelessWidget {
  final String heading;
  final String? text;
  final bool centered;

  HeadingCard({required this.heading, this.text, this.centered = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment:
            centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: centered ? TextAlign.center : TextAlign.start,
              ),
              if (text != null) ...[
                SizedBox(height: 8),
                Text(
                  text!,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class SquareCard extends StatelessWidget {
  final String title;
  final String imagePath;

  SquareCard({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2), // 80% transparent
              BlendMode.darken,
            ),
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0, 0),
                    blurRadius: 6.0,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
