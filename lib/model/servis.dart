import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitapisleri/model/kitaplar.dart';

class Servis {
  final String url =
      "http://b2btest.federalmogul.com.tr:1081/sap/bc/yhkdeneme?sap-client=021/";

  Kitaplar kitaplar = new Kitaplar();

  Future getTotalKitaplar() async {
    // String username = 'fhuseyink';
    // String password = '1q2w3e';
    // String basicAuth =
    //     'Basic ' + base64Encode(utf8.encode('$username:$password'));
    // print(basicAuth);
    final response = await http.get(url);
    if (response.statusCode == 404) {
      return null;
    } else {
      kitaplar = Kitaplar.fromJson(json.decode(response.body));
      return kitaplar.dATA.length;
    }
  }

  Future getKitaplar() async {
    final response = await http.get(url);
    if (response.statusCode == 404) {
      return null;
    } else {
      kitaplar = Kitaplar.fromJson(json.decode(response.body));
      return kitaplar;
    }
  }

  postItem(DATA gelenKitap) async {
    Kitaplar _kitaplar = Kitaplar();

    DATA _data = DATA(
        bASIMTARIHI: gelenKitap.bASIMTARIHI,
        cLIENT: "021",
        fIYAT: gelenKitap.fIYAT,
        fIYATBIRIMI: gelenKitap.fIYATBIRIMI,
        iSBN: gelenKitap.iSBN,
        kITAPADI: gelenKitap.kITAPADI,
        kITAPNO: 14,
        nOTLAR: gelenKitap.nOTLAR,
        yAZARNO: gelenKitap.yAZARNO);
    _kitaplar.mSG = "flutter eklentisi";
    _kitaplar.sUCCESS = "true";
    List<DATA> _datalar = List();
    _datalar.add(_data);
    _kitaplar.dATA = _datalar;
    var _jsonModel = json.encode(_kitaplar.toJson());

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Content-type": "application/json"
        },
        body: _jsonModel);

    print(response.statusCode);
  }

  Future putItem(DATA gelenKitap) async {
    Kitaplar _kitaplar = Kitaplar();

    DATA _data = DATA(
        bASIMTARIHI: gelenKitap.bASIMTARIHI,
        cLIENT: "021",
        fIYAT: gelenKitap.fIYAT,
        fIYATBIRIMI: gelenKitap.fIYATBIRIMI,
        iSBN: gelenKitap.iSBN,
        kITAPADI: gelenKitap.kITAPADI,
        kITAPNO: gelenKitap.kITAPNO,
        nOTLAR: gelenKitap.nOTLAR,
        yAZARNO: gelenKitap.yAZARNO);
    _kitaplar.mSG = "flutter eklentisi";
    _kitaplar.sUCCESS = "true";
    List<DATA> _datalar = List();
    _datalar.add(_data);
    _kitaplar.dATA = _datalar;
    var _jsonModel = json.encode(_kitaplar.toJson());

    final response = await http.put(url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Content-type": "application/json"
        },
        body: _jsonModel);

    return (response.statusCode);
  }

  Future deleteItem(int kitapNo) async {
    final response = await http.delete(
      "$url${kitapNo.toString()}",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Content-type": "application/json"
      },
    );

    return (response.statusCode);
  }
}
