import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/utils/error/failure.dart';
import '../repositories/report_repository.dart';


class ReportsUseCase {
  final ReportRepository repository;

  ReportsUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(String idServiceToReport, String? type, String? reportingChoices, String? description , File? image) async {
    return await repository.report( idServiceToReport,  type ,  reportingChoices,  description ,  image);
  }
}
