import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:passenger_app/modules/auth/stores/auth.dart';


class AppStores {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AuthStore>(create: (_) => AuthStore()),
  ];
}

