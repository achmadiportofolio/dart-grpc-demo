// import 'package:portofolio_grpc_dart/portofolio_grpc_dart.dart' as portofolio_grpc_dart;
import 'package:portofolio_grpc_dart/portofolio_grpc_dart.dart' ;

void main(List<String> arguments) {
  // print('Hello world: ${portofolio_grpc_dart.calculate()}!');
  final album = Album()..id=2..title="album 1";
  print(album);
  final album2 = Album.fromJson('{"1":"${albums[3]['id']}" , "2":"${albums[3]['title']}" }');
  print(album2);
  print(album2.clone());
  print(album2.copyWith((album) {
    album.setField(2, "update field 1");
  }));
}
