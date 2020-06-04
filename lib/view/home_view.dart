import 'package:flutter/material.dart';
import 'package:kitapisleri/view/home_summary_view.dart';
import 'package:kitapisleri/view/kitap_list_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SAP Enetegrasyonu"),),
      body: Center(
        child: PageView(
          children: <Widget>[
           HomeSummary(),
           KitapList(),
            Container(color: Colors.red,),
          ],
        ),
      ),
    );
  }
}
