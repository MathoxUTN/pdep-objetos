//PUNTO 1
class Lugar{
  var property name

  method tieneCantLetrasPar() = (name.size() % 2) == 0

  method esDivertido()= self.tieneCantLetrasPar() and self.esDivertidoParticular()

  method esRaro() = name.size() > 10

  method esDivertidoParticular()
  method esTranquilo()
}
class Ciudad inherits Lugar{
  var property cantHabitantes
  var property atracciones
  var property dbPromedio

  override method esDivertidoParticular()= (cantHabitantes > 100000) and (atracciones.size() > 3)

  override method esTranquilo() = dbPromedio < 20
}

class Pueblo inherits Lugar{
  var property extension
  var property fundadoEn
  var property provincia
  const property provinciasLitoral = ["Entre Ríos","Corrientes","Misiones"]

  method esDelLitoral() = provinciasLitoral.contains(provincia)

  override method esDivertidoParticular() = fundadoEn < 1800 and self.esDelLitoral()
  
  override method esTranquilo() = provincia == "La Pampa"

}

class Balneario inherits Lugar{
  var property metrosPlaya
  var property marPeligroso
  var property tienePeatonal

  override method esDivertidoParticular()= metrosPlaya > 300 and marPeligroso

  override method esTranquilo() = !tienePeatonal
}

//PUNTO 2
class Persona{
  var property preferencia

  method vacacionaEn(lugar) = preferencia.cumplePreferencia(lugar)
}

object tranquilidad{
  method cumplePreferencia(lugar) = lugar.esTranquilo()
}

object diversion{
  method cumplePreferencia(lugar) = lugar.esDivertido()
}

object rareza{
  method cumplePreferencia(lugar) = lugar.esRaro()
}

class PreferenciaVariada{
  var property preferencias
  method cumplePreferencia(lugar) = preferencias.any( {preferencia => preferencia.cumplePreferencia(lugar)} )
}

//PUNTO 3
class Tour{
  var property fechaSalida
  var property cantidadRequeridaPersonas
  var property lugaresARecorrrer
  var property montoXPersona
  var property personas

  method incorporarPersona(persona) {
    if(self.tourAdecuadoPara(persona) and self.estaConfirmado()){
      personas.add(persona)
    } else{
      throw new Exception(message = "La persona no puede incorporarse al tour.")
    }
  }

  method estaConfirmado() = personas.size() == cantidadRequeridaPersonas

  method tourAdecuadoPara(persona) = self.montoEsAdecuado(persona) and self.lugaresSonAdecuados(persona)

  method montoEsAdecuado(persona) = montoXPersona < persona.presupuestoMaximo() 

  method lugaresSonAdecuados(persona) = lugaresARecorrrer.all({lugar => persona.vacacionaEn(lugar)})

  method darDeBajaPersona(persona) = personas.remove(persona)
}

//PUNTO 4

//Una clase reporte? Que contenga todos los tours?
class Reporte{

}
