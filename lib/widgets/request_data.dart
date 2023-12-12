
class Request {
  int? idReq;
  String? adress_req;
  DateTime? dateReq;
  bool? isCompleted;

  Request({
    this.idReq,
    this.adress_req,
    this.dateReq,
    this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_req': idReq,
      'adress_req': adress_req,
      'date_time_req': dateReq?.toIso8601String(),
      'is_completed': isCompleted,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      idReq: map['id_req'],
      adress_req: map['adress_req'],
      dateReq: DateTime.tryParse(map['date_time_req']),
      isCompleted: map['is_completed'],
    );
  }
}
