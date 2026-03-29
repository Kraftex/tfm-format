#import "../include/functions.typ": *

= Introducción
La introducción del TFM debe servir para que los profesores que evalúan el Trabajo
puedan comprender el contexto en el que se realiza el mismo, y los objetivos que se
plantean.

Esta plantilla muestra la estructura básica de la memoria final de TFM, así como
algunas instrucciones de formato.

El esquema básico de una memoria final de TFM es el siguiente:
- Resumen en español y inglés (máximo 2 páginas cada uno)
- Tabla de contenidos
- Introducción (con los objetivos del TFM)
- Desarrollo
- Resultados y conclusiones
- Bibliografía (publicaciones utilizadas en el estudio y desarrollo del trabajo)
- Anexos (opcional)

En cualquier caso, es el tutor del TFM quien indicará a su estudiante la estructura
de memoria final que mejor se ajuste al trabajo desarrollado.

Con respecto al formato, se seguirán las siguientes pautas, que se muestran en esta
plantilla:

- _Tamaño de papel:_ DIN A4
- _Portada:_ tal y como se recoge en esta plantilla, con indicación de universidad, centro, título de TFM y autor.
- Segunda página: información bibliográfica, incluyendo todos los datos del tutor del TFM.
- Tipo de letra para texto. Preferiblemente “Bookman Old Style” 11 puntos. Si no fuera posible, las alternativas recomendadas son, por orden de preferencia: “Palatino Linotype”, “Garamond” o “Georgia”.
- Tipo de letra para código fuente: “Consolas” o “Roboto mono”
- Márgenes: superior e inferior 3 cm, izquierdo y derecho 2.54 cm.
- Secciones y subsecciones: reseñadas con numeración decimal a continuación del número del capítulo. Ej.: subsecciones 2.3.1.
- Números de página: siempre centrado en margen inferior, página 1 comienza en capítulo 1, todas las secciones anteriores al capítulo 1 en número romano en minúscula (i, ii, iii. . . ).

Para elaborar la memoria final del TFM con esta plantilla, seguir los siguientes pasos:
1. Descargar e instalar MiKTeX: https://miktex.org/
2. Descargar e instalar un editor de LaTeX, por ejemplo Texmaker: https://www.xm1math.net/texmaker/
3. Editar el archivo *secciones/\_DatosTFM.tex*, que hay en la carpeta *secciones* de esta plantilla. Cumplimentar todos los datos pedidos en dicho archivo. Guardar y cerrar.
4. Compilar el archivo *plantilla_TFM.tex* (puede ser renombrado). Se generará como resultado un archivo *pdf*.
5. Para escribir la memoria final del TFM se pueden añadir y/o modificar los archivos de la carpeta *secciones* como sea necesario. El resultado se obtiene al compilar el archivo *plantilla_TFM.tex*.

== Ejemplo de código en Python
```python
# -*- coding: utf-8 -*-
import sympy as sy
from sympy.abc import x
```

#code-style(code-default-lines)[```
# Anytime that you needed, you can overwrite how code it should display
# You should use 'code-style' function
```]
