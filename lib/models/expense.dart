import 'package:kitchenowl/models/model.dart';

import 'nullable.dart';

class Expense extends Model {
  final int? id;
  final String name;
  final double amount;
  final DateTime? createdAt;
  final String? category;
  final int paidById;
  final List<PaidForModel> paidFor;

  const Expense({
    this.id,
    this.name = '',
    this.amount = 0,
    required this.paidById,
    this.paidFor = const [],
    this.createdAt,
    this.category,
  });

  factory Expense.fromJson(Map<String, dynamic> map) {
    List<PaidForModel> paidFor = const [];
    if (map.containsKey('paid_for')) {
      paidFor = List.from(map['paid_for'].map((e) => PaidForModel.fromJson(e)));
    }

    return Expense(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      category: map['category'],
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(map['created_at'], isUtc: true)
              .toLocal(),
      paidById: map['paid_by_id'],
      paidFor: paidFor,
    );
  }

  Expense copyWith({
    String? name,
    double? amount,
    Nullable<String>? category,
    int? paidById,
    List<PaidForModel>? paidFor,
  }) =>
      Expense(
        id: id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        category: (category ?? Nullable(this.category)).value,
        paidById: paidById ?? this.paidById,
        paidFor: paidFor ?? this.paidFor,
      );

  @override
  List<Object?> get props =>
      [id, name, amount, category, createdAt, paidById] + paidFor;

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        'category': category,
        "paid_by": {"id": paidById},
        "paid_for": paidFor.map((e) => e.toJson()).toList(),
      };

  @override
  Map<String, dynamic> toJsonWithId() => toJson()
    ..addAll({
      "id": id,
    });
}

class PaidForModel extends Model {
  final int userId;
  final int factor;

  const PaidForModel({required this.userId, this.factor = 1});

  @override
  List<Object?> get props => [userId, factor];

  @override
  Map<String, dynamic> toJson() => {
        "id": userId,
        "factor": factor,
      };

  factory PaidForModel.fromJson(Map<String, dynamic> map) {
    return PaidForModel(
      userId: map['user_id'],
      factor: map['factor'],
    );
  }
}
