import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/utils/error/failure.dart';

abstract class ReportRepository {
  Future<Either<Failure, Unit>> report(String idServiceToReport, String? type, String? reportingChoices, String? description , File? image);

}
