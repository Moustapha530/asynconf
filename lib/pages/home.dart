import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:asynconf/pages/event.dart';


class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
            ],
          )
      );
  }
}

