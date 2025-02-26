import 'package:flutter/material.dart';

import '../models/field_model.dart';

class DynamicField extends StatelessWidget {
  const DynamicField({super.key, required this.fieldModel});

  final FieldModel fieldModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: _getKeyboardTypeByField(fieldModel.type),
        decoration: InputDecoration(
          hintText: fieldModel.label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if ((value == null || value.isEmpty) && fieldModel.required) {
            return '${fieldModel.key} is Required';
          }
          return null;
        },
      ),
    );
  }

  TextInputType _getKeyboardTypeByField(String type) {
    return switch (type) {
      "text" => TextInputType.text,
      "email" => TextInputType.emailAddress,
      "number" => TextInputType.number,
      _ => TextInputType.text,
    };
  }
}
