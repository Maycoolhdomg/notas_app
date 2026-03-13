# 📝 NotasApp - Flutter MVVM
Esta es una aplicación móvil para la gestión de notas desarrollada con Flutter. El proyecto
implementa persistencia local, una arquitectura desacoplada y una interfaz moderna basada en
Material Design 3.
# 🚀 Instrucciones de Compilación y Ejecución
Siga estos pasos para configurar y ejecutar el proyecto en su entorno local:
# ⚙️ Configuración inicial
Clonar o descargar el repositorio

Puede clonar el repositorio con Git o descargar el proyecto en formato .zip.  

Clonar con Git:  

git clone https://github.com/Maycoolhdomg/notas_app  

O bien descargar el archivo .zip desde GitHub y descomprimirlo.  

Abrir el proyecto  

Una vez descargado, abra una terminal en la carpeta raíz del proyecto.  

Instalar dependencias  

Ejecute el siguiente comando para descargar todas las librerías necesarias del proyecto:  

flutter pub get  
# 📱 Ejecución en desarrollo
Para ejecutar la aplicación en un emulador o dispositivo físico conectado, use el siguiente comando:  

*flutter run*  

Esto compilará e iniciará la aplicación en modo desarrollo.  
# 📦 Generación del ejecutable (APK)
Compilar versión de lanzamiento: Si desea generar el archivo APK para distribución:  
*flutter build apk --release*  
Nota: El archivo generado se ubicará en la ruta: release/app-release.apk .
# 🏗️Arquitectura y Decisiones de Diseño
La aplicación utiliza el patrón MVVM (Model-View-ViewModel) para asegurar una separación
clara de responsabilidades:  
 - **Model:** Clase Note que define la estructura de datos y métodos de mapeo para la base
de datos.  
 - **View:** Interfaces reactivas que observan el estado del ViewModel y se reconstruyen
automáticamente.  
 - **ViewModel:** Implementado con ChangeNotifier (Provider) para gestionar la lógica de
negocio y el estado global.  
 - **Persistencia:** Uso de SQLite ( sqflite ) para el almacenamiento local permanente de los
datos.
# ✨ Funcionalidades Implementadas
✅ Requisitos Obligatorios  
✅CRUD Completo: Creación, lectura, edición y eliminación de notas.  
✅Persistencia Local: Los datos se mantienen guardados de forma segura en el dispositivo
mediante SQLite.  
✅Navegación: Flujo fluido entre la lista principal y la pantalla de detalle/edición.  
✅Validaciones: Control de título obligatorio y diálogos de confirmación antes de eliminar
una nota.  
# 🌟 Extras (Puntos Adicionales)
✅Búsqueda Dinámica: Filtro de notas por título integrado mediante un SearchDelegate .  
✅Notas Ancladas (Pinned): Capacidad de destacar notas al inicio de la lista, con un límite
de 2 notas por usuario para optimizar la relevancia.  
✅Gestión de Errores: Notificaciones visuales mediante SnackBars para avisar sobre límites
de anclado o campos vacíos.  
# 📁 Estructura del Proyecto
 - lib/database/ : Contiene el DBHelper para la gestión de la base de datos SQLite.
 - lib/models/ : Definición del modelo de datos Note .
 - lib/viewmodels/ : Lógica de negocio y gestión de estado mediante NoteProvider .
 - lib/views/ : Pantallas de la aplicación (Lista y Detalle).
 - lib/main.dart : Punto de entrada y configuración del Provider.
# 🎥 Demo y Evidencia
Video: https://mega.nz/file/iooASbIT#ntrqWzIaxBX7Wfm4of8LCFnwy4S7a3wnoj6OYDKdamY  

Historial: Se han realizado commits coherentes que documentan la evolución del
desarrollo.
![WhatsApp Image 2025-12-20 at 11 16 08 AM](https://github.com/user-attachments/assets/f73a2b41-0833-4237-a0da-70f91d8fadb8)

screenshot
![87fe3ec2-26e1-4220-8864-2b2da3d05f67](https://github.com/user-attachments/assets/4ded5ae4-7c4b-465f-8d01-23c3eeea0538)

![b3894525-1120-4437-ad24-4275b3fa0855](https://github.com/user-attachments/assets/119dee32-abf5-4477-8e29-36d0bd07853d)

![cb55114a-e89c-4bb2-a48a-e218688064d3](https://github.com/user-attachments/assets/7daa3d6c-af4b-4006-9cde-9b51a0350914)
