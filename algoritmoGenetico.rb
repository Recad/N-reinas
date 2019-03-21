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

#Definicion de la clase cromosoma
class Cromosoma < Array 
	
  #Se utiliza attr_accessor para definir de forma automatica los set y get de 
  #la variable aptitud
  attr_accessor :aptitud
  
  #Constructor de la clase
  #Recibe un tamaño y crear un array de enteros que no se repiten
  def initialize(tamano)
	super
    @tamano = tamano
	self.clear 
	self << (0..50).to_a.shuffle.take(tamano) #Truco para generar secuencias aleatorias y unicas en ruby 
	
  end
  
  # Funcion Mutar:
  # Realiza la mutación del cromosoma
  def Mutar
  
  end
  
  #Función Cruce:
  #Realiza el cruce uniforme del cromosoma- no se va a usar pero se debe implementar
  def Cruce
  
  end
 
end


cormo = Cromosoma.new(10)

puts cormo



