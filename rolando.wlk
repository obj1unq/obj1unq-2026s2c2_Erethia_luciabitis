import erethia.*
import artefactos.*


//rolando
object rolando {
  var encuentros = []
  var poderBase = 0
  var cantidadDeBatallas = 0
  
  method poderBase() = poderBase
  
  method poderBase(_poder) {
    poderBase = _poder
  }
  
  method poderPotenciado(_poder) = poderBase + _poder
  
  method encuentros() = encuentros
  
  method encontrar(artefacto) {
    encuentros += [artefacto]
    mochila.rolandoEncuentra(artefacto)
  }
  
  method llegadaAlHogar() {
    castilloDePiedra.almacenArtefactos(mochila.artefactos())
    mochila.limpiar()
  }
  
  method artefactosEnTotal() = mochila.artefactos().union(
    castilloDePiedra.almacen()
  )
  
  method poderDeBatalla() = poderBase + mochila.sumaDePoderes()
  
  method batalla() {
    poderBase += 1
    cantidadDeBatallas += 1
    mochila.usarArtefactos()
  }
  
  method enemigosVencibles() = erethia.batalla(self)
  
  method moradasConquistables() = erethia.batallaPorMoradas(self)
  
  method tieneElArtefactoFatalContra(enemigo) = mochila.artefactoFatalContra(enemigo)

  method elArtefactoFatalContra(enemigo) = mochila.existeArtefactoFatalContra(enemigo)
}

object mochila {
  const artefactos = #{}
  var capacidadDeMochi = 2
  
  method rolandoEncuentra(artefacto) {
    if (artefactos.size() < capacidadDeMochi) artefactos.add(artefacto)
  }
  
  method capacidadDeMochi() = capacidadDeMochi
  
  method capacidadDeMochi(capacidad) {
    capacidadDeMochi = capacidad
  }
  
  method artefactos() = artefactos
  
  method artefactos(_artefactos) {
    artefactos.addAll(_artefactos)
  }
  
  method limpiar() {
    artefactos.clear()
  }
  
  method sumaDePoderes() = artefactos.sum(
    { artefacto => artefacto.poderAportado(rolando) }
  )
  
  method usarArtefactos() {
    artefactos.forEach({ artefacto => artefacto.usar() })
  }
  
  method tieneArtefacto(artefacto) {
    artefactos.contains(artefacto)
  }
  
  method artefactoFatalContra(enemigo) = artefactos.any(
    { artefacto => artefacto.poderAportado(rolando) > enemigo.poder() }
  )
  
  method existeArtefactoFatalContra(enemigo) = artefactos.find(
    { artefacto => artefacto.poderAportado(rolando) > enemigo.poder() }
  )
} 

object castilloDePiedra {
  const almacen = #{}
  
  method almacen() = almacen
  
  method almacenArtefactos(artefactos) {
    almacen.addAll(artefactos)
  }
  
  method artefactoMasPoderoso(personaje) = almacen.map(
    { artefacto => artefacto.poderAportado(personaje) }
  ).max()
  
  method agregarArtefactos(_artefactos) {
    almacen.addAll(_artefactos)
  }
} 
