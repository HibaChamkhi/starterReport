
import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();
}


class  ReportsButtonPressedEvent extends ReportsEvent {
  final String idServiceToReport;
  final  String? type;
  final String? reportingChoices;
  final String? description ;
  final File? image ;
  const ReportsButtonPressedEvent({
     required this.idServiceToReport,
     this.type,
     this.reportingChoices,
     this.description,
     this.image,
  });

  @override
  List<Object?> get props => throw UnimplementedError();


}