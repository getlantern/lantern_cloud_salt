base-packages:
    pkg.installed:
        - order: 1
        - names:
            - python-software-properties
            - build-essential
            - git
            - python-dev

some-pip:
    cmd.run:
        - name: "apt-get install pip -y"
        - unless: "which pip"

the-right-pip:
    cmd.run:
        - name: "pip install --upgrade pip"
        # The apt-get version of pip installs to /usr/bin/pip instead.
        - unless: "[ $(which pip) == /usr/local/bin/pip ]"
        - order: 1
        - require:
            - cmd: some-pip

# git fileserver backend needs this.  Maybe the git state too? (*shrug*)
gitpython:
    pip.installed:
        - order: 1
        - require:
            - pkg: build-essential
            - pkg: git
            - pkg: python-dev
            - cmd: the-right-pip
