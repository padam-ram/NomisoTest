# NomisoTest

## Overview

This project is built using the MVVM design pattern with SwiftUI, and it follows best practices for code organization, maintainability, and testing.

## Features

- MVVM Design Pattern implemented with SwiftUI.
- Each module is organized into separate folders for better structure and maintainability.
- Communication between modules is handled using property wrappers.
- API calls are handled with generics for flexibility and reusability.
- Error handling is managed using an enum for consistent and clean error management.
- Network layer follows the Dependency Inversion Principle (DIP) for better testability and flexibility.
- Dependency Injection is used to pass dependencies into the ViewModel.
- The ViewModel is initialized in the view, and any changes in the ViewModel are reflected in the view.
- Unit tests are written for the ViewModel class using mock data to simulate API responses.

## Architecture

- **MVVM (Model-View-ViewModel)** design pattern is used to separate concerns and improve testability.
- **Generics** are used to structure API call methods in a clean and reusable manner.
- **Dependency Injection** ensures flexibility in initializing and providing services.
- **Enum-based error handling** is implemented to handle different error cases in a clean and consistent way.
  
## Setup

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/projectname.git
