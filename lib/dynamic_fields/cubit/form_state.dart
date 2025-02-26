import 'package:equatable/equatable.dart';

import '../models/field_model.dart';

abstract class FormFieldsState extends Equatable {}

class FormInitial extends FormFieldsState {
  @override
  List<Object?> get props => [];
}

class FormLoading extends FormFieldsState {
  @override
  List<Object?> get props => [];
}

class FormLoaded extends FormFieldsState {
  FormLoaded(this.formFieldsList);
  final List<FieldModel> formFieldsList;
  @override
  List<Object?> get props => [formFieldsList];
}

class FormError extends FormFieldsState {
  @override
  List<Object?> get props => [];
}
