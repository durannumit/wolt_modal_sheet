import 'package:coffee_maker_navigator_2/features/orders/domain/entities/coffee_maker_step.dart';
import 'package:coffee_maker_navigator_2/features/orders/domain/entities/grouped_coffee_orders.dart';
import 'package:coffee_maker_navigator_2/features/orders/domain/orders_service.dart';
import 'package:flutter/foundation.dart';

class OrdersScreenViewModel {
  OrdersScreenViewModel({required OrdersService ordersService})
      : _ordersService = ordersService {
    final currentOrders = _ordersService.orders.value;
    _groupedCoffeeOrders.value =
        GroupedCoffeeOrders.fromCoffeeOrders(currentOrders);
    _ordersService.orders.addListener(_onOrdersReceived);
  }

  final OrdersService _ordersService;

  final _groupedCoffeeOrders = ValueNotifier(GroupedCoffeeOrders.empty());

  ValueListenable<GroupedCoffeeOrders> get groupedCoffeeOrders =>
      _groupedCoffeeOrders;

  final ValueNotifier<CoffeeMakerStep> _selectedBottomNavBarItem =
      ValueNotifier(CoffeeMakerStep.grind);

  ValueListenable<CoffeeMakerStep> get selectedBottomNavBarItem =>
      _selectedBottomNavBarItem;

  void onInit(CoffeeMakerStep? initialNavBarItem) {
    if (initialNavBarItem != null) {
      _selectedBottomNavBarItem.value = initialNavBarItem;
    }
  }

  void dispose() {
    _ordersService.orders.removeListener(_onOrdersReceived);
  }

  void onBottomNavBarItemSelected(CoffeeMakerStep selectedStep) {
    _selectedBottomNavBarItem.value = selectedStep;
  }

  void onOrderStatusChange(String orderId, [CoffeeMakerStep? newStep]) {
    _ordersService.updateOrder(orderId, newStep);
  }

  void _onOrdersReceived() {
    final orders = _ordersService.orders.value;
    _groupedCoffeeOrders.value = GroupedCoffeeOrders.fromCoffeeOrders(orders);
  }

  bool orderExists(String orderId, CoffeeMakerStep step) {
    return _ordersService.orders.value
        .any((order) => order.id == orderId && order.coffeeMakerStep == step);
  }
}