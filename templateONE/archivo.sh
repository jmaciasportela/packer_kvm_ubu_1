---
- hosts: target
  become: yes
  gather_facts: yes

  pre_tasks:
    - name: Ensure Ansible dependencies are installed (CentOS 6).
      yum:
        name: libselinux-python
        state: present
      when:
        - ansible_os_family == 'RedHat'
        - ansible_distribution_major_version | int == 6

  roles:
    - role: geerlingguy.nfs

  tasks:

    - name: Install some helpful utilities.
      apt:
        name:
          - git
          - wget
          - curl
          - vim
        state: present

    - name: Creates directory
      file:
        path: /root/hello
        state: directory

    - name: descargar ONE contextualizacion
      get_url:
        url: https://github.com/OpenNebula/addon-context-linux/releases/download/v5.0.3/one-context_5.0.3.deb
        dest: /root/hello/one-context_5.0.3.deb
    - name: desinstalat could init
      shell: apt-get purge -y cloud-init

    - name: instalar archivo .deb
      apt:
        deb: /root/hello/one-context_5.0.3.deb
        force: yes
    - name: instalar ruby
      apt:
        name: ruby
        state: present
   

sysadmin@julian:~/proyectoCI/ansibleCI/pl



---
- hosts: target
  become: yes
  gather_facts: yes

  pre_tasks:
    - name: Ensure Ansible dependencies are installed (CentOS 6).
      yum:
        name: libselinux-python
        state: present
      when:
        - ansible_os_family == 'RedHat'
        - ansible_distribution_major_version | int == 6
  roles:
    - role: geerlingguy.nfs      
  
  tasks:
    
    - name: Install some helpful utilities.
      apt:
        name:
          - git
          - wget
          - curl
          - vim
        state: present

    - name: Creates directory
      file:
        path: /root/hello
        state: directory    

    - name: descargar ONE contextualizacion
      get_url:
        url: https://github.com/OpenNebula/addon-context-linux/releases/download/v5.10.0/one-context_5.10.0-1.deb
        dest: /root/hello/one-context_5.10.0-1.deb

    - name: desinstalar could init
      shell: apt-get purge -y cloud-init

    - name: instalar one context
      shell: dpkg -i /root/hello/one-context_5.10.0-1.deb || apt-get install -fy 
     
    