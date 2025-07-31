import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class PaymentTotal extends StatelessWidget {
  const PaymentTotal({super.key, required this.total});
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text("Total:", style: TextStyle(color: AppColors.totalGray)),
              Text("R\$ ${total.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
