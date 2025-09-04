# Análisis Exploratorio de Datos y Visualización con Python y SQL

## Resumen
Este proyecto es un análisis exploratorio de datos (EDA) completo realizado sobre una base de datos MySQL. El script de Python se conecta a la base de datos, ejecuta una serie de consultas SQL complejas para segmentar y agregar datos, y utiliza las librerías Pandas, Matplotlib y Seaborn para procesar y visualizar los resultados, descubriendo patrones y tendencias.

## Análisis Realizados
El script realiza un análisis multi-segmento, incluyendo:
* **Análisis de Drogas:** Distribución por tipo y riesgo de adicción.
* **Análisis de Efectos:** Identificación de los efectos más frecuentes y su distribución por categoría e intensidad.
* **Análisis de Riesgos:** Frecuencia de riesgos y su correlación con el nivel de adicción.
* **Análisis de Tratamientos:** Identificación de los tratamientos más recomendados y su efectividad.
* **Análisis Temporal:** Evolución del registro de datos a lo largo del tiempo.

## Tecnologías Utilizadas
* **Lenguaje:** Python, SQL
* **Librerías de Análisis:** Pandas, Matplotlib, Seaborn
* **Base de Datos:** MySQL

## 🚀 Cómo Ejecutar el Proyecto

### Prerrequisitos
* Un servidor de base de datos MySQL instalado y corriendo.
* **Importante:** Este proyecto requiere que la base de datos `sistema_drogas` ya esté poblada. Debes incluir un archivo `sistema_drogas.sql` con el script para crear y poblar las tablas.

### Pasos de Instalación y Ejecución

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/YeyoDiego223/An-lisis-Exploratorio-de-Datos-y-Visualizaci-n-con-Python-y-SQL](https://github.com/YeyoDiego223/An-lisis-Exploratorio-de-Datos-y-Visualizaci-n-con-Python-y-SQL)
    cd tu-repositorio
    ```

2.  **Preparar la Base de Datos:**
    * Asegúrate de que tu servicio de MySQL esté corriendo.
    * Desde la terminal de MySQL, crea la base de datos:
        ```sql
        CREATE DATABASE sistema_drogas;
        ```
    * Importa la estructura y los datos usando el script SQL que debes proporcionar:
        ```bash
        mysql -u root -p sistema_drogas < sistema_drogas.sql
        ```

3.  **Configurar el Entorno Virtual (Recomendado):**
    ```bash
    # Crear el entorno
    python -m venv venv

    # Activar el entorno
    # En Windows: .\venv\Scripts\activate
    # En macOS/Linux: source venv/bin/activate
    ```

4.  **Instalar las Dependencias de Python:**
    ```bash
    pip install pandas matplotlib seaborn mysql-connector-python
    ```

5.  **Ejecutar la Aplicación:**
    ```bash
    python practica11.py
    ```
    * El script te pedirá de forma segura las credenciales de la base de datos para conectarse.

---

## Visualizaciones Generadas

<img width="1241" height="696" alt="image" src="https://github.com/user-attachments/assets/127390ac-b12d-4126-bbb4-26b98d1c3ac9" />

<img width="1489" height="825" alt="image" src="https://github.com/user-attachments/assets/7d69f115-4027-491f-b050-849e2c050c3e" />

<img width="1240" height="704" alt="image" src="https://github.com/user-attachments/assets/e7769565-69a0-4c6f-9466-6d5107ee70d8" />

<img width="1482" height="700" alt="image" src="https://github.com/user-attachments/assets/3ea1cbcd-d3dc-4b70-81f9-f9cf3cdfb553" />

<img width="1491" height="825" alt="image" src="https://github.com/user-attachments/assets/85640bd2-c96f-48bd-8766-0410421a396e" />

