import 'dart:convert';
import 'package:http/http.dart';
import 'error/failure.dart';
import 'strings/failures.dart';

String mapFailureToMessage(Failure failure) {
  if (failure is ServerFailure) {
    return isArabic(failure.message) ? failure.message : "حدثت مشكلة.\n الرجاء معاودة المحاولة في وقت لاحق.";
  } else if (failure is OfflineFailure) {
    return OFFLINE_FAILURE_MESSAGE;
  } else {
    return "Unexpected Error , Please try again later .";
  }
}

String getErrorMessage(Response response) {
  final errorDecodedJson = json.decode(response.body) as Map<String, dynamic>;
  final error = errorDecodedJson["message"] as String;
  return error;
}


bool isArabic(String text) {
  LineSplitter ls = const LineSplitter();
  List<String> lines = ls.convert(text);

  if (lines.isEmpty) {
    return true;
  }

  var firstLine = lines.first.split(' ');
  if (firstLine.isEmpty) {
    return true;
  }

  for (var i = 0; i < firstLine[0].length; i++) {
    final codeUnit = firstLine[0].codeUnitAt(i);
    if ((codeUnit >= 0x0600 && codeUnit <= 0x06FF)) {
      return true;
    }
  }
  return false;
}