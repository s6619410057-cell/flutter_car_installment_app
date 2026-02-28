import 'package:flutter/material.dart';

class CarInstallmentUi extends StatefulWidget {
  const CarInstallmentUi({super.key});

  @override
  State<CarInstallmentUi> createState() => _CarInstallmentUiState();
}

class _CarInstallmentUiState extends State<CarInstallmentUi> {
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController rateCtrl = TextEditingController();

  double downPaymentPercent = 10.0;
  int installmentPeriod = 24;
  double monthlyInstallment = 0.00;

  @override
  void initState() {
    super.initState();
    priceCtrl.clear();
    rateCtrl.clear();
  }

  @override
  void dispose() {
    priceCtrl.dispose();
    rateCtrl.dispose();
    super.dispose();
  }

  String _formatAmount(double value) {
    final fixed = value.toStringAsFixed(2);
    final parts = fixed.split('.');
    final chars = parts[0].split('').reversed.toList();
    final buffer = StringBuffer();
    for (var i = 0; i < chars.length; i++) {
      if (i > 0 && i % 3 == 0) buffer.write(',');
      buffer.write(chars[i]);
    }
    final intPart = buffer.toString().split('').reversed.join();
    return '$intPart.${parts[1]}';
  }

  void _calculateInstallment() {
    if (priceCtrl.text.isEmpty || rateCtrl.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('แจ้งเตือน'),
          content: const Text('กรุณาป้อนราคารถและอัตราดอกเบี้ยให้ครบถ้วน'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
      return;
    }

    double price = double.parse(priceCtrl.text);
    double rate = double.parse(rateCtrl.text);

    double financeAmount = price - (price * downPaymentPercent / 100);

    double totalInterest =
        (financeAmount * (rate / 100)) * (installmentPeriod / 12);

    double monthly = (financeAmount + totalInterest) / installmentPeriod;

    setState(() {
      monthlyInstallment = monthly;
    });
  }

  void _resetForm() {
    setState(() {
      priceCtrl.clear();
      rateCtrl.clear();
      downPaymentPercent = 10.0;
      installmentPeriod = 24;
      monthlyInstallment = 0.00;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 247, 255),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        toolbarHeight: 45,
        title: const Text(
          'CI Calculator',
          style: TextStyle(
            color: Color.fromARGB(255, 238, 237, 237),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 3),
              const Text(
                'คำนวณค่างวดรถ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF4CAF50), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  'assets/images/car.png',
                  height: 120,
                  width: 190,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text('ราคารถ (บาท)',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: priceCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '0.00',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text('จำนวนเงินดาวน์ (%)',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Transform.translate(
                  offset: const Offset(-25, 0),
                  child: RadioGroup<double>(
                    groupValue: downPaymentPercent,
                    onChanged: (newValue) {
                      if (newValue == null) return;
                      setState(() {
                        downPaymentPercent = newValue;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildRadioChoice(10),
                        _buildRadioChoice(20),
                        _buildRadioChoice(30),
                        _buildRadioChoice(40),
                        _buildRadioChoice(50),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text('ระยะเวลาผ่อน (เดือน)',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: installmentPeriod,
                    isExpanded: true,
                    items: [24, 36, 48, 60, 72].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value เดือน'),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        installmentPeriod = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text('อัตราดอกเบี้ย (%/ปี)',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: rateCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '0.00',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: _calculateInstallment,
                      child: const Text(
                        'คำนวณ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5722),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: _resetForm,
                      child: const Text(
                        'ยกเลิก',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 237, 250, 237),
                  border: Border.all(color: const Color(0xFF4CAF50), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Text(
                      'ค่างวดรถต่อเดือนเป็นเงิน',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      _formatAmount(monthlyInstallment),
                      style: const TextStyle(
                        color: Color(0xFFF44336),
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'บาทต่อเดือน',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioChoice(double value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<double>(
          value: value,
          activeColor: Colors.black87,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        ),
        Text('${value.toInt()}'),
        const SizedBox(width: 5),
      ],
    );
  }
}
