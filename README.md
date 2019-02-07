Scripts to build Python 3.7 on Ubuntu 16.04
===========================================

You can run build.sh directly, or use Docker like this:

```bash
    docker build --tag python_builder .
    docker run --rm --interactive --tty --name python_builder python_builder

    # run inside the docker container:
    ./build.sh

    # run this from a another terminal while the container is still running:
    docker cp python_builder:/Python-3.7.2/python3.7_3.7.2-1_amd64.deb .

    # install the package
    sudo dpkg -i python3.7_3.7.2-1_amd64.deb
```

Note:
-----

You should check whether a newer version of Python is available and modify the
`build.sh` accordingly. The commands above will also have to be modified.
