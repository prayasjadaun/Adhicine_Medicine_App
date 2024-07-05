import 'package:adhicine_project_assignment/screens/home_page_screen.dart';
import 'package:flutter/material.dart';

class AddMedicinesScreen extends StatefulWidget {
  const AddMedicinesScreen({super.key});

  @override
  _AddMedicinesScreenState createState() => _AddMedicinesScreenState();
}

class _AddMedicinesScreenState extends State<AddMedicinesScreen> {
  int selectedCompartment = 1;
  Color selectedColor = Colors.pink;
  String selectedType = 'Tablet';
  double quantity = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Medicines')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search Medicine Name',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.mic),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 20),
          _buildSection(
              'Compartment',
              Row(
                children:
                    List.generate(6, (i) => _buildCompartmentButton(i + 1)),
              )),
          _buildSection(
              'Colour',
              Row(
                children: [
                  Colors.pink,
                  Colors.purple,
                  Colors.red,
                  Colors.green,
                  Colors.orange,
                  Colors.blue,
                  Colors.yellow
                ].map((c) => _buildColorButton(c)).toList(),
              )),
          _buildSection(
              'Type',
              Row(
                children: ['Tablet', 'Capsule', 'Cream', 'Liquid']
                    .map((t) => _buildTypeButton(t))
                    .toList(),
              )),
          _buildQuantitySection(),
          _buildSliderSection('Total Count', 1, 100, 1),
          _buildDateSection(),
          _buildDropdownSection('Frequency of Days', 'Everyday',
              ['Everyday', 'Every other day', 'Weekly']),
          _buildDropdownSection('How many times a Day', 'Three Time',
              ['Once', 'Twice', 'Three Time', 'Four Time']),
          _buildDoseSection(),
          _buildFoodSection(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePageScreen()));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Add', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        content,
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCompartmentButton(int number) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () => setState(() => selectedCompartment = number),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                selectedCompartment == number ? Colors.blue : Colors.grey[300],
            foregroundColor:
                selectedCompartment == number ? Colors.white : Colors.black,
          ),
          child: Text('$number'),
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () => setState(() => selectedColor = color),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
                color:
                    selectedColor == color ? Colors.black : Colors.transparent,
                width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeButton(String type) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            Icon(
              type == 'Tablet'
                  ? Icons.medication
                  : type == 'Capsule'
                      ? Icons.medication_liquid
                      : type == 'Cream'
                          ? Icons.sanitizer
                          : Icons.local_drink,
              color: selectedType == type ? Colors.blue : Colors.grey,
            ),
            Text(type,
                style: TextStyle(
                    color: selectedType == type ? Colors.blue : Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySection() {
    return Row(
      children: [
        const Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        const Text('Take 1/2 Pill'),
        IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () =>
                setState(() => quantity = (quantity - 0.5).clamp(0.5, 10))),
        IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                setState(() => quantity = (quantity + 0.5).clamp(0.5, 10))),
      ],
    );
  }

  Widget _buildSliderSection(String title, double min, double max, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Slider(
            value: value.toDouble(),
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            onChanged: (_) {}),
        Row(
          children: [
            Text('$min'),
            const Spacer(),
            Text('$value'),
            const Spacer(),
            Text('$max'),
          ],
        ),
      ],
    );
  }

  Widget _buildDateSection() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, foregroundColor: Colors.black),
            child: const Text('Today'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, foregroundColor: Colors.black),
            child: const Text('End Date'),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownSection(
      String title, String value, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        DropdownButtonFormField(
          value: value,
          items: options
              .map((o) => DropdownMenuItem(value: o, child: Text(o)))
              .toList(),
          onChanged: (_) {},
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }

  Widget _buildDoseSection() {
    return Column(
      children: [1, 2, 3]
          .map((i) => ListTile(
                leading: const Icon(Icons.access_time),
                title: Text('Dose $i'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ))
          .toList(),
    );
  }

  Widget _buildFoodSection() {
    return Row(
      children: ['Before Food', 'After Food', 'Before Sleep']
          .map((f) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black),
                    child: Text(f, textAlign: TextAlign.center),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
