import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/event_model.dart';


class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  Future<void> showEventInfo(Event event) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Conference: ${event.subject}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Subject: ${event.subject}'),
                Text('Speaker: ${event.speaker}'),
                Text('Date: ${DateFormat.yMd().add_jm().format(event.date.toDate())}'),
                Text('Type: ${event.type}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Events').snapshots(), 
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('No events found');
            }
            else if (snapshot.hasError) {
              return const Text('Error fetching events');
            }
            else {
              List<Event> events = [];
              for (var doc in snapshot.data!.docs) {
                events.add(Event.fromData(doc));
              }
              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  final avatar = event.avatar;
                  final conferenceName = event.subject;
                  final speakerName = event.speaker;
                  final confDate = event.date;
                  final confType = event.type;

                  return Card(
                    child: ListTile(
                      title: Text(conferenceName),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/$avatar.jpg'),
                      ),
                      trailing: IconButton(
                        onPressed: () { showEventInfo(event); }, 
                        icon: Icon(Icons.info_outline_rounded),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Speaker: $speakerName'),
                          Text('Date: ${DateFormat.yMd().add_jm().format(confDate.toDate())}'),
                          Text('Type: $confType'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        )
      );
  }
}
