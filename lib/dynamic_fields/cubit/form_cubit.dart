import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/field_model.dart';
import 'form_state.dart';

class FormCubit extends Cubit<FormFieldsState> {
  FormCubit() : super(FormInitial());

  Future<void> loadFields() async {
    try {
      emit(FormLoading());
      final response = await Dio().get('http://127.0.0.1:5000/form');

      List<FieldModel> fields = FieldModel.listFromJson(response.data['fields']);

      emit(FormLoaded(fields));
    } catch (e) {
      emit(FormError());
    }
  }
}
