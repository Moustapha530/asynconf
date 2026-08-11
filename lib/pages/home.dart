import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:asynconf/pages/event.dart';


class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Asyncof 2026'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/logo.svg',
                color: Colors.blueGrey,
              ),
              Text(
                'Asyncof 2026',
                style: TextStyle(
                    fontSize: 42,
                    fontFamily: 'Poppins'
                ),
              ),
              Text(
                'The Future of Asynchronous Programming',
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              ElevatedButton.icon(
                style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                    backgroundColor: WidgetStatePropertyAll(Colors.blueGrey)
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder: (_, _, _) => EventPage())
                  );
                },
                label: Text(
                  "Show planing",
                  style: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Poppins',
                      fontSize: 20
                  ),
                ),
                icon: Icon(Icons.calendar_month, color: Colors.white),
              )
            ],
          )
      ),
    );
  }
}

