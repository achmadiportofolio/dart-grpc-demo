import 'package:grpc/grpc.dart';
import 'package:portofolio_grpc_dart/portofolio_grpc_dart.dart' ;

void main(args) async {
  final channel = ClientChannel(
    'localhost',
    port: 5001,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure())

  );
  final stub = AlbumServiceClient(channel);
  var response =  await stub.getAlbums(AlbumRequest());
  // print('client response ${response}');
  print('client response ${response.writeToJson()}');
   response =  await stub.getAlbums(AlbumRequest()..id=1);
  print('client response ${response.writeToJsonMap()}');
  await channel.shutdown();
}