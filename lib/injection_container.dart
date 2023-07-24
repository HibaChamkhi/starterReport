import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/network/network_info.dart';
import 'feature/report/data/dataSources/report_remote_data_source.dart';
import 'feature/report/data/repositories/report_repository_impl.dart';
import 'feature/report/domain/repositories/report_repository.dart';
import 'feature/report/domain/usecases/reports_use_case.dart';
import 'feature/report/presentation/bloc/reports_bloc.dart';



final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ReportsBloc( reportsUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => ReportsUseCase( repository: sl()));

  // Repository
  sl.registerLazySingleton<ReportRepository>(
      () => ReportRepositoryImpl(networkInfo: sl(), remoteDataSource: sl(), ));

  // DataSources
  sl.registerLazySingleton<ReportRemoteDataSource>(
      () => ReportRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());


//
}
