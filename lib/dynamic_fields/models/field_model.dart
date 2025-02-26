class FieldModel {
  final String key;
  final String label;
  final bool required;
  final String type;
  final List<String>? options;

  FieldModel({
    required this.key,
    required this.label,
    required this.required,
    required this.type,
    this.options,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      key: json['key'],
      label: json['label'],
      required: json['required'],
      type: json['type'],
      options: (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'label': label,
      'required': required,
      'type': type,
      'options': options,
    };
  }

  static List<FieldModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => FieldModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<FieldModel> fields) {
    return fields.map((field) => field.toJson()).toList();
  }
}
