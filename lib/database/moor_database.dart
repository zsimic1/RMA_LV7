import 'package:moor_flutter/moor_flutter.dart';
part 'moor_database.g.dart';
@DataClassName('Item')
class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 30)();
  TextColumn get description => text().withLength(min: 5, max: 216)();
  TextColumn get url => text()();
  TextColumn get latitude => text()();
  TextColumn get longitude => text()();
  TextColumn get guid => text()();
}

@UseMoor(tables: [Items])
class AppDatabase extends _$AppDatabase {
  AppDatabase._()
      : super(FlutterQueryExecutor.inDatabaseFolder(
      path: 'db.sqlite', logStatements: true));
  @override
  int get schemaVersion => 1;

  static final AppDatabase _instance = AppDatabase._();
  factory AppDatabase() {
    return _instance;
  }
  Future<List<Item>> getAllItems() => select(items).get();
  Stream<List<Item>> watchAllItems() => select(items).watch();
  Future insertItem(Item item) => into(items).insert(item);
  Future deleteItem(Item item) => delete(items).delete(item);
}
