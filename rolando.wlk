object rolando {
 const mochila = []
 var capacidadDeMochi = 2

 method capacidadDeMochi() {
   return capacidadDeMochi
 }

 method capacidadDeMochi(capacidad) {
   capacidadDeMochi = capacidad
 }

 method recoleccionDeArtefacto (artefacto ) {
   self.evaluarCapacidadDeMochi(artefacto )
   mochila.add(artefacto)
 }

 method evaluarCapacidadDeMochi(artefacto) {
   if( mochila.size() == self.capacidadDeMochi()){
    self.error("mochila llena!!")
   }
 }

 method conocerArtefactos() {
   return mochila
 }
}

object espadaDelDestino {
  var poder = 1000
}
object libroDeHechizos {
  var poder = 500
}
object collarDivino {
  var poder = 100500
}