#!/bin/bash
apt update
apt upgrade

apt install proftpd

apt update

useradd -d /home/ftp/merry/-s/dev/null merry>/devnull 2>&1

passwd merry

useradd -d /home/ftp/pippin/-s/dev/null pippin/>/devnull 2>&1

passwd pippin

sed -i -e "s@#include /etc/proftpd/tls.conf@Include /etc/proftpd/tls.conf@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   User ftp@User ftp@" /etc/proftpd/proftpd.conf
sed -i -e "s@# <Anonymous ~ftp>@<Anonymous ~ftp>@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   Group nogroup@Group nogroup@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   useralias anonymous ftp@UserAlias anonymous ftp@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   DirFakeUser on ftp@DirFakeUser on ftp@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   DirFakeGroup on ftp@DirFakeGroup on ftp@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   RequireValidShell off@RequiredValidShell off@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   MaxClients 10@MaxClients 10@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   Displaylogin welcome.msg@Displaylogin welcome.msg@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   DisplayChdir .message@DisplayChdir .message@" /etc/proftpd/proftpd.conf
sed -l -e "s@#   <Directory *>@<Directory *>@" /etc/proftpd/proftpd.conf
sed -i -e "s@#     <Limit WRITE>@<Limit WRITE>@" /etc/proftpd/proftpd.conf
sed -i -e "s@#       DenyAll@DenyAll@" /etc/proftpd/proftpd.conf
sed -i -e "s@#     </Limit>@</Limit>@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   </Directory>@</Directory>@" /etc/proftpd/proftpd.conf
sed -i -e "s@# </Anonymous>@</Anonymous>@" /etc/proftpd/proftpd.conf
sed -i -e "s@#TLSEngine                                on/\TLSEngine                                on/" /etc/proftpd/tls.conf
sed -i -e "s@#TLSLog                                   /var/log/proftpd/tls.log@TLSLog                                   /var/log/proftpd/tls.log@" /etc/proftpd/tls.conf
sed -i -e "s@#TLSProtocol                             SSLV23@TLSProtocol                             SSLV23@" /etc/proftpd/tls.conf
sed -l -e "s@#TLSRSACertificateFile                   /etc/ssl/certs/proftpd.crt/\TLSRSACertificateFile                   /etc/ssl/certs/proftpd.crt@" /etc/proftpd/tls.conf
sed -l -e "s@#TLSVerifyClient                        off@TLSVerifyClient                         off@" /etc/proftpd/tls.conf
sed -i -e "s@#TLSRequired                            on@TLSRequired                              on@" /etc/proftpd/tls.conf

apt-get install openssl
mkdir /etc/proftpd/ssl
openssl req -new -x509 -days 365 -nodes -out /etc/ssl/certs/proftpd.crt -keyout /etc/ssl/private/proftpd.key
sudo /etc/init.d/proftpd restart
