
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:report/feature/report/presentation/bloc/reports_event.dart';
import 'package:report/feature/report/presentation/bloc/reports_state.dart';

import '../../../../core/utils/error/failure.dart';
import '../../../../core/utils/strings/failures.dart';
import '../../domain/usecases/reports_use_case.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ReportsUseCase reportsUseCase;

  ReportsBloc({required this.reportsUseCase}) : super(const ReportsState()) {
    on<ReportsEvent>((event, emit) async {
      emit(state.copyWith(isSuccess: false ,isLoading: true));
      if (event is ReportsButtonPressedEvent) {
        final failureOrReport = await reportsUseCase(event.idServiceToReport,
            event.type, event.reportingChoices, event.description ,event.image);
        failureOrReport.fold(
            (l) => emit(state.copyWith(
                isLoading: false,
                message: _mapFailureToMessage(l))), (r) async {
          emit(state.copyWith(isLoading: false, message: "",isSuccess: true));
        });
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is OfflineFailure) {
      return OFFLINE_FAILURE_MESSAGE;
    }
    return "Unexpected Error , Please try again later .";
  }
}
