#!/usr/bin/env ruby
# encoding: utf-8
# Programa: algoritmoGenetico.rb
# Autor: David Andres Ramirez
# Email: david.andres.ramirez@correounivalle.edu.co
# Fecha creación: 2019-03-17 
# Fecha última modificación: 2019-03-20
# Versión: 0.1
# Tiempo dedicado: 

############################################################
# Utilidad: Definicion de las clases principales para el proyecto de computación 
# evolutiva 
############################################################
# VERSIONES
# 0.1 La primera. 
############################################################
# Se trata de modelar el cromosoma que se usara para el proyecto
############################################################


require 'rubygems'
require 'bundler/setup' 
require 'matrix'

#Definicion de la clase cromosoma
class Cromosoma < Array 
	
  #Se utiliza attr_accessor para definir de forma automatica los set y get de 
  #la variable aptitud
  attr_accessor :aptitud
  
  #Constructor de la clase
  #Recibe un tamaño y crear un array de enteros que no se repiten
  #se debe verificar que sea mayor o igual a 4 por que para menos de 4 no tiene sentido
  def initialize(tamano)
	super
    @tamano = tamano
	self.replace ((0..(tamano -1)).to_a.shuffle.take(tamano)) 
	
	
	#este metodo se salta aveces un valor
	#(0..(tamano -1)).to_a.shuffle.take(tamano)#Truco para generar secuencias aleatorias y unicas en ruby 
	#nuevo metodo
	#self << (0..(tamano-1)).to_a.sample(tamano)
	
  end
  
  # Funcion Mutar:
  # Realiza la mutación del cromosoma, recibe un numero entre 1 y 3 que indica cuanto del cromosoma mutar
  # con el valor de 3.0 se mutara levemente el cromosoma , con el valor de 2.0 se mutara considerablemente el cromosoma y 
  # con el valor de 1.0 se mutara todo le cromosoma, por defecto se recomienda mutarlo poco
  
  def Mutar (porcentaje)
	
	if porcentaje >= @tamano 
	
		puts "No puede tener un valor mas igual o mas grande que el tamaño del arreglo"
	else
	
		valormutar = (@tamano / porcentaje).ceil
		if (valormutar <= 1) || (valormutar % 2 == 1)
			valormutar = valormutar+1
		end
		
		indicedearranque = rand((@tamano-1) - valormutar)
		
		#puts "el valor de mutación es"
		#puts valormutar
		#puts "el valor random es"
		#puts indicedearranque
		#puts "el array antes de mutar es"
		 
		#puts self
		
		
		i = 1
		while i <= valormutar
		
			valorTemp = self[indicedearranque]
			self[indicedearranque] = self[indicedearranque+1]
			self[indicedearranque+1] = valorTemp
			indicedearranque = indicedearranque+2
			i+=2
		end
		#puts "el array despues de mutar es"
		 
		#puts self
		
		
	end
	
	self.calcularActitud()
	
	
  
  end
  
  #Función Cruce:
  #Realiza el cruce uniforme del cromosoma- no se va a usar pero se debe implementar
  def Cruce
  
  end
  
  ##Funcion encargada de sacar las diagonales principales
  #| X |   | 
  #|   | X |  
   def calcularDiagonalPrincipal (indice, valor)
	 valores = Array.new
	 indices = Array.new
	 
	 indicefor = indice
	 valorfor  = valor
		
		##Se calculan los valores diagonales hacia adelante
		while (indicefor <= (@tamano-1) && valorfor <= (@tamano-1))  do
			indices << indicefor
			valores << valorfor
			indicefor +=1
			valorfor  +=1
			
		end
		
		##Se calculan los valores diagonales hacia atras
		indicesnew = Array.new
		valoresnew = Array.new
		indicefor = indice-1
		valorfor  = valor-1
		while (indicefor >= 0 && valorfor >= 0)  do
			indicesnew << indicefor
			valoresnew << valorfor
			indicefor -=1
			valorfor  -=1
			
		end
		
		matriz = Matrix[indicesnew.reverse + indices, valoresnew.reverse + valores]
		#puts matriz[0][1]
		#puts "values"
		
		# matris [filas (0 para indices- 1 para valores) , columnas son valores(valor inicial...valor final)]
		#puts matriz[0,5]
		return matriz
  
  
  end
  
  ##Funcion encargada de sacar las diagonales secundarias
  #|   | X | 
  #| X |   |  
   def calcularDiagonalSecundaria (indice, valor)
	 indices = Array.new
	 valores = Array.new
	 
	 indicefor = indice
	 valorfor  = valor
		
		##Se calculan los valores diagonales hacia adelante
		while (indicefor <= (@tamano-1) && valorfor >= 0)  do
			
			indices << indicefor
			valores << valorfor
			indicefor +=1
			valorfor  -=1
			
		end
		
		##Se calculan los valores diagonales hacia atras
		valoresnew = Array.new
		indicesnew = Array.new
		indicefor = indice-1
		valorfor  = valor+1
		while (indicefor >= 0 && valorfor <= (@tamano-1))  do
			
			indicesnew << indicefor
			valoresnew << valorfor
			indicefor -=1
			valorfor  +=1
			
		end
		matriz = Matrix[indicesnew.reverse + indices, valoresnew.reverse + valores]
		#puts matriz[0,1]
		#puts "values"
		#puts matriz[1,0]
		return matriz
  end
  
  
 
  ##Funcion calcularActitud
  #retorna la actitud de el cromosoma detectando sus ataques diagonales
  def calcularActitud
	
	@aptitud = 0
	
	self.each_with_index do |item, index|
			
			
				principalTemp = calcularDiagonalPrincipal(index, item)
				secondaryTemp = calcularDiagonalSecundaria(index, item)
				#puts "principal es #{principalTemp}"
				
				#puts "secundario es #{secondaryTemp}"
				
				
				principalTemp.row(0).each_with_index do |value , newindex|
				
				
					if (self[value] == principalTemp.row(1)[newindex] && index != value)
						
						@aptitud -=1
						
					end
								
				end
				
				secondaryTemp.row(0).each_with_index do |value , newindex|
				
					
					if (self[value] == secondaryTemp.row(1)[newindex] && index != value)
						@aptitud -=1
					end
								
				end
			
			
	end
    
    end

end





#Definicion de la clase Genetic que se encarga de la funcionalidad
class Genetic < Array 

	#Constructor de la clase
	#Recibe un numero de cromosomas y los crea 
	def initialize(cromosomas,tamano)
		
	
		@numeroCromosomas = cromosomas
		@tamano = tamano
		
		for counter in 1..@numeroCromosomas
			cromtemp = Cromosoma.new(tamano)
			cromtemp.calcularActitud()
			self << cromtemp
		end

	end
	
	#Función para determinar la aptitud dependiendo de los ataques
	
	
	
	
	
	
	#funcion ejecutar que se encarga de la ejecución del proyecto
	def Ejecutar(mejores)
	
		i = 0
		hayCandidato = false
		
		while  hayCandidato == false  do
	
		##Se muta todos los cormosomas
		#realizar mutación
			self.each_with_index do |item, index|
				##puts "se muta cromosoma: #{index}"
				
				if (item.aptitud == 0 )
					hayCandidato = true
						puts "HAYY CANDIDATO--------------------"
						puts "con la aptitud: #{item.aptitud}" 
						puts item
				end
				
				item.Mutar(3)
				
				
			end
		##Se evaluan los cromosomas y pasa el (o los) de mayor aptitud
		##estos pasan al siguiente generacion
		##si la aptitud llega a 0 se para
		
		## para estudiar la aptitud se ordenan los cromosomas usando el parametro ptitud
		
			temp = self.sort_by(&:aptitud).reverse
			
			self.replace(temp)
			#self.each do |item|
			#	puts "la generacion es"
			#	puts item.aptitud
				
			#end	
				
				
			##se crea la nueva generación con los n mejores de la anterior y nuevos
			faltantes = @numeroCromosomas - mejores
			
			#puts "fltantes #{faltantes}"
			nuevaGeneracion = self.take(mejores)
				
			#nuevaGeneracion.each do |item|
			#	puts "la mejor generacion es"
			#	puts item.aptitud
			#	puts "la mejor generacion es #{nuevaGeneracion[0].aptitud}"
			#end
			
			for counter in 0..faltantes-1	
			    temp = 	Cromosoma.new(@tamano)
			    temp.calcularActitud()
				nuevaGeneracion << temp	
			end
			
			
			self.replace(nuevaGeneracion)

			
			
	
	puts("generacion = #{i}" )
	i +=1
	end	
	
	end

    
  


end


=begin
cormo = Cromosoma.new(8,[3,7,5,4,6,0,2,1])

cormo.calcularActitud()

puts cormo.aptitud



puts "secundaria"

=end
hi = Genetic.new(4,10)
hi.Ejecutar(2)
#puts hi


