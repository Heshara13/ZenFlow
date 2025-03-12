import 'package:go_router/go_router.dart';
import 'package:zenflow/models/functions_model.dart';
import 'package:zenflow/pages/functions_page.dart';
import 'package:zenflow/pages/main_pages/home_page.dart';
import 'package:zenflow/router/router_names.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: "/",
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        name: RouteNames.functions,
        path: "/functions",
        builder: (context, state) {
          final FunctionsData functionsData = state.extra as FunctionsData;

          return Functionspage(functionsData: functionsData);
        },
      ),
    ],
  );
}
