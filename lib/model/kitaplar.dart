class Kitaplar {
  String sUCCESS;
  String mSG;
  List<DATA> dATA;

  Kitaplar({this.sUCCESS, this.mSG, this.dATA});

  Kitaplar.fromJson(Map<String, dynamic> json) {
    sUCCESS = json['SUCCESS'];
    mSG = json['MSG'];
    if (json['DATA'] != null) {
      dATA = new List<DATA>();
      json['DATA'].forEach((v) {
        dATA.add(new DATA.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SUCCESS'] = this.sUCCESS;
    data['MSG'] = this.mSG;
    if (this.dATA != null) {
      data['DATA'] = this.dATA.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DATA {
  String cLIENT;
  int kITAPNO;
  String kITAPADI;
  String bASIMTARIHI;
  String fIYAT;
  String fIYATBIRIMI;
  String nOTLAR;
  int iSBN;
  int yAZARNO;

  DATA(
      {this.cLIENT,
      this.kITAPNO,
      this.kITAPADI,
      this.bASIMTARIHI,
      this.fIYAT,
      this.fIYATBIRIMI,
      this.nOTLAR,
      this.iSBN,
      this.yAZARNO});

  DATA.fromJson(Map<String, dynamic> json) {
    cLIENT = json['CLIENT'];
    kITAPNO = json['KITAP_NO'];
    kITAPADI = json['KITAP_ADI'];
    bASIMTARIHI = json['BASIM_TARIHI'];
    fIYAT =  json['FIYAT'].toString();
    fIYATBIRIMI = json['FIYAT_BIRIMI'];
    nOTLAR = json['NOTLAR'];
    iSBN = json['ISBN'];
    yAZARNO = json['YAZAR_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CLIENT'] = this.cLIENT;
    data['KITAP_NO'] = this.kITAPNO;
    data['KITAP_ADI'] = this.kITAPADI;
    data['BASIM_TARIHI'] = this.bASIMTARIHI;
    data['FIYAT'] = this.fIYAT;
    data['FIYAT_BIRIMI'] = this.fIYATBIRIMI;
    data['NOTLAR'] = this.nOTLAR;
    data['ISBN'] = this.iSBN;
    data['YAZAR_NO'] = this.yAZARNO;
    return data;
  }
}
