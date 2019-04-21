Dado("que se necesita probar las funciones sobre un cromosoma, entonces crea un cromosoma con {int} genes") do |tamano|
  @tamano = tamano.to_i
  @cromosoma1 = Cromosoma.new(@tamano)
end

Cuando("yo ingrese el numero {int} en la poblacion de cromosomas") do |poblacion|
  @tamano_poblacion = poblacion.to_i
  @poblacion = Genetic.new(@tamano_poblacion, @tamano)
end

Entonces("el total de cromosomas creados debe ser igual a ese numero") do
  if @poblacion.length != @tamano_poblacion then
    fail(ArgumentError.new('Error:El tamano de la poblacion no es igual!'))
  end
end


Cuando("tome el cromosoma y quite los elementos repetidos") do
  @resultado_repetidos = @cromosoma1.uniq			
end

Entonces("el resultado debe ser igual al tamano inicial") do
  
  if @cromosoma1.length == @resultado_repetidos.length then
    true
  else
    fail(ArgumentError.new('Error:El tamano no es igual!'))
  end
end

Cuando("aplique la funcion de mutacion con un valor de {int}") do |porcentaje|
  if porcentaje.to_i > 3 || porcentaje.to_i < 1 then 
    p "Valor no permitido, por defecto se deja en 3."
    porcentaje = 3
  end
  p "cromosoma 1" , @cromosoma1
  @cromosoma_mutar = Marshal.load(Marshal.dump(@cromosoma1))
 # @cromosoma_mutar.replace(@cromosoma1)
p "cromosoma mutar" , @cromosoma_mutar
@cromosoma_mutar.Mutar(porcentaje.to_i)
  
  
  p "cromosoma 1" , @cromosoma1

  p "cromosoma mutar" , @cromosoma_mutar

end

Entonces("habra elementos del cromosoma resultante que no deben estar en el mismo lugar") do
  @cambios = false
  for i in 0..(@tamano-1)
   if @cromosoma1[i] != @cromosoma_mutar[i] then
    @cambios = true
    break
   end
  end
  if @cambios == true then
   true
  else
   fail(ArgumentError.new('El cromosoma no presenta cambios'))
  end
end

Dado("que he creado otro cromosoma del mismo tamano") do
  @otro_cromosoma = Cromosoma.new(@tamano)
  p @cromosoma1
  p @otro_cromosoma
end

Cuando("aplique la funcion de cruce con los dos cromosomas") do
  @cromosoma_cruce = @cromosoma1.Cruce(@otro_cromosoma)
  p @cromosoma_cruce
end

Entonces("el resultado debe ser un cromosoma que tenga como elementos una combinacion del primer y segundo cromosoma") do
  for i in (0..(@tamano-1))
   if @cromosoma_cruce[i] != @cromosoma1[i] && @cromosoma_cruce[i] != @otro_cromosoma[i]
        fail(ArgumentError.new('Los elementos del nuevo cromosoma no coinciden con los de los padres'))
   end
  end
end

Dado("que tengo el cromosoma con los siguientes elementos [{int},{int},{int},{int},{int},{int},{int},{int},{int},{int}]") do |int, int2, int3, int4, int5, int6, int7, int8, int9, int10|
  elementos = [int, int2, int3, int4, int5, int6, int7, int8, int9, int10]
  @cromosoma_aptitud = Cromosoma.new(elementos.length)
   for i in (0..(elementos.length-1))
    @cromosoma_aptitud[i] = elementos[i].to_i
   end
  p @cromosoma_aptitud
end

Cuando("aplique la funcion de aptitud") do
  @cromosoma_aptitud.calcularActitud	
end

Entonces("me debe decir su aptitud") do
  p @cromosoma_aptitud.aptitud
end

Dado("que creo un cromosoma con {int} elementos") do |int|
  @cromo = Cromosoma.new(int.to_i)
end

Cuando("aplique las funciones que encuentran las diagonales principales y secundarias con el indice {int}") do |int|
  @indice = int.to_i
  @principal = @cromo.calcularDiagonalPrincipal(@indice, @cromo[@indice])
  @secundaria = @cromo.calcularDiagonalSecundaria(@indice, @cromo[@indice])
end

Entonces("me retorna las  dos matrices correspondientes a diagonales principales y secundarias") do
  p "Matrix diagonales principales"
  p @principal
  p "Matrix diagonales secundarias"
  p @secundaria
end

	
