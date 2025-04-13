class ChatModel {
  String name;
  String model;
  String modifiedAt;
  int size;
  String digest;
  String parameterSize;
  String quantizationLevel;
  bool isSelected = false;
  ChatModel({
    required this.name,
    required this.model,
    required this.modifiedAt,
    required this.size,
    required this.digest,
    required this.parameterSize,
    required this.quantizationLevel,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      name: map['name'] ?? '',
      model: map['model'] ?? '',
      modifiedAt: map['modified_at'] ?? '',
      size: map['size'] ?? 0,
      digest: map['digest'] ?? '',
      parameterSize: map['parameter_size'] ?? '',
      quantizationLevel: map['quantization_level'] ?? '',
    );
  }

  @override
  String toString() {
    return '\name => $name\n';
  }
}
