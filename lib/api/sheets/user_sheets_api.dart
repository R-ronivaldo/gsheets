import 'package:gsheets/gsheets.dart';
import 'package:gsheets_flutter/model/user.dart';

class UserSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "vacinacao-pet-sesma-354405",
  "private_key_id": "b2fd7006ef6d574477a452830e1b5c9a43a14068",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDFhx2cpt6dmPua\nopLvHALEXY8f5pq2dDh1J2d9i/IHjWBq7wTu0L8vS+nUR2lLPIFYtKJKxtLWaU4Q\ndL5zILn3q+k7YCWi7EXM7L05A43kjxCf/uGVnjBZxbWnZ7GIFjCkm8Mvtx3LnpIx\nfOL2VGwXsXhOx998BA6+KoLBZwZfjI22XVG3KEXnQnvzf4V7KFNp7BHtl+8X3jad\nbsaN00/0DMKJZDU3APvfrySZE4dbnwxa6JtC2F+yYnES8b/BUC/nF/9080l+mOf5\nO4Sgf8mi5XXGcq9B0MO6md5StsNP2PaymU85lFEE/QvVSVQXb3qUL4Hu7zZV+Rzt\nmyoP5EP5AgMBAAECggEAXYh6jCg0N9ouIe4jt5fC86r9z/RJhGYKKeeLyNZQuCTI\n6DngUxmDvmirA7sA8ABpm1CFnPUC90aMEZzGZgu0I8RCv7vqdnh9IOllPK8jLHxW\nOfzeYxOx/4BwYSHn3fHr/LZJObnzIO0oesiRTGVzfdCqkFtyxu3A8Wl92wjm6qz0\nn9/SSEBV5vIeTC47QaVSrjsBypuGyiZ8tPGKcZOPj0XaO3ELy0WH+y5w1U+l3Z3g\n1EnBzlnkI3L5JpzOQzNGxXsiS7BtgHRa43REWi1mj2riw/3lxjljmpu5FGLpigv3\n68rnJ17MHkNHV385tZrpNYcKeAfJEPNIH5hRGQlE1QKBgQD34Y1qnQm/SfrAqe73\n17SStg1cXS2efXsh2NGq28aqkbGBOzcthyiMgcgbq5F62rJKAoVy5s9vr+zYew0G\nPR4pXQa/cBmusQi49Gdqat6nad/3lDP+z6oxgm8WPMgz1X/XP1x3iXHHh2/yMAnz\nLgr32D2WOi8alqqTQigafoSjVwKBgQDL/1u11jKi5hrN0i9XEgunAGSUE0EqBhqY\nidw6f1MTySW6xg1b7QtQhFDfgH1g15PR6Qie+Z1+rZs3UjqGyILzhLsaypiKgNzR\nEcD9iiD90fWgyVmK5wRUbqrczpV6IQ2/2ebFG79JMe09lufX/dIrgKv92Hv109g5\n16l3pWqRLwKBgQCJYYahCfv2+qdw1D3POsunbCKniDTaXC08KxC5IylOK4U3XHxO\nTVRZ2yvuuf3dGwwpHJCdh/J7sgMQT9J+HK10u0wcGaMCQLfW2g3e2vAf1Pv+GTNg\nC/QFkIbEylci8zbxMvqqfZCDxzpx/dHl5yTJDB3F/uVQVSSgjM/xLyGP7QKBgB9u\nn0DrWi4DaongIu81lpoK03SFavsAqcRrKYXR7IkV6zxWG+TYJ3Amkxd9AtSTIvGr\nCGsGZyAHu+zQPLhb2OGQyAuev9ZHeL62D5iBWggB++jkXWmrot0nmCghpKKGyUmQ\nV6BzYAv1J2rf/6UmNOYDE30viBoepCh1dGU9Fah9AoGBAPWFr1oYUSQXVP060vc1\n3B1SHEF9ccsVw5Cm6/myGc9xJjhfAB7MFV/FzT7ZswnnR0+HR4bYd+8ml6bohNyb\nSizR3eze3ux2dU5s6gkmLdlHDbY0uEbycVpWx0Dvzw7s2/5JNWs+vZmz63cNeQni\nvpGwa9qZy8Z3uapqM8rP/BE/\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@vacinacao-pet-sesma-354405.iam.gserviceaccount.com",
  "client_id": "114630640703125920109",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40vacinacao-pet-sesma-354405.iam.gserviceaccount.com"
}
''';

  static const _spreadsheetsId = "1Gp7kgbh9aNJ21nXI52Cw7IVlx_Lq2-IWXzHqrwdaX_Q";
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetsId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();

    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }
}
