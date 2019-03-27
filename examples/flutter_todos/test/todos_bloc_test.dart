

import 'package:flutter_todos/blocs/todos/todos.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'fixtures/common_mocks.dart';
import 'fixtures/todos_fixtures.dart';


void main(){
  TodosBloc todosBloc;
  MockTodosRepositoryFlutter todosRepositoryFlutter;

  group('Todos Bloc Test', () {
    setUp((){
      todosRepositoryFlutter = MockTodosRepositoryFlutter();
      todosBloc =TodosBloc(todosRepository: todosRepositoryFlutter);
    });

    test('initial state is TodosLoading', () {
      expect(todosBloc.initialState, TodosLoading());
    });

    test('emits a loading state and then an loaded state with todoOne', () {
      final expected = [
        TodosLoading(),
        TodosLoaded([todoOne])
      ];

      when(todosRepositoryFlutter.loadTodos()).thenAnswer((_) => Future.value([todoOne.toEntity()]));
      expectLater(todosBloc.state, emitsInOrder(expected));
      todosBloc.dispatch(LoadTodos());
    });

    test('emits a loading state and then an loaded state with todoOne', () {
      final expected = [
        TodosLoading(),
        TodosLoaded([todoOne]),
        TodosLoaded([todoOne, todoTwo])
      ];

      when(todosRepositoryFlutter.loadTodos()).thenAnswer((_) => Future.value([todoOne.toEntity()]));
      when(todosRepositoryFlutter.loadTodos()).thenAnswer((_) => Future.value([todoOne.toEntity(), todoTwo.toEntity()]));
      expectLater(todosBloc.state, emitsInOrder(expected));
      todosBloc.dispatch(AddTodo(todoOne));
      todosBloc.dispatch(LoadTodos());
      todosBloc.dispatch(AddTodo(todoTwo));
      todosBloc.dispatch(LoadTodos());
    });
  });

}