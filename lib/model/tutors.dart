class Tutors {
  String? tutorId;
  String? tutorEmail;
  String? tutorPhone;
  String? tutorName;
  String? tutorPassword;
  String? tutorDesc;
  String? tutorDatereg;

  Tutors(
      {this.tutorId,
      this.tutorEmail,
      this.tutorPhone,
      this.tutorName,
      this.tutorPassword,
      this.tutorDesc,
      this.tutorDatereg});

  Tutors.fromJson(Map<String, dynamic> json) {
    tutorId = json['tutor_id'];
    tutorEmail = json['tutor_email'];
    tutorPhone = json['tutor_phone'];
    tutorName = json['tutor_name'];
    tutorPassword = json['tutor_password'];
    tutorDesc = json['tutor_description'];
    tutorDatereg = json['tutor_datereg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tutor_id'] = tutorId;
    data['tutor_email'] = tutorEmail;
    data['tutor_phone'] = tutorPhone;
    data['tutor_name'] = tutorName;
    data['tutor_password'] = tutorPassword;
    data['tutor_description'] = tutorDesc;
    data['tutor_datereg'] = tutorDatereg;
    return data;
  }
}
