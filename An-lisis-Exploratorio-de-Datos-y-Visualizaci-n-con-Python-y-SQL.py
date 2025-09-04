#IMPORTAR LIBRAERÍAS  UTILIZAR
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from getpass import getpass

#VISUALIZAR LA INFORMACIÓN
plt.style.use('ggplot')
plt.rcParams['figure.figsize'] = (12, 6)
sns.set_palette('husl')

# Función para conectar a MySQL de forma segura
def conectar_mysql():
    print("Ingresa tus credenciales de MySQL: ")
    host = input("Host (presiona Enter para 'localhost'):") or "localhost"
    usuario = input("Usuario: ")
    contraseña = getpass("Contraseña: ")
    base_datos = input("Base de datos (presiona Enter 'sistema_drogas'):") or "sistema_drogas"

    try:
        conexion = mysql.connector.connect(
            host=host,
            user=usuario,
            password=contraseña,
            database=base_datos
        )
        print("\nConexión exitosa a la base de datos")
        return conexion
    except mysql.connector.Error as err:
        print(f"\nError al conectar con MySQL: {err}")
        return None
    
def consulta_sql (conexion, query):
    try:
        cursor = conexion.cursor(dictionary=True)
        cursor.execute(query)
        resultados = cursor.fetchall()
        return pd.DataFrame(resultados)
    except mysql.connector.Error as err:
        print(f"Error en la consulta: {err}")
        return pd.DataFrame()
    
#CONEXIÓN A BASE DE DATOS
conexion = conectar_mysql()
if conexion is None:
    exit()

#SEGMENTO 1: ANÁLISIS DE TABLA DROGA
print("\n"+"="*50)
print("Segmento 1: Análisis de droga")
print("="*50 + "\n")

#OBTENER INFORMACIÓN
query_drogas="""
SELECT d.id, d.nombre, t.nombre as tipo, d.riesgo_adiccion,
d.forma_consumo
FROM drogas d
JOIN tipos_drogas t ON d.tipo_id - t.id
"""

drogas = consulta_sql(conexion, query_drogas)

if not drogas.empty:
    print("Listado de drogas: ")
    print(drogas[['nombre', 'tipo', 'riesgo_adiccion']].to_string(index=False))

    print("\n Estadística descriptiva: ")
    print(f"Número total de drogas registradas:  {len(drogas)}")
    print(f"Tipo de riesgo de adicción: {drogas['riesgo_adiccion'].unique()}")
    print(f"Formas de consumo: {drogas['forma_consumo'].dropna().unique()}")

    #DISTRIBUCIÓN EN DATAFRAME POR TIPO_DROGA
    dist_tipo = drogas['tipo'].value_counts()
    print("\nDistrivucion de drogas por tipo:")
    print(dist_tipo)

    plt.figure(figsize=(10, 5))
    dist_tipo.plot(kind='bar')
    plt.title('Distribución de Drogas por Tipo')
    plt.xlabel('Tipo de Droga')
    plt.ylabel('Cantidad')
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()
else:
    print("No se encontraron datos de drogas")

#SEGMENTO 2: ANÁLISIS DE EFECTOS
print("\n" + "="*50)
print("Segmento 2: Adnálisis de efectos")
print("="*50 + "\n")
query_efectos="""
SELECT e.nombre, e.categoria, COUNT(de.droga_id) as frecuencia
FROM droga_efectos de
JOIN efectos e ON de.efecto_id = e.id
GROUP BY e.id
ORDER BY frecuencia DESC
LIMIT 10
"""
efectos_columnes = consulta_sql(conexion, query_efectos)
if not efectos_columnes.empty:
    print("Efectos más frecuentes:")
    print(efectos_columnes.to_string(index=False))

    query_intensidad ="""
    SELECT intensidad. COUNT(*) as cantidad
    FROM droga_efectos
    GROUP BY intensidad    
    """
    intensidad_dist = consulta_sql(conexion, query_intensidad)

    if not intensidad_dist.empty:
        print("\nDistribucion de intensidad de efectos:")
        print(intensidad_dist.to_string(index=False))
        
        plt.figure(figsize=(8, 5))
        plt.pie(intensidad_dist['cantidad'], label=intensidad_dist['intensidad'],
                autopct='%1.1f%%', startangle=90)
        plt.title('Distribución de intensidad de efectos')
        plt.tight_layout()
        plt.show()

        #EFECTOS POR CAEGORÍA

query_caregorias="""
SELECT categoria, COUNT(*) as cantidad
FROM efectos
GROUP BY categoria
"""

categoria_efectos = consulta_sql(conexion, query_caregorias)
if not categoria_efectos.empty:
    print("\n Efectos por categoría:")
    print(categoria_efectos.to_string(index=False))
    plt.figure(figsize=(10, 5))
    sns.barplot(data=categoria_efectos, x='categoria', y='cantidad')
    plt.title('Cantidad de Efectos por Categoría')
    plt.xlabel('Categoría')
    plt.ylabel('Cantidad de Efectos')
    plt.tight_layout()
    plt.show
else:
    print("No se encontraron efectos")
#SEGMENTO 3: ANÁLISIS DE RIESGOS POR EFECTOS DE DROGAS
print("\n"+"="*50)
print("Segmento 3 Análisis de Riesgos")
print("="*50+"\n")

#Riesgos frecuentes
query_riesgos="""
SELECT r.nombre, r.gravedad, COUNT(dr.droga) as frecuencia
FROM droga_riesgos dr
JOIN riesgos r ON dr.riesgo_id = r.id
GROUP BY r.id
ORDER BY frecuencia DESC
LIMIT 10
"""
riesgos_frecuentes = consulta_sql(conexion, query_riesgos)
if not riesgos_frecuentes.empty:
    print("\n Ddistribución e gravedad de riesgos:")
    print(riesgos_frecuentes.to_string(index=False))

    #GRAVEDAD DE RIESGOS
    query_gravedad="""
    SELECT gravedad, COUNT(*) as cantidad
    FROM riesgos
    GROUP BY gravedad
    """
    graveda_dist = consulta_sql(conexion, query_gravedad)
    if not graveda_dist.empty:
        print("\n Distribución de gravedad de riesgos:")
        print(graveda_dist.to_string(index=False))        
        plt.figure(figsize=(8, 5))

        graveda_dist.plot(kind='bar', x='gravedad', y='cantidad')
        plt.title('Distribucion de gravedad de riesgos')
        plt.xlabel('Nivel de graveda')
        plt.ylabel('Cantidad')
        plt.tight_layout()
        plt.show()

        #Relación riesgo-adicción
        query_riesgo_adiccion = """
        SELECT d.riesgo_adiccion, r.gravedad, COUNT(*) as cantidad
        FROM droga_riesgos dr
        JOIN drogas d ON dr.droga_id = d.id
        JOIN riesgos r ON dr.riesgos_id = r.id
        GROUP by d.riesgo_adiccion, r.gravedad
        """
        riesgo_adiccion = consulta_sql(conexion, query_riesgo_adiccion)
        if not riesgo_adiccion.empty:
            print("\n Relación entre riesgo de adicción y gravedad de riesgos")
            pivot_riesgos = riesgo_adiccion.pivot(index='riesgo_adicccion', columns='gravedad', values='cantidad').fillna(0)
            print(pivot_riesgos)

            plt.figure(figsize=(12, 6))
            pivot_riesgos.plot(kind='bar', stacked=True)
            plt.title('Distribución de Gravedad de Riesgos por nivel de Adicción')
            plt.xlabel('Nivel de adicción')
            plt.ylabel('Cantidad de Riesgos')
            plt.tight_layout()
            plt.show()
        else:
            print("\n"+"="*50)
            print("Segmento 4: Análisis de Tratamientos")
            print("="*50+"\n")



#TRATAMIENTOS MÁS RECOMENDADOS
query_tratamiento="""
SELECT t.nombre, t.efectividad, COUNT(dt.droga) as frecuencia
FROM droga_tratamientos dt
JOIN tratamientos t ON dt.tratamiento_id = t.id
WHERE dt.recomenddo = 1
GROUP BY t.id
ORDER BY frecuencia DESC
LIMIT 5
"""
tratamientos_top = consulta_sql(conexion, query_tratamiento)

if not tratamientos_top.empty:
    print("Tratamientos más recomendados:")
    print(tratamientos_top.to_string(index=False))

    #Efectividad de tratamientos
    query_efectividad="""
    SELECT efectividad, COUNT(*) as cantidad
    FROM tratamientos
    GROUP BY efectividad    
    """
    efectividad_dist=consulta_sql(conexion, query_efectividad)
    if not efectividad_dist.empty:
        print("\n Distribución de efectividad de tratamiento")
        print(efectividad_dist.to_string(index=False))

        plt.figure(figsize=(8, 5))
        plt.pie(efectividad_dist['cantidad'], labels=efectividad_dist['efectividad'], autopct='%1.1f%%', startangle=90)
        plt.title('Distribución ede efectividad de tratamiento')
        plt.tight_layout()
        plt.show
#TRATAMIENTOS POR TIPO DE DROGA
query_tratamiento_tipo = """
SELECT t.nombre as tipo_droga, tr.nombre as tratamiento, COUNT(*) as
frecuencia
FROM droga_tratamientos dt
JOIN drogas d ON dt.droga_id = d.id
JOIN tipos_drogas t ON d.tipo_id = t.id
JOIN tratamientos tr ON dt.tratamiento_id = tr.id
WHERE dt.recomendado = 1
GROUP BY t.nombre, tr.nombre
"""
tratamientos_tipo = consulta_sql(conexion, query_tratamiento_tipo)
if not tratamientos_tipo.empty:
    print("\n Tratamientos por tipo de droga")
    pivot_tratamientos = tratamientos_tipo.pivot(index='tipo_droga',columns='tratamiento',values='frecuencia').fillna(0)
    print(pivot_tratamientos.head())

    plt.figure(figsize=(12, 6))
    sns.heatmap(pivot_tratamientos, cmap='YlGnBu', annot=True, fmt='g')
    plt.title('Matriz de trazamientos por tipos de droga')
    plt.xlabel('Tratamiento')
    plt.ylabel('Tipo de Droga')
    plt.tight_layout()
    plt.show()
else:
    print("No se encuentraron datos de tratamientos")

#SEGMENTO 5: ANÁLISIS TEMPORAL
print("\n"+"="*50)
print("Segmento 5: Análisis temporal")
print("="*50+"\n")

#REGISTROS POR FECHA
query_fechas="""
SELECT DATE(fecha_creacion) as fecha, COUNT(*) as registros
FROM drogas
GROUP BY DATE(fecha_creacion)
ORDER BY fecha
"""
registros_fecha=consulta_sql(conexion, query_fechas)

if not registros_fecha.empty:
    print("Registros de drogas por fecha")
    print(registros_fecha.to_string(index=False))

    plt.figure(figsize=(12, 5))
    plt.plot(registros_fecha['fecha'], registros_fecha["registros"], marker='o')
    plt.title('Registros de Drogas por fecha')
    plt.xlabel('Fecha')
    plt.ylabel('Número de registros')
    plt.grid(True)
    plt.tight_layout()
    plt.show()
    #EVOLUCIÓN DE TIPOS DE DROGAS REGISTRADAS
    query_evolucion_tipos="""
    SELECT DATE(d.fecha_creacion) as fecha, t.nombre as tipo, COUNT(*) as registros
    FROM drogas d
    JOIN tipos_drogas t ON d.tipo_id = t.id
    GROUP BY DATE(d.fecha_creacion), t.nombre
    ORDER BY fecha
    """
    evolucion_tipos = consulta_sql(conexion, query_evolucion_tipos)
    if not evolucion_tipos.empty:
        print("\n Evolución de tipos de drogas registradas:")
        pivot_evolucion = evolucion_tipos.pivot(index='fecha', columns='tipo', values='registros').fillna(0)
        print(pivot_evolucion.tail())

        plt.figure(figsize=(12, 6))
        pivot_evolucion.plot.area(stacked=True)
        plt.title('Evolución de Tipos de Drogas Registradas')
        plt.xlabel('Fecha')
        plt.ylabel('Cantidad de registros')
        plt.legend(title='Tipo de Drgoas')
        plt.tight_layout()
        plt.show()
    else:
        print("No se encontraron datos temporales")

#CERRAR CONEXIÓN
conexion.close()
print("\nConexión a MySQL cerrada.")