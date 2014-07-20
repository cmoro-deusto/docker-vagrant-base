# Based on ubuntu 14:04
FROM phusion/baseimage:0.9.12
MAINTAINER Xabier Larrakoetxea <slok69@gmail.com>


# Create vagrant user and group
RUN groupadd vagrant
RUN useradd vagrant -m -g vagrant -G sudo -s /bin/bash
RUN passwd -d -u vagrant
RUN echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant
RUN chmod 0440 /etc/sudoers.d/vagrant


# Set private key for user
USER vagrant
RUN mkdir /home/vagrant/.ssh
RUN chmod 700 /home/vagrant/.ssh
ADD authorized_keys /home/vagrant/.ssh/authorized_keys
ADD bashrc /home/vagrant/.bashrc
USER root
RUN chmod 0600 /home/vagrant/.ssh/authorized_keys
RUN chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
RUN chmod 0644 /home/vagrant/.bashrc
RUN chown vagrant:vagrant /home/vagrant/.bashrc

EXPOSE 22

# Start the magic
CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*