# Наша сборка Jitsi Meet

Для сбоки с excalidraw, который умеет шарить картинки нужно собрать deb пакет:
* в репе https://github.com/procraft/excalidraw создаем архив командой `make our-build`
* в `package.json` для зависимости `@jitsi/excalidraw` прописываем путь к созданному архиву
* запускаем сборку deb-пакета командой `make our-build`
* созданный deb-пакет накатываем на стандарный обрыз для jitsi-web сервиса
