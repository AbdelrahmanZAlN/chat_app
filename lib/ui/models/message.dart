class Message{
  String message;
  String email;
  var time;
  Message({
    required this.message,
    required this.email,
    required this.time,
});
  
  factory Message.fromJson(json){
    return 
      Message(
        message: json['message'],
        email: json['userEmail'],
        time: json['time']

      );
  }

}