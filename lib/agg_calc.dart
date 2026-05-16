import 'package:flutter/material.dart';


class AggScreen extends StatefulWidget {
  const AggScreen({super.key});

  @override
  State<AggScreen> createState() => _AggScreenState();
}

class _AggScreenState extends State<AggScreen> {
  final TextEditingController olevelController = TextEditingController();
  final TextEditingController utmeController = TextEditingController();

  String selectedGrade = 'A1';

  List<Map<String, dynamic>> subjects = [];

  int totalOlevelPoints = 0;
  double aggreGate = 0.00;

  get utmePoint => null;

  int getOlevelGrade(String grade) {
    switch (grade){
      case 'A1':
        return 6;
      case 'B2':
        return 5;
      case 'B3':
        return 4;
      case 'C4':
        return 3;
      case 'C5':
        return 2;
      case 'C6':
        return 1;
      case 'F9':
        return 0;
      default:
        return 0;
    }
  }

  void addSubjects () {
    String subject = olevelController.text.trim();
    int? utmeScore = int.tryParse(utmeController.text.trim());

    if (subject.isEmpty || utmeScore == null || utmeScore <= 0) {
      return;
    }

    int olevelPoint = getOlevelGrade(selectedGrade);
    double utmePoint = utmeScore / 6.667;

    setState(() {
      subjects.add({
        'name' : subject,
        'grade' : selectedGrade,
      });

      totalOlevelPoints += olevelPoint;
      aggreGate = utmePoint + totalOlevelPoints;

      olevelController.clear();
      utmeController.clear();
      selectedGrade = 'A1';
    });
  }
  void resetAll(){
    setState(() {
      subjects.clear();
      totalOlevelPoints = 0;
      aggreGate = 0.00;

      olevelController.clear();
      utmeController.clear();
      selectedGrade = 'A1';
    });
  }
  void deleteSubject(int index){
    setState(() {
      totalOlevelPoints -= subjects[index]['name'] as int;
      aggreGate -= subjects[index]['grade'] as int;

      subjects.removeAt(index);

      if (totalOlevelPoints == 0) {
        aggreGate = 0.00;
      } else {
        aggreGate = utmePoint + totalOlevelPoints;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Triangle Area Calculation',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(60),
        child: Column(
          children: [
            TextField(
              controller: olevelController,
              decoration: InputDecoration(
                labelText: 'O-level Subject',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'O-level Grade',
                border: OutlineInputBorder(),
              ),
              items: ['A1', 'B2', 'B3', 'C4', 'C5', 'C6', 'F9']
                  .map(
                    (grade) => DropdownMenuItem(
                  value: grade,
                  child: Text(grade),
                ),
              )
                  .toList(),

              onChanged: (value) {
                setState(() {
                  selectedGrade = value!;
                });
              },
            ),
            SizedBox(height: 20),

            TextField(
              controller: utmeController,
              decoration: InputDecoration(
                labelText: 'UTME Score',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 40),

            ElevatedButton(
              onPressed: addSubjects,
              child: Text(
                'Add Subjects',
                style: TextStyle(color: Colors.red[900]),
              ),
            ),
            SizedBox(height: 80),

            if (subjects.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];

                  return Card(
                    child: ListTile(
                      title: Text(subject['name']),
                      subtitle: Text(
                        'Grade ${subject['grade']}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteSubject(index),
                      ),
                    ),
                  );
                },
              ),

            Text(
              'Total Olevel Points: $totalOlevelPoints',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            Text(
              'AGGREGATE: $aggreGate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),

            ElevatedButton(
              onPressed: resetAll,
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.red[800]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
