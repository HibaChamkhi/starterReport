import 'package:equatable/equatable.dart';

class ReportsState extends Equatable {
  const ReportsState(
      {this.isLoading = false,
        this.isSuccess = false,
        this.message = "",

      });
  final bool isLoading;
  final bool isSuccess;
  final String message;

  ReportsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return ReportsState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, message,isSuccess];
}
