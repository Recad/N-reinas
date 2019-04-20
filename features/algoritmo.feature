# language: es

Característica: Realizar la comprobacion de la creacion de la poblacion, individuo, la mutacion, el cruce, la aptitud.
 Antecedentes: Crear un cromosoma
 Dado que se necesita probar las funciones sobre un cromosoma, entonces crea un cromosoma con 11 genes

 Escenario: Vereficar la creacion de la poblacion de cromosomas
 Cuando yo ingrese el numero 1000 en la poblacion de cromosomas
 Entonces el total de cromosomas creados debe ser igual a ese numero

 Escenario: Vereficar que el cromosoma no tenga elementos repetidos
 Cuando tome el cromosoma y quite los elementos repetidos
 Entonces el resultado debe ser igual al tamano inicial

 Escenario: Verificar la mutacion de el cromosoma
 Cuando aplique la funcion de mutacion con un valor de 4
 Entonces habra elementos del cromosoma resultante que no deben estar en el mismo lugar

 Escenario: Verificar el cruce
 Dado que he creado otro cromosoma del mismo tamano
 Cuando aplique la funcion de cruce con los dos cromosomas
 Entonces el resultado debe ser un cromosoma que tenga como elementos una combinacion del primer y segundo cromosoma

 Escenario: Verificar la aptitud de un cromosoma
 Dado que tengo el cromosoma con los siguientes elementos [4,7,3,0,6,1,9,5,8,2]
 Cuando aplique la funcion de aptitud
 Entonces me debe decir su aptitud 
