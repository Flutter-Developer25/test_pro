import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MaterialApp(home: ResumeFormScreen()));

class ResumeFormScreen extends StatefulWidget {
  const ResumeFormScreen({super.key});

  @override
  State<ResumeFormScreen> createState() => _ResumeFormScreenState();
}

class _ResumeFormScreenState extends State<ResumeFormScreen> {
  final Map<String, String> personalInfo = {};
  final List<Map<String, dynamic>> educationList = [];

  final _personalFormKey = GlobalKey<FormState>();

  Map<String, dynamic> currentEdu = {
    'college': '',
    'course': '',
    'cgpa': '',
    'startYear': '',
    'startMonth': '',
    'endYear': '',
    'endMonth': '',
    'isOngoing': false,
  };

  void _saveEducation() {
    if (currentEdu['college'].isEmpty || currentEdu['course'].isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in at least College and Course')),
      );
      return;
    }
    setState(() {
      educationList.add({...currentEdu});
      currentEdu = {
        'college': '',
        'course': '',
        'cgpa': '',
        'startYear': '',
        'startMonth': '',
        'endYear': '',
        'endMonth': '',
        'isOngoing': false,
      };
    });
  }

  Widget _textField(String label, String key, {Map<String, dynamic>? data, TextInputType type = TextInputType.text, int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: data?[key] ?? '',
        keyboardType: type,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          counterText: '',
        ),
        onChanged: (val) => data != null ? data[key] = val : personalInfo[key] = val,
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _personalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Personal Information"),
        Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              SizedBox(width:400, child: _textField('Full Name', 'name')),
              SizedBox(width:400, child: _textField('Email', 'email')),
              SizedBox(width:400, child: _textField('Phone', 'phone')),
              SizedBox(width:400, child: _textField('LinkedIn', 'linkedin')),
              SizedBox(width:400, child: _textField('GitHub', 'github')),
              SizedBox(width:400, child: _textField('Portfolio', 'portfolio')),
              SizedBox(width:400, child: _textField('Gender (optional)', 'gender')),
            ],
          ),
        )
      ],
    );
  }

  Widget _educationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Education"),
        Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              SizedBox(width:400, child: _textField('College Name', 'college', data: currentEdu)),
              SizedBox(width:400, child: _textField('Course', 'course', data: currentEdu)),
              SizedBox(width:400, child: _textField('CGPA', 'cgpa', type: TextInputType.number, data: currentEdu)),
               SizedBox(width:250,child: _textField('Start Year', 'startYear', maxLength: 4, type: TextInputType.number, data: currentEdu)),
                  SizedBox(width:250,child: _textField('Start Month', 'startMonth', maxLength: 2, type: TextInputType.number, data: currentEdu)),
                    if (!currentEdu['isOngoing'])...[
                    SizedBox(width:250,child: _textField('End Year', 'endYear', maxLength: 4, type: TextInputType.number, data: currentEdu)),
            
               SizedBox(width:250,child: _textField('End Month', 'endMonth', maxLength: 2, type: TextInputType.number, data: currentEdu)),
                SizedBox(width:250,
                   child: Row(
                             children: [
                               Checkbox(
                                 value: currentEdu['isOngoing'],
                                 onChanged: (val) => setState(() => currentEdu['isOngoing'] = val!),
                               ),
                               const Text("Ongoing"),
                             ],
                           ),
                 ),
                    ]
            ],
          ),
        ),
       
      
     
        Center(
          child: ElevatedButton.icon(
            onPressed: _saveEducation,
            icon: const Icon(Icons.save,color: Colors.white,),
            label: const Text("Save Education",style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
          ),
        ),
        const Divider(),
        ...educationList.map((edu) => ListTile(
              title: Text(edu['college']),
              subtitle: Text('${edu['course']} (${edu['startYear']}/${edu['startMonth']})'),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundWaves()),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 280, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _personalInfoSection(),
                    const SizedBox(height: 40),
                    _educationSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class BackgroundWaves extends StatelessWidget {
  const BackgroundWaves({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: CustomPaint(
            painter: _WavePainter(),
          ),
        ),
        Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                'Build Your Resume',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Create stunning, professional resumes effortlessly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Modern design. Smart templates. Instant PDF export.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Main wave - bottom
    final paint1 = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFFB24592), Color(0xFFF15F79)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    final path1 = Path()
      ..lineTo(0, size.height * 0.35)
      ..quadraticBezierTo(
          size.width * 0.5, size.height * 0.5, size.width, size.height * 0.35)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path1, paint1);

    // Highlight wave - top
    final paint2 = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFFFBD3E9), Color(0xFFBB377D)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ).createShader(rect);

    final path2 = Path()
      ..lineTo(0, size.height * 0.25)
      ..quadraticBezierTo(
          size.width * 0.5, size.height * 0.4, size.width, size.height * 0.25)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
