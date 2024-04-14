# Desafío Técnico Ruby

Este es un breve proyecto desarrollado con Ruby on Rails. La aplicación utiliza SQLite como base de datos y una parte del frontend está construida con HTML, JAVASCRIPT y CSS

### Requisitos Previos
- Ruby
- Bundler

### Instalación de Ruby y Dependencias
Para instalar Ruby, puedes seguir las instrucciones en [el sitio oficial de Ruby](https://www.ruby-lang.org/es/documentation/installation/).

Después de instalar Ruby, navega hasta el directorio raíz del proyecto (EJECUTAR LA CONSOLA DENTRO DE LA CARPETA BACKEND)

comprobar version de bundle y ruby ( bundle --version, ruby -v)
Si desea borrar los registros de la tabla e insertar nuevos respetando las condiciones de past 30days o que no haya duplicados, pueden hacerlo usando la aplicacion creada ejecuntando
"rake fetch_sismic_data:fetch_and_persist_data" (añade registros cumpliendo las condiciones mencionadas y pedidas)


### NOTA
A veces puede no aparecer en algunos navegadores los objetos de formato json obtenidos por la api esto puede ocurrir por la compatibilidad de estos formatos en los navegadores aunque existen visualizadores o aplicaciones que resuelven esto,
en esta aplicacion probe con thunder client para probar tanto el metodo GET como el POST

Quiza se me pudo faltar mencionar algo, pero solo me queda agradecer si lo llegan a ver, y cualquier critica constructiva lo tomaré con gusto

```bash
bundle install
rake fetch_sismic_data:fetch_and_persist_data
rails server
