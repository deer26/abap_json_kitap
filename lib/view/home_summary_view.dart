import 'package:flutter/material.dart';
import 'package:kitapisleri/model/kitaplar.dart';
import 'package:kitapisleri/model/servis.dart';

class HomeSummary extends StatefulWidget {
  @override
  _HomeSummaryState createState() => _HomeSummaryState();
}

class _HomeSummaryState extends State<HomeSummary> {
  TextEditingController _kitapAdi = TextEditingController();
  TextEditingController _basimYili = TextEditingController();
  TextEditingController _fiyat = TextEditingController();
  TextEditingController _fiyatBirimi = TextEditingController();
  TextEditingController _notlar = TextEditingController();
  TextEditingController _isbn = TextEditingController();
  TextEditingController _yazarNo = TextEditingController();
  int _kitapSayi = 0;
  Servis _servis = new Servis();
  @override
  void dispose() {
    _basimYili.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Container(
            color: Colors.cyanAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.book,
                  size: 110,
                  color: Colors.green,
                ),
                FutureBuilder(
                    future: _servis.getTotalKitaplar(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      print(snapshot.data);
                      if (snapshot.hasData) {
                        _kitapSayi = snapshot.data;
                        return Text(
                          "Total Book : $_kitapSayi",
                          // textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
          Container(
            color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    size: 110,
                    color: Colors.white,
                  ),
                  onPressed: _kitapEkle,
                  focusColor: Colors.grey,
                  hoverColor: Colors.red,
                  highlightColor: Colors.black,
                )
              ],
            ),
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  void _kitapEkle() {
    showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Text("Kitap Bilgileri"),
              elevation: 1,
              contentPadding: EdgeInsets.all(10),
              shape: BeveledRectangleBorder(
                side: BorderSide(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              children: <Widget>[
                Card(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _kitapAdi,
                          decoration: InputDecoration(hintText: "Kitap Adı"),
                        ),
                        TextFormField(
                          controller: _basimYili,
                          decoration: InputDecoration(
                            hintText: "Basım Yılı",
                          ),
                          onTap: () async {
                            DateTime date = DateTime(1900);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));

                            _basimYili.text =
                                "${date.day}.${date.month}.${date.year}";
                          },
                        ),
                        TextFormField(
                          controller: _fiyat,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: "Fiyat"),
                        ),
                        TextFormField(
                          controller: _fiyatBirimi,
                          decoration: InputDecoration(hintText: "Birim"),
                        ),
                        TextFormField(
                          controller: _notlar,
                          decoration: InputDecoration(hintText: "Notlar"),
                        ),
                        TextFormField(
                          controller: _isbn,
                          decoration: InputDecoration(hintText: "ISBN"),
                        ),
                        TextFormField(
                          controller: _yazarNo,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: "Yazar No"),
                        ),
                      ],
                    ),
                  ),
                ),
                OutlineButton(
                  onPressed: _kitapKaydet,
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.green,
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1,
                  ),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ],
            ));
  }

  _kitapKaydet() {
    DATA _gelenKitap = DATA();
    _gelenKitap.kITAPADI = _kitapAdi.text;
    _gelenKitap.bASIMTARIHI = _basimYili.text;
    _gelenKitap.fIYAT = _fiyat.text;
    _gelenKitap.fIYATBIRIMI = _fiyatBirimi.text;
    _gelenKitap.iSBN = int.parse(_isbn.text);
    _gelenKitap.yAZARNO = int.parse(_yazarNo.text);
    _gelenKitap.nOTLAR = _notlar.text;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Kitap Kaydetme"),
          content: new Text(
              "Girilen bilgilerdeki kitap kaydedilecek,devam edilsin mi ?"),
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
                _servis.postItem(_gelenKitap);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
