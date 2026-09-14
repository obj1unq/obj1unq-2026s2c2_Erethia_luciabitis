import rolando.*
import artefactos.*

object erethia {
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

  method todoPoderoso(personaje) = enemigosDeRolando.all(
    { enemigo => enemigo.puedeSerVencidoPor(personaje) }
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