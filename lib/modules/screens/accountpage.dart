import 'package:flutter/material.dart';

import '../../data.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackTheme(),
      child: Scaffold(
        appBar: AppBar(
          //shape: Border.all(color: Colors.black38),
          title: Text("Account"),
        ),
        body: Column(
          children: [
            //profile Botton
            customOutLineBotton(
                context, Icon(Icons.person_2_outlined), "Profile"),
            customOutLineBotton(context, Icon(Icons.badge), "Order"),
            customOutLineBotton(context, Icon(Icons.location_on), "Address"),
            customOutLineBotton(context, Icon(Icons.credit_card), "Payment"),
          ],
        ),
      ),
    );
  }
}

//Custom Widget for OutlinedButton.icon
OutlinedButton customOutLineBotton(
    BuildContext context, Icon icon, String text) {
  return OutlinedButton.icon(
    style: OutlinedButton.styleFrom(
      alignment: Alignment.centerLeft,
      fixedSize: Size(MediaQuery.of(context).size.width, 60),
    ),
    onPressed: () {},
    icon: Icon(icon.icon, size: 26),
    label: Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium,
    ),
  );
}
