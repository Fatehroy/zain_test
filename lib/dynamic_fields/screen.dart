import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zain_test/dynamic_fields/models/field_model.dart';
import 'package:zain_test/dynamic_fields/widgets/dynamic_field.dart';

import 'cubit/form_cubit.dart';
import 'cubit/form_state.dart';

class DynamicFieldsScreen extends StatefulWidget {
  const DynamicFieldsScreen({super.key});

  @override
  State<DynamicFieldsScreen> createState() => _DynamicFieldsScreenState();
}

class _DynamicFieldsScreenState extends State<DynamicFieldsScreen> {
  final FormCubit formCubit = FormCubit();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    formCubit.loadFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => formCubit,
      child: Scaffold(
        body: BlocBuilder<FormCubit, FormFieldsState>(
          builder: (context, state) {
            if (state is FormError) {
              return Center(child: Text("Something went Wrong"));
            }
            if (state is FormLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is FormLoaded) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (FieldModel fieldModel in state.formFieldsList)
                        DynamicField(fieldModel: fieldModel),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                            }
                          },
                          child: Text("Submit"))
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
