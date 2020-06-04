import 'package:flutter/material.dart';
import 'package:kitapisleri/model/kitaplar.dart';
import 'package:kitapisleri/model/servis.dart';
import 'package:kitapisleri/view/update_view.dart';

class KitapList extends StatefulWidget {
  @override
  _KitapListState createState() => _KitapListState();
}

class _KitapListState extends State<KitapList> {
  Kitaplar _kitaplar = new Kitaplar();
  Servis _servis = Servis();
  DATA _data = new DATA();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: _servis.getKitaplar(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _kitaplar = snapshot.data;
              return ListView.builder(
                  itemCount: _kitaplar.dATA.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Image(
                                image: NetworkImage(
                                    "https://picsum.photos/200/300/?blur")),
                            title: Text("${_kitaplar.dATA[index].kITAPADI}"),
                            subtitle: Text(
                                "${_kitaplar.dATA[index].bASIMTARIHI}-${_kitaplar.dATA[index].nOTLAR}"),
                          ),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: const Text('DELETE'),
                                onPressed: () {
                                  _silmeIsler(_kitaplar.dATA[index].kITAPNO);
                                },
                              ),
                              FlatButton(
                                  child: const Text('UPDATE'),
                                  onPressed: () {
                                    _data = _kitaplar.dATA[index];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                KitapUpdate(veri: _data)));
                                    setState(() {});
                                  }),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
            return CircularProgressIndicator();
          }),
    );
  }

  void _silmeIsler(int kITAPNO) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Kitap Silme"),
            content: new Text("Kitap silinecek,devam edilsin mi ?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("İptal"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Devam"),
                onPressed: () async {
                  _servis.deleteItem(kITAPNO);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
