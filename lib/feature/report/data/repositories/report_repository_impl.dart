import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/error/exceptions.dart';
import '../../../../core/utils/error/failure.dart';
import '../../domain/repositories/report_repository.dart';
import '../dataSources/report_remote_data_source.dart';


class ReportRepositoryImpl extends ReportRepository {
  final ReportRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ReportRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> report(String idServiceToReport, String? type, String? reportingChoices, String? description , File? image) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.report( idServiceToReport,  type,  reportingChoices,  description ,  image);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }


}
