#!/bin/bash -eux

# Use OSL for repos
sed -i -e 's/^\(mirrorlist.*\)/#\1/g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/os\/.*/baseurl=http\:\/\/centos-altarch.osuosl.org\/$releasever\/os\/power9\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/updates\/.*/baseurl=http\:\/\/centos-altarch.osuosl.org\/$releasever\/updates\/power9\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/addons\/.*/baseurl=http\:\/\/centos-altarch.osuosl.org\/$releasever\/addons\/power9\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/extras\/.*/baseurl=http\:\/\/centos-altarch.osuosl.org\/$releasever\/extras\/power9\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/centosplus\/.*/baseurl=http\:\/\/centos-altarch.osuosl.org\/$releasever\/centosplus\/power9\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/contrib\/.*/baseurl=http\:\/\/centos-altarch.osuosl.org\/$releasever\/contrib\/power9\//g' /etc/yum.repos.d/CentOS-Base.repo
