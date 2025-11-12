import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double height = 158;
  int weight = 50;
  int age = 24;
  String gender = '';

  void calculateBMI() {
    if (weight > 0 && height > 0 && gender.isNotEmpty) {
      double bmi = weight / ((height / 100) * (height / 100));
      String category;

      if (bmi < 18.5) {
        category = 'UNDERWEIGHT';
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        category = 'NORMAL';
      } else if (bmi >= 25 && bmi <= 29.9) {
        category = 'OVERWEIGHT';
      } else {
        category = 'OBESE';
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            bmiResult: bmi,
            category: category,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: GenderCard(
                    label: 'MALE',
                    icon: Icons.male,
                    selected: gender == 'male',
                    onTap: () {
                      setState(() {
                        gender = 'male';
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GenderCard(
                    label: 'FEMALE',
                    icon: Icons.female,
                    selected: gender == 'female',
                    onTap: () {
                      setState(() {
                        gender = 'female';
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Card(
              color: Colors.grey[850],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'HEIGHT',
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          height.toInt().toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'CM',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Slider(
                      value: height,
                      min: 120.0,
                      max: 220.0,
                      onChanged: (newHeight) {
                        setState(() {
                          height = newHeight;
                        });
                      },
                      activeColor: Colors.pink,
                      inactiveColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AgeWeightCard(
                    label: 'WEIGHT',
                    value: weight,
                    onPressedMinus: () {
                      setState(() {
                        if (weight > 0) weight--;
                      });
                    },
                    onPressedPlus: () {
                      setState(() {
                        weight++;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: AgeWeightCard(
                    label: 'AGE',
                    value: age,
                    onPressedMinus: () {
                      setState(() {
                        if (age > 0) age--;
                      });
                    },
                    onPressedPlus: () {
                      setState(() {
                        age++;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Check Your BM'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 80.0),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  GenderCard({required this.label, required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: selected ? Colors.pink : Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 75),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AgeWeightCard extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onPressedMinus;
  final VoidCallback onPressedPlus;

  AgeWeightCard({
    required this.label,
    required this.value,
    required this.onPressedMinus,
    required this.onPressedPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(label, style: TextStyle(color: Colors.white)),
            Text(
              value.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: onPressedMinus,
                  icon: Icon(Icons.remove, color: Colors.white),
                ),
                IconButton(
                  onPressed: onPressedPlus,
                  icon: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double bmiResult;
  final String category;

  ResultScreen({required this.bmiResult, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Your Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your BMI is:',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            Text(
              bmiResult.toStringAsFixed(1),
              style: TextStyle(fontSize: 50, color: Colors.green),
            ),
            Text(
              category,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Text(
              'Your body weight is classified as $category.',
              style: TextStyle(fontSize: 15, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Recalculate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 80.0),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}