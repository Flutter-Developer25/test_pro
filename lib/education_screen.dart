import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_pro/main.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  List<Map<String, dynamic>> educations = [
    {
      'college': '',
      'course': '',
      'cgpa': '',
      'startYear': '',
      'endYear': '',
      'isOngoing': false,
    },
  ];

  List<String> years = List.generate(30, (index) => (2000 + index).toString());

  void _addEducation() {
    setState(() {
      educations.add({
        'college': '',
        'course': '',
        'cgpa': '',
        'startYear': '',
        'endYear': '',
        'isOngoing': false,
      });
    });
  }

  void _saveAndContinue() {
    print(educations); // send to next screen or save
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundWaves()),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Your Education 📚',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'You can add multiple education entries',
                      style: GoogleFonts.poppins(color: Colors.white70),
                    ),
                    const SizedBox(height: 30),

                    ...educations.asMap().entries.map((entry) {
                      final i = entry.key;
                      final edu = entry.value;

                      return _buildEducationForm(i);
                    }).toList(),

                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: _addEducation,
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text('Add Another Education', style: TextStyle(color: Colors.white)),
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: _saveAndContinue,
                        child: const Text('Next →', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationForm(int index) {
    final data = educations[index];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          _textInput(
            label: 'College Name',
            value: data['college'],
            onChanged: (val) => setState(() => educations[index]['college'] = val),
          ),
          _textInput(
            label: 'Course',
            value: data['course'],
            onChanged: (val) => setState(() => educations[index]['course'] = val),
          ),
          _textInput(
            label: 'CGPA',
            value: data['cgpa'],
            onChanged: (val) => setState(() => educations[index]['cgpa'] = val),
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              Expanded(
                child: _dropdownField(
                  label: 'Start Year',
                  value: data['startYear'],
                  onChanged: (val) => setState(() => educations[index]['startYear'] = val),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: data['isOngoing']
                    ? const Text('Ongoing')
                    : _dropdownField(
                        label: 'End Year',
                        value: data['endYear'],
                        onChanged: (val) => setState(() => educations[index]['endYear'] = val),
                      ),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: data['isOngoing'],
                onChanged: (val) {
                  setState(() {
                    educations[index]['isOngoing'] = val!;
                    if (val) educations[index]['endYear'] = '';
                  });
                },
              ),
              const Text('Still Studying'),
            ],
          )
        ],
      ),
    );
  }

  Widget _textInput({
    required String label,
    required String value,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        initialValue: value,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dropdownField({
    required String label,
    required String value,
    required Function(String) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      value: value.isEmpty ? null : value,
      items: years.map((year) => DropdownMenuItem(value: year, child: Text(year))).toList(),
      onChanged: (va){},
    );
  }
}
