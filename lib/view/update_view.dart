import 'package:flutter/material.dart';
import 'package:kitapisleri/model/kitaplar.dart';
import 'package:kitapisleri/model/servis.dart';

class KitapUpdate extends StatefulWidget {
  final DATA veri;

  KitapUpdate({Key key, this.veri}) : super(key: key);

  @override
  _KitapUpdateState createState() => _KitapUpdateState();
}

class _KitapUpdateState extends State<KitapUpdate> {
  TextEditingController _kitapAdi = TextEditingController();
  TextEditingController _basimYili = TextEditingController();
  TextEditingController _fiyat = TextEditingController();
  TextEditingController _fiyatBirimi = TextEditingController();
  TextEditingController _notlar = TextEditingController();
  TextEditingController _isbn = TextEditingController();
  TextEditingController _yazarNo = TextEditingController();

  @override
  void initState() {
    _kitapAdi.text = widget.veri.kITAPADI;
    _basimYili.text = widget.veri.bASIMTARIHI;
    _fiyat.text = widget.veri.fIYAT;
    _fiyatBirimi.text = widget.veri.fIYATBIRIMI;
    _notlar.text = widget.veri.nOTLAR;
    _isbn.text = widget.veri.iSBN.toString();
    _yazarNo.text = widget.veri.yAZARNO.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SimpleDialog(
        title: Text("Kitap Güncelleme"),
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
                      FocusScope.of(context).requestFocus(new FocusNode());
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
            onPressed: () async {
              Servis _servis = Servis();
              widget.veri.bASIMTARIHI = _basimYili.text;
              widget.veri.fIYAT = _fiyat.text;
              widget.veri.fIYATBIRIMI = _fiyatBirimi.text;
              widget.veri.iSBN = int.parse(_isbn.text);
              widget.veri.kITAPADI = _kitapAdi.text;
              widget.veri.nOTLAR = _notlar.text;
              widget.veri.yAZARNO = int.parse(_yazarNo.text);
              Future _return = _servis.putItem(widget.veri);

              print(_return);
              Navigator.pop(context);
            },
            child: Icon(
              Icons.update,
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
          IconButton(
              icon: Icon(Icons.exit_to_app),
              splashColor: Colors.green,
              highlightColor: Colors.blue,
              color: Colors.grey,
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
