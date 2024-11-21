## Despliegue Automático con GitHub Actions

Se ha creado el archivo `./github/workflows/cd.yml` para automatizar el despliegue en la rama principal (`master`) del repositorio. El flujo se activa cuando se completa una **pull request** que ha sido fusionada (merge) en la rama `master`.

### Decisión de Diseño

El enunciado del laboratorio indicaba que el despliegue debía ejecutarse al producirse un **merge** en la rama principal. Aunque habría sido posible configurar el flujo para que se disparara mediante un evento de **push** a `master`, esta opción no fue elegida por las siguientes razones:

- Un **push** puede realizarse directamente en la rama principal sin pasar por un **merge**, lo cual no es una buena práctica.
- Usar un flujo basado en **pull request** asegura que los cambios hayan sido revisados, aprobados y fusionados correctamente antes de proceder con el despliegue.

### Ventajas del Enfoque Basado en Pull Request

- **Mayor control**: Garantiza que solo los cambios revisados y aprobados lleguen a producción.
- **Buenas prácticas**: Refuerza un flujo de trabajo más estructurado y colaborativo, evitando actualizaciones directas a la rama principal.

Este diseño refleja una decisión consciente para alinear el proceso de automatización con las mejores prácticas de desarrollo y los objetivos del laboratorio.


---

### Diferencias Entre los Dos Enfoques

A continuación, se detallan los cambios principales entre el código actual (basado en **pull request**) y el que usaría un evento de **push**:

#### Código Actual: Basado en Pull Request

```yaml
on:
  pull_request:
    types:
      - closed

jobs:
  cd:
    if: ${{ github.event.pull_request.merged == true && github.event.pull_request.base.ref == 'master' }}
    runs-on: ubuntu-latest
    steps:
      # Pasos de despliegue...
```

#### Código Alternativo: Basado en Push

```yaml
on:
  push:
    branches:
      - master

jobs:
  cd:
    runs-on: ubuntu-latest
    steps:
      # Pasos de despliegue...
```
