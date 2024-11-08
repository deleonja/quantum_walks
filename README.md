**Voy a probar un nuevo formato para la lista de tareas: ya no las ordenaré por fecha, sino que sólo por nombre. **

### Notas

- No todos los estados iniciales \psi_0 \otimes \ket{0} tiende a la distribución clásica. Hay desviaciones con la distribución de probabilidad de la RW para ciertos estados. Cuáles?? Caracterizar esto

### To-do

Revisar paper sobre la distribución límite (distribución de Kono o algo así) y tratar de entender el resultado para saber si es la misma distribución límite que nosotros estamos buscando.

- Qué hacen en el artículo de Science Advances??
- Qué modelo de decoherencia usan y cómo se relaciona con el nuestro?? 
- Cómo se implemenenta ahí el espacio de la posición?? 
- En el artículo review, qué modelos de decoherencia parecidos al nuestro hay??

## Mariana

- [ ] Revisar paper sobre la distribución límite (distribución de Kono o algo así) y tratar de entender el resultado para saber si es la misma distribución límite que nosotros estamos buscando.
- [ ] Diagnosticar el problema numérico, quizás con MatrixPartialTrace

## Amado

- [ ] Hacer visualizaciones gráficas de la esfera de Bloch para el canal de la moneda y jugar con más tiempos para ver cómo se ve la dinámica
- [ ] Trabajar en la analítica del triángulo de Pascal para la DTQW con completamente dephasing

#### 27.09.24

**Mariana**

- [ ] Revisar paper sobre la distribución límite (distribución de Kono o algo así) y tratar de entender el resultado para saber si es la misma distribución límite que nosotros estamos buscando.
- [ ] Diagnosticar el problema numérico, quizás con MatrixPartialTrace

**Amado**
- [ ] Hacer visualizaciones gráficas de la esfera de Bloch para el canal de la moneda y jugar con más tiempos para ver cómo se ve la dinámica
- [ ] Trabajar en la analítica del triángulo de Pascal para la DTQW con completamente dephasing

#### 20.09.24

- [X] Mariana y Amado comparan sus resultados, hasta ver en qué paso dejan de ser iguales (si son iguales al principio y sino ver qué está pasando)

**Mariana**

- [ ] Revisar paper sobre la distribución límite (distribución de Kono o algo así) y tratar de entender el resultado para saber si es la misma distribución límite que nosotros estamos buscando.
- [X] Repetir los cálculos de las diferencias entre las distribuciones de probabilidad de posición del caminante de la RW y DTQW p=0.5 con valores numéricos y no con valores exactos (Mathematica se pone pendejo con números muy chiquitos)
- [X] Calcular las dierencias entre las distribuciones de probabilidad deposición entre la RW y la DTQW para estados mixtos iniciales de la moneda. Estados que estén sobre los ejes, sobre los planos y un estado aleatorio. 

**Amado**

- [X] Graficar la deformación de la esfera de Bloch (dinámica reducida de la moneda) calculando los operadores de Kraus del canal cuántico que actúa sobre la moneda en una DTQW (sin decoherencia)
- [X] Cálculos a mano de DTQW con completamente dephasing
- [ ] Revisar artículos en la literatura sobre caminatas cuánticas y decoherencia

#### 16.09.24

**Amado**

- [x] Hacer a mano (lápiz y papel) 3 pasos de la DTQW con decoherencia, p=0.5, para entender mejor que la caminata cuántica parece que se vuelve instantáneamente clásica
- [ ] Graficar la deformación de la esfera de Bloch (dinámica reducida de la moneda) calculando los operadores de Kraus del canal cuántico que actúa sobre la moneda en una DTQW (sin decoherencia)
- [ ] Seguir revisando la literatura

**Mariana**

- [ ] Revisar paper sobre la distribución límite (que tiene Amado) y tratar de entender el resultado para saber si es la misma distribución límite que nosotros estamos buscando.
- [x] Verificar las diferencias entre la distribución de probabilidad de la posición de una caminata cuántica vs. una caminata clásica que comienza en el origen. **Comportamientos diferentes para diferentes estados, el que vuelve más clásica la DTQW parece ser el estado inicial |+_x > **
- [ ] Seguir revisando la literatura

#### 05.09.24

**Amado**

- [x] Hacer 3 pasos a mano de la DTQW con decoherencia p=0.5 para entender porqué se vuelve clásica instantáneamente

- [x] Pensar en cómo obtener la deformación de la esfera de Bloch que describe al canal cuántico de la moneda (dinámica reducdida de la moneda)

**Mariana**

- [x] Verificar si existe una distribución límite o si se hace infinitamente ancha

- [x] Verificar a partir de que t, para dos estados iniciales aleatorios de la moneda en producto tensorial con la posición 0, la distribución de probabilidad es igual a la de RAndomWAlkDistribution. Graficar en un mismo plot las curvas con p=0.5 para t=20,50,80,....

#### 29.09.24

**Mariana**

- [x] Revisar caminata cuántica con el estado inicial 0,0 y t=3, caminata con decoherencia con p=1.

#### 22.08.24

**Amado**

- [x] Hacer el estado de dos posiciones diferentes que no es un estado entrelazado
- [x] Revisar literatura sobre modelos teóricos recientes con decoherencia. Uno revisa por año y el otro por los más citados

**Amado**

- [x] Hacer un gradiente 0.5 < p < 1 (10 valores máximo) para el estado inicial |+_y,0>
- [x] Hacer para varios estados iniciales puros de la moneda y ver si siempre llega a la misma densidad de probabilidad clásica, para p=0.5. *Respuesta*: tomando un estado aleatorio, llega a la misma distribución gaussiana. 
