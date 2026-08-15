import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _conferenceNameController = TextEditingController();
  final TextEditingController _speakerNameController = TextEditingController();
  DateTime selectedConfDate = DateTime.now();
  String confType = "Talk show";

  @override
  void dispose() {
    super.dispose();
    _conferenceNameController.dispose();
    _speakerNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _conferenceNameController,
              decoration: const InputDecoration(
                hintText: 'Enter the conference name',
                labelText: 'Conference name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the conference name';
                }
                return null;
              },
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            TextFormField(
              controller: _speakerNameController,
              decoration: const InputDecoration(
                hintText: 'Enter the speaker name',
                labelText: 'Speaker name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the speaker name';
                }
                return null;
              },
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  value: 'talk',
                  child: Text('Talk show'),
                ),
                DropdownMenuItem(
                  value: 'demo',
                  child: Text('Code demo'),
                ),
                DropdownMenuItem(
                  value: 'partner',
                  child: Text('Partner session'),
                ),
              ],
              onChanged: (value) {
                confType = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Select an option',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            DateTimeFormField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'Only text'
              ),
              mode: DateTimeFieldPickerMode.dateAndTime,
              autovalidateMode: AutovalidateMode.always,
              validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
              onDateSelected: (DateTime value) {
                setState(() {
                  selectedConfDate = value;
                });
              },
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    FocusScope.of(context).unfocus();
                    final conferenceName = _conferenceNameController.text;
                    final speakerName = _speakerNameController.text;

                    print('Conference Name: $conferenceName');
                    print('Speaker Name: $speakerName');
                    print('Session Type: $confType');
                    
                  }
                }, 
                child: Text('Add event'),
              ),
            ),
        ],
      ),
    )
    );
  }
}