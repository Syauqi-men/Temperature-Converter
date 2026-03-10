# Temp Converter

A streamlined, cross-platform Flutter application designed for precise temperature conversions between various scientific and common scales.

---

## Features

* **Comprehensive Conversion**: Supports Celsius, Fahrenheit, Kelvin, and Réamur.
* **Reactive UI**: Real-time calculation as you type—no "calculate" button required.
* **Precision Handling**: Accurate decimal processing for scientific consistency.
* **Adaptive Design**: Fully responsive layout compatible with Android, iOS, and Web.

---

## Conversion Formulas

The application implements the following mathematical models to ensure accuracy:

| Scale | Reference Formula |
| :--- | :--- |
| **Celsius ($C$)** | Base Unit |
| **Fahrenheit ($F$)** | $F = (C \times \frac{9}{5}) + 32$ |
| **Kelvin ($K$)** | $K = C + 273.15$ |
| **Réamur ($Re$)** | $Re = C \times \frac{4}{5}$ |



---

## Installation & Setup

Ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed before proceeding.

1.  **Clone the repository**
    ```bash
    git clone [https://github.com/yourusername/temp_converter.git](https://github.com/yourusername/temp_converter.git)
    ```

2.  **Install dependencies**
    ```bash
    cd temp_converter
    flutter pub add device_preview
    ```

3.  **Launch the application**
    ```bash
    flutter run
    ```

---

## Project Structure

* `lib/main.dart`: Entry point of the application.
* `lib/widgets/`: Reusable UI components for input and display.
* `lib/logic/`: Dedicated conversion algorithms.

---
