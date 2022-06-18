import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:safe_notes/app/modules/dashboard/domain/errors/folder_failures.dart';
import 'package:safe_notes/app/modules/dashboard/domain/usecases/folder/restore_folder_usecase.dart';

import '../../../../../../mocks/mocks_sqlite.dart';
import '../../../../../../stub/folder_model_stub.dart';

void main() {
  final folder = folder1;
  final repository = FolderRepositoryMock();

  test(
      'restore folder usecase RestoreFolderUsecase.Call | isRight igual a True',
      () async {
    when(() => repository.restoreFolder([folder])).thenAnswer(
      (_) async => const Right(dynamic),
    );

    final usecase = RestoreFolderUsecase(repository);
    final result = await usecase.call([folder]);

    expect(result.isRight(), equals(true));
  });

  test(
      'restore folder usecase RestoreFolderUsecase.Call | retorna NoFolderEditedToRestoredSqliteError',
      () async {
    when(() => repository.restoreFolder([folder])).thenAnswer(
      (_) async => Left(NoFolderEditedToRestoredSqliteError()),
    );

    final usecase = RestoreFolderUsecase(repository);
    final result = await usecase.call([folder]);

    expect(result.isLeft(), equals(true));
    expect(result.fold(id, id), isA<NoFolderEditedToRestoredSqliteError>());
  });

  test(
      'restore folder usecase RestoreFolderUsecase.Call | retorna RestoreFolderSqliteError',
      () async {
    when(() => repository.restoreFolder([folder])).thenAnswer(
      (_) async => Left(RestoreFolderSqliteErrorMock()),
    );

    final usecase = RestoreFolderUsecase(repository);
    final result = await usecase.call([folder]);

    expect(result.isLeft(), equals(true));
    expect(result.fold(id, id), isA<RestoreFolderSqliteError>());
  });
}
