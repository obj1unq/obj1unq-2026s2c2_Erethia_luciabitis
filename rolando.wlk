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
  
  method enemigosVencibles() = enemigos.batalla(self)
  
  method moradasConquistables() = enemigos.batallaPorMoradas(self)
  
  method todoPoderoso() = enemigos.enemigos().all(
    { enemigo => enemigo.puedeSerVencidoPor(self) }
  )
  
  method tieneElArtefactoFatalContra(enemigo) = mochila.hayUnArtefactoFatal(enemigo)

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
  
  method hayUnArtefactoFatal(enemigo) = artefactos.any(
    { artefacto => artefacto.poderAportado(rolando) > enemigo.poder() }
  )
  
  method existeArtefactoFatalContra(enemigo) = artefactos.find(
    { artefacto => artefacto.poderAportado(rolando) > enemigo.poder() }
  )
} //castillo

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
} //artefactos

object espadaDelDestino {
  var fueUsado = false
  
  method usar() {
    fueUsado = true
  }
  
  method poderAportado(personaje) = if (fueUsado) personaje.poderBase() * 0.5
                                    else personaje.poderBase()
}

object libroDeHechizos {
  const hechizos = []
  
  method agregarHechizos(_hechizos) {
    hechizos.addAll(_hechizos)
  }
  
  method hechizoActual() = hechizos.first()
  
  method poderAportado(personaje) = if (hechizos.isEmpty()) 0
                                    else hechizos.first().poder(personaje)
  
  method usar() {
    if (!hechizos.isEmpty()) hechizos.remove(hechizos.first())
  }
}

object bendición {
  const poder = 4
  
  method poder(personaje) = poder
}

object invisibilidad {
  method poder(personaje) = personaje.poderBase()
}

object invocación {
  method poder(personaje) = castilloDePiedra.artefactoMasPoderoso(personaje)
}

object collarDivino {
  const puntos = 3
  var usos = 0
  
  method puntos() = puntos
  
  method usar() {
    usos += 1
  }
  
  method poderAportado(personaje) = if (personaje.poderBase() > 6) puntos + usos
                                    else puntos
}

object armaduraDeAceroValyrio {
  const poder = 6
  var usos = 0
  
  method usar() {
    usos += 1
  }
  
  method poderAportado(personaje) = poder
} //enemigos!

object enemigos {
  const enemigosDeRolando = #{}
  
  method enemigos(_enemigos) {
    enemigosDeRolando.addAll(_enemigos)
  }
  
  method enemigos() = enemigosDeRolando
  
  method batalla(personaje) = enemigosDeRolando.filter(
    { enemigo => enemigo.puedeSerVencidoPor(personaje) }
  )
  
  method batallaPorMoradas(personaje) = self.batalla(personaje).map(
    { enemigo => enemigo.morada() }
  )
}

object caterina {
  const poder = 28
  const morada = fortalezaDeAcero
  
  method poder() = poder
  
  method morada() = morada
  
  method puedeSerVencidoPor(personaje) = personaje.poderDeBatalla() > poder
}

object archibaldo {
  const poder = 16
  const morada = palacioDeMármol
  
  method poder() = poder
  
  method morada() = morada
  
  method puedeSerVencidoPor(personaje) = personaje.poderDeBatalla() > poder
}

object astra {
  const poder = 14
  const morada = torreDeMarfil
  
  method poder() = poder
  
  method morada() = morada
  
  method puedeSerVencidoPor(personaje) = personaje.poderDeBatalla() > poder
} //lugares enemigos

object fortalezaDeAcero {
  method moradaConquistada(personaje) = caterina.puedeSerVencidoPor(personaje)
}

object palacioDeMármol {
  method moradaConquistada(personaje) = archibaldo.puedeSerVencidoPor(personaje)
}

object torreDeMarfil {
  method moradaConquistada(personaje) = astra.puedeSerVencidoPor(personaje)
}