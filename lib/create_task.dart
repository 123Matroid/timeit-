import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  List<String> progress = ['In Progress', 'Done'];
  String? selectedProgress = 'In Progress';
  final abteilungsController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.grey[800],
          onPressed: submit(),
          icon: const Icon(Icons.save_as_outlined),
          label: Text(
            'Speichern',
            style: GoogleFonts.quicksand(color: Colors.white),
          )),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: Stack(children: [
              Text(
                'Time It!',
                style: GoogleFonts.quicksand(
                  fontSize: 40,
                ),
              ),
              Image.asset('lib/899059.png')
            ]),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
              child: TextFormField(
                controller: abteilungsController,
                cursorColor: const Color(0xFF000000),
                decoration: InputDecoration(
                    hintText: 'Abteilung...',
                    hintStyle: GoogleFonts.quicksand(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.transparent))),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      icon: const Icon(Icons.calendar_today_outlined),
                      iconColor: Colors.black,
                      labelText: 'start date',
                      labelStyle: GoogleFonts.quicksand(color: Colors.black)),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat("yyyy-MM-dd").format(pickedDate);
                      setState(() {
                        dateController.text = formattedDate.toString();
                      });
                    } else {
                      // ignore: avoid_print
                      print('no Date Picked');
                    }
                  })),
          Center(
              child: SizedBox(
                  width: 380,
                  child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.grey[300],
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.task_alt_sharp),
                        prefixIconColor: Colors.black,
                        filled: false,
                        fillColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30))),
                    value: selectedProgress,
                    items: progress
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: GoogleFonts.quicksand())))
                        .toList(),
                    onChanged: (item) =>
                        setState(() => selectedProgress = item),
                  )))
        ]),
      ),
    );
  }

  submit() {}
}
