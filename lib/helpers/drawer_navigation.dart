import 'package:flutter/material.dart';
import 'package:smartpos/screens/categories_screen.dart';
import 'package:smartpos/screens/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Stanley Mbote'),
              accountEmail: Text('MboteStanley@mail.com'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Product'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoryScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
