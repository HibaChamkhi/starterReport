import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/error/exceptions.dart';
import '../../../../core/utils/strings/strings.dart';
import 'dart:async';
import 'package:http_parser/http_parser.dart';

abstract class ReportRemoteDataSource {
  Future<Unit> report(String idServiceToReport, String? type, String? reportingChoices, String? description , File? image);

}
var reportUrl = '';

class ReportRemoteDataSourceImpl extends ReportRemoteDataSource {

  final http.Client client;

  ReportRemoteDataSourceImpl({required this.client});


  @override
  Future<Unit> report(String idServiceToReport, String? type, String? reportingChoices, String? description , File? image)  async {
    const token = "";
    var request = http.MultipartRequest('PUT', Uri.parse(reportUrl));

    request.fields['idServiceToReport'] = idServiceToReport;

    if (type!= null) {
      request.fields['type'] = type;
    }

    if (reportingChoices != null) {
      request.fields['reportingChoices'] = reportingChoices;
    }

    if (description != null) {
      request.fields['description'] = description;
    }

    if (image != null) {
      String mimeType = "image/jpg";
      request.files.add(await http.MultipartFile.fromPath(
        //put the name of the image used in your api
        'image',
        image!.path,
        contentType: MediaType.parse(mimeType),
      ));
    }

    request.headers['Authorization'] = 'Bearer $token';
    final response = await request.send();
    final responseJson = json.decode(await response.stream.bytesToString());
    if (responseJson == null) {
      throw const ServerException(message: "Failed to decode server response");
    }
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException(message: responseJson['message']);
    }
  }



}


