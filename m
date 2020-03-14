Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A21C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E9920637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="GjfPFtBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCOBh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:37:26 -0400
Received: from mail-eopbgr1320089.outbound.protection.outlook.com ([40.107.132.89]:57133
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbgCOBh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:37:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h05uz14uLGDRfbd4No0rvmIKZ6qpzNaXjDsqF+pSfGHkEV+aEM5JJiT5cudvYMKH4p3s1Jy1fmZJ70C5x2vgzryEdJVWNp0j8VF+6Jhb7kn3np9ZThbLGtajYY/4hlh3M3vq873901mTDpnl7JXoGJw26R44GR+G+iQGM4YSCXdUBHjqSqr60dwtbeciRAr5F9v3/1OosNd7jVCIwbeGN33AYKtorhY0//avI+bzTT/LpLc8GeAS5iZxTCOMRH8zw+9oCktysLBPLFi2Hjl0QDbekWwdhumELMDZSIDQxodX3o5Er5PVUIDxvJlNYhp6E6CSt2pBYIthGPhriLk5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/8yApGUvHlOcjAhRQTTWDewXZzwx+B+uJ/5cLBgpJ8=;
 b=Cpf4DX7HwAbPyMaRtu/SeFDKx2rNTObbX6NdbusI5Nj38n8LCQwrqv+6BhBxGSFXRGXuVwXObBLmTWmPSMHd8Y4sObiuiEFpw/wbgj9qoo5olDrDer/x23kQ29ns3iKIsVth7DT3YYkCoxwcgKwswuVw8nPbyob2wIAMuQaydwkDne6w3RI1QxK5DkyefRX+fj2UDxk9/pHiBwMZ7qsx4erVq0TGzh4505XJF5x/4fyYUkyvT5IaRoIoaPc0xxe15d/DBjNpY2YF2b2yPlXGYEPdWlPFXG+1VqP9VHKphdLYDhtsOLHfaP5qxMydO9brcEtdYctqR+iCaGQpNWM7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/8yApGUvHlOcjAhRQTTWDewXZzwx+B+uJ/5cLBgpJ8=;
 b=GjfPFtBfAoryziMIUzQJH0xAcY2F7JqQGWXEFLQOcoj1/guveH5K5iIcdvTzpoKHn6vTyxqh/AmCBuFKLzaZFcZTX7EP1m7VUdS0D8Xf3S/FEErr5CWvOFyj4mNu2FrrhnAhVHv4WB1ZOPJLnlCBtWcSDIJKTrfmdxfv3nzoTGQ=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3397.apcprd01.prod.exchangelabs.com (20.178.154.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Sat, 14 Mar 2020 16:11:22 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::684a:9e0b:7e12:18bd]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::684a:9e0b:7e12:18bd%4]) with mapi id 15.20.2814.021; Sat, 14 Mar 2020
 16:11:21 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: How to create a Bootable Live CD/DVD from your Linux From Scratch
 (LFS) build
Thread-Topic: How to create a Bootable Live CD/DVD from your Linux From
 Scratch (LFS) build
Thread-Index: AQHV+hsSFHWB5s/g7UO7TGT/U0u5qQ==
Date:   Sat, 14 Mar 2020 16:11:21 +0000
Message-ID: <SG2PR01MB214116AC6A583C9F8DB7734387FB0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ac3b15f-572f-4031-6913-08d7c8325656
x-ms-traffictypediagnostic: SG2PR01MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB339704FBC5C01E392CAFF28187FB0@SG2PR01MB3397.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 034215E98F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(39830400003)(376002)(199004)(71200400001)(66946007)(6916009)(52536014)(186003)(76116006)(16799955002)(8936002)(66556008)(64756008)(66446008)(86362001)(33656002)(81166006)(81156014)(8676002)(66476007)(107886003)(5660300002)(340484012)(7696005)(316002)(9686003)(55016002)(6506007)(30864003)(26005)(2906002)(4326008)(508600001)(966005)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3397;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /rcdsTZeZAREzSDDvUUUZTtyMEaxCyCVaYMXPwLEjEvdmspwrO6gMzL5knQAJip3s/DxZ8rrV4lDkedOlHXkkJPH0Ugd6q4440P5POFoPa54mU5fF7J9Q/7Jfkvhe9XTfMHv13DCZjSOf8MPsk+evDeH7kgtzyI9gDzwS7Dx7g5jUz3BZB5X6zm+k0QFju+snwyfG5KbE5IcC3WygtIieUOPOiJf26MANma9H/tfJIDfiQjbCaeWYtCs3TPtjUVF1c/ofmnXPNqZ0M0YUcNEvp/7l7kRe4+0ERLbav4IDbuRolBgIjv3TKTlcq2xzcFTAsitmlkoFaJB+sv7YZQaa5FYlHeuEz7rzmy+EAdmTDdh4x8TAp5IVekS1ARBYW3vClZQ+UOy6eE8AafiiweLfbyN3jp5enQozK5uQA3aH6zDGgMO0hypQuq4YKX6eg0Rdz8eWDK+Hlt7yJPHMDK++z4Jp6zijqspiAeFxREoF8chywRgqmdK58Yj3/2x1dLQc0Q4eoyC4mZW+PKnFJDHTzJU4f4fAl8DfoLkqIfrPH2XThbURfNDBNB3opqJO301
x-ms-exchange-antispam-messagedata: 5ZDhQuFfo9Qz0sf3Bie2HVZ9kOKl1VhyIYOOgkF3kEfNxguNEZAo0N4HMw+uLNesJ9i89JBqDvXF2x3U5v5bANoIZZB+CRRMA0jWg/h3tGkewIQ4GACic0W4IAzNqkTOzPLCJF+O7gMzHQudq4wqBA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac3b15f-572f-4031-6913-08d7c8325656
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2020 16:11:21.4750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cev1/Jhumf3njKDESvi+fndECDvsFu6x9II0LR5cHXpxGW9uty8pavTSQdhP+HsaDU5j3B/mKpgmIHtHqj3lwa5qQYmpSvyORNrpijT3kbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject of Hint: How to create a Bootable Live CD/DVD from your Linux From =
Scratch (LFS) build=0A=
=0A=
Good day from Singapore,=0A=
=0A=
I am Mr. Turritopsis Dohrnii Teo En Ming, based in Singapore.=0A=
=0A=
I have recently *successfully* created my own custom Linux distribution cal=
led Teo En Ming Linux 2020.03 (FINAL), which is based on =0A=
Linux From Scratch 20200302-systemd book and Linux Kernel 5.5.7, on 12 Marc=
h 2020.=0A=
=0A=
You may refer to my redundant blog posts for the announcement.=0A=
=0A=
Blogger: Announcing Teo En Ming Linux 2020.03 (FINAL)=0A=
Link: https://tdtemcerts.blogspot.com/2020/03/announcing-teo-en-ming-linux-=
202003.html=0A=
=0A=
Wordpress: Announcing Teo En Ming Linux 2020.03 (FINAL)=0A=
Link: https://tdtemcerts.wordpress.com/2020/03/12/announcing-teo-en-ming-li=
nux-2020-03-final/=0A=
=0A=
Jimmy Anderson's guide/hint was written on 20 Jan 2013, which is more than =
7 years ago. Today is 14 March 2020 Saturday. Therefore, his guide is defin=
itely outdated=0A=
and needs some tweaking to adapt to the *latest* LFS system at the time of =
this writing.=0A=
=0A=
Jimmy Anderson's guide/hint was verified with LFS version 7.2. I have made =
*extensive* modifications to his guide/hint to work with my LFS 20200302-sy=
stemd build.=0A=
=0A=
You can download Teo En Ming Linux 2020.03 (FINAL) Bootable Live CD/DVD ISO=
s from the following github.com link.=0A=
=0A=
Link: https://github.com/teo-en-ming/teo-en-ming-linux/blob/master/iso%20do=
wnload%20links.txt=0A=
=0A=
Note: Please note that my Live CD/DVD boots with a Kernel Panic. I hope tha=
t Linux experts will be able to download my ISO, examine its contents and f=
ind out what's wrong. =0A=
I would like to thank all of you in advance for your kind assistance and ad=
vise.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
The attached file is a new hint which describes how to turn your LFS build=
=0A=
into your own Live CD/DVD.=0A=
-------------- next part --------------=0A=
An HTML attachment was scrubbed...=0A=
URL: <http://lists.linuxfromscratch.org/pipermail/hints/attachments/2013032=
0/5714cb82/attachment.html>=0A=
-------------- next part --------------=0A=
=0A=
ORIGINAL AUTHOR: Jimmy Anderson (jimmy.anderson1057 at gmail.com)=0A=
ORIGINAL DATE: 2013-01-20=0A=
Link to original hint: http://lists.linuxfromscratch.org/pipermail/hints/20=
13-March/003307.html=0A=
=0A=
EDITED BY: Turritopsis Dohrnii Teo En Ming, Singapore=0A=
EDIT DATE: 14 MARCH 2020, SATURDAY=0A=
=0A=
LICENSE: =0A=
=0A=
Portions of the instructions in this hint were derived from scripts=0A=
in the LFScript project.  These scripts are covered by the following =0A=
license:=0A=
=0A=
# Permission is hereby granted, free of charge, to any person obtaining a c=
opy=0A=
# of this software and associated documentation files (the "Software"), to=
=0A=
# deal in the Software without restriction, including without limitation th=
e=0A=
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/=
or=0A=
# sell copies of the Software, and to permit persons to whom the Software i=
s=0A=
# furnished to do so, subject to the following conditions:=0A=
#=0A=
# The above copyright notice and this permission notice shall be included i=
n=0A=
# all copies or substantial portions of the Software.=0A=
#=0A=
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS O=
R=0A=
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,=
=0A=
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL T=
HE=0A=
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER=0A=
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
=0A=
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS=0A=
# IN THE SOFTWARE.=0A=
=0A=
This hint is also provided under the above license terms.=0A=
=0A=
=0A=
SYNOPSIS: How to create a bootable Live CD/DVD from your LFS build.=0A=
=0A=
DESCRIPTION:=0A=
=0A=
   This hint describes how to create a live CD/DVD from your LFS build.  Th=
e=0A=
resulting live CD/DVD can be used as an LFS/CLFS build host or for whatever=
 =0A=
purpose you desire.  =0A=
=0A=
   Briefly, you will build your LFS system and a "squashed" version =0A=
of it will be created.   A busybox based ramdisk will be created =0A=
which sets up a union mount (either aufs or unionfs) of the squashed =0A=
LFS system with a ram based file system and then the system will be =0A=
started with the union filesystem as root. =0A=
=0A=
   unionfs and aufs are not part of the standard kernel code.   To build=0A=
a live cd/dvd you must patch your kernel to add support for one or the othe=
r.=0A=
This hint will still work without aufs or unionfs support but the result =
=0A=
will not be a live CD/DVD but instead be a bootable CD/DVD (useful but=0A=
with lesser ability than a live cd/dvd). Teo En Ming *did not* patch Linux =
kernel 5.5.7=0A=
to add support for aufs or unionfs filesystems because he did not have the =
knowledge to tweak=0A=
the patches.   =0A=
=0A=
   The original hint was verified with LFS 7.2 x86 (32 and 64 bit).  It may=
=0A=
(likely will) work with other LFS versions also but it only was=0A=
specifically tested with 7.2 and you are on your own to work out how =0A=
to make it work with other LFS versions. Teo En Ming has modifed this guide=
/hint to allow it =0A=
to work with the latest LFS 20200302-systemd development book.=0A=
=0A=
   A description of each step and cut and paste for that=0A=
step is provided.  Cut and pasting should make it easier to build a live cd=
/dvd=0A=
but it is important that you understand what the purpose of each step=0A=
is.  Blindly cutting and pasting from this hint will probably not =0A=
result in success.  =0A=
=0A=
   Following this hint, like doing pretty much anything in LFS, has the =0A=
potential of damaging your system.   Before you begin, make sure =0A=
you've saved a copy of any data that is important to you.  It's also sugges=
ted=0A=
to follow this procedure on a system that is used only by you so that any =
=0A=
errors will not affect others.=0A=
=0A=
=0A=
ATTACHMENTS:=0A=
None=0A=
=0A=
PREREQUISITES:=0A=
=0A=
This hint assumes the reader is familiar with Linux From Scratch (LFS).  =
=0A=
=0A=
Much of this hint assumes that the LFS variable is properly set. So, =0A=
when following this hint, at all times make sure LFS is set properly:=0A=
=0A=
export LFS=3D/mnt/lfs   (or as needed for your setup)=0A=
=0A=
=0A=
HINT:=0A=
=0A=
Step 1) Download additional needed packages.=0A=
=0A=
   This step is done on the HOST (not in LFS chroot).=0A=
=0A=
   You will need some additional packages.   Download the squashfs tools,=
=0A=
busybox and syslinux.   The squashfs tools will be needed on the host.   =
=0A=
=0A=
=0A=
#------------ Cut and Paste start=0A=
cd /home/teo-en-ming/Downloads=0A=
wget -4 https://sourceforge.net/projects/squashfs/files/squashfs/squashfs4.=
4/squashfs4.4.tar.gz/download=0A=
wget -4 https://busybox.net/downloads/busybox-1.31.1.tar.bz2=0A=
wget -4 http://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-4.06.t=
ar.xz=0A=
#------------ Cut and Paste end=0A=
=0A=
   Additionally, the addendum of this hint contains a script that is =0A=
required for the live cd/dvd.   Save the addendum of this hint as:=0A=
=0A=
$LFS/sources/init.sh=0A=
=0A=
   Note: You can skip the aufs/unionfs kernel patch altogether if a =0A=
more simple bootable CD/DVD is adequate for your needs.=0A=
=0A=
=0A=
Step 2) Add squashfs tools to your host.   (Do this on your HOST)=0A=
=0A=
Teo En Ming's host operating system is Ubuntu 18.04.3 LTS Desktop Edition.=
=0A=
=0A=
   If you are running a host distribution which provides prepackaged=0A=
squashfs tools, you may be able to use them.   However they must be=0A=
at least version 4.1 to work properly with this hint.=0A=
=0A=
   It is recommended however, that you build squashfs tools 4.4 from =0A=
the source. This hint was tested with squashfs tools 4.4 and better=0A=
(xz) compression is obtained with 4.4 (compared with 4.1).  To build the=0A=
squashfs tools do:=0A=
=0A=
#------------ Cut and Paste start=0A=
cd /home/teo-en-ming/Downloads=0A=
tar xvfz squashfs4.4.tar.gz=0A=
cd squashfs4.4/squashfs-tools=0A=
Edit Makefile as follows:=0A=
XZ_SUPPORT =3D 1=0A=
COMP_DEFAULT =3D xz=0A=
sudo apt install liblzma-dev=0A=
make=0A=
sudo make install=0A=
mksquashfs -version=0A=
#------------ Cut and Paste end=0A=
=0A=
The version string displayed should be 4.4.   If not, you may need to =0A=
adjust your PATH so that $HOME/bin appears first in it.=0A=
=0A=
If you are on a single user system, or if no other version of =0A=
squashfs tools exists, squashfs tools could be installed in /usr/bin=0A=
or /usr/local/bin rather than $HOME/bin.=0A=
=0A=
If the lzma libraries are not installed, the build of squashfs-tools =0A=
will fail.   To resolve it, either install the lzma libraries or =0A=
rebuild squashfs without xz support.   squashfs (and this hint) can operate=
 =0A=
properly without xz support but without xz support, the resulting =0A=
live CD/DVD iso size will be somewhat larger.=0A=
=0A=
=0A=
Step 3) Build your LFS system and kernel.=0A=
=0A=
   Follow the instructions in the LFS/BLFS book and build your LFS system=
=0A=
as you normally would. =0A=
=0A=
When you configure the kernel, make sure the following are enabled =0A=
as builtins (not as modules):=0A=
=0A=
   SQUASHFS support (and support for SQUASHFS XZ compressed file systems).=
=0A=
   UNIONFS or AUFS support (Teo En Ming *did not* patch Linux Kernel 5.5.7 =
for AUFS or UNIONFS support).=0A=
   CDROM support (ISO9660).=0A=
   DEVTMPFS support.=0A=
=0A=
   Then build and install as normal:=0A=
#------------ Cut and Paste start=0A=
make=0A=
make modules_install=0A=
cp arch/x86/boot/bzImage /boot/vmlinuz-5.5.7-turritopsis.dohrnii.teo.en.min=
g=0A=
cp .config /boot/config-5.5.7=0A=
#------------ Cut and Paste end=0A=
=0A=
=0A=
   Additionally, /etc/fstab needs some tweaks for a live cd/dvd.   =0A=
Edit /etc/fstab and comment out all hard drive mounts.=0A=
But leave the virtual filesystem mounts (/proc and such) in it:=0A=
#------------ Cut and Paste start=0A=
# Teo En Ming's favorite text editor in Linux is nano.=0A=
nano /etc/fstab=0A=
>> comment out any hard drive mounts <<=0A=
#------------ Cut and Paste end=0A=
=0A=
   Build and configure the remainder of your LFS system as normal.  =0A=
=0A=
=0A=
Step 4) Build busybox in your LFS.=0A=
=0A=
   While inside the chroot environment add busybox to your=0A=
   LFS system:  =0A=
=0A=
ERROR compiling busybox with glibc-2.31: "sys-apps/busybox-1.31.1 fails to =
compile with sys-devel/glibc-2.31"=0A=
=0A=
Software Bug Link: https://bugs.gentoo.org/708350=0A=
=0A=
Link to patch file: https://708350.bugs.gentoo.org/attachment.cgi?id=3D6117=
80=0A=
=0A=
=3D=3D=3DStart File busybox-glibc-2.31.patch=3D=3D=3D=0A=
=0A=
diff --git a/coreutils/date.c b/coreutils/date.c=0A=
index 3414d38ae..4ade6abb4 100644=0A=
--- a/coreutils/date.c=0A=
+++ b/coreutils/date.c=0A=
@@ -279,6 +279,9 @@ int date_main(int argc UNUSED_PARAM, char **argv)=0A=
 		time(&ts.tv_sec);=0A=
 #endif=0A=
 	}=0A=
+#if !ENABLE_FEATURE_DATE_NANO=0A=
+	ts.tv_nsec =3D 0;=0A=
+#endif=0A=
 	localtime_r(&ts.tv_sec, &tm_time);=0A=
 =0A=
 	/* If date string is given, update tm_time, and maybe set date */=0A=
@@ -301,9 +304,10 @@ int date_main(int argc UNUSED_PARAM, char **argv)=0A=
 		if (date_str[0] !=3D '@')=0A=
 			tm_time.tm_isdst =3D -1;=0A=
 		ts.tv_sec =3D validate_tm_time(date_str, &tm_time);=0A=
+		ts.tv_nsec =3D 0;=0A=
 =0A=
 		/* if setting time, set it */=0A=
-		if ((opt & OPT_SET) && stime(&ts.tv_sec) < 0) {=0A=
+		if ((opt & OPT_SET) && clock_settime(CLOCK_REALTIME, &ts) < 0) {=0A=
 			bb_perror_msg("can't set date");=0A=
 		}=0A=
 	}=0A=
diff --git a/libbb/missing_syscalls.c b/libbb/missing_syscalls.c=0A=
index 87cf59b3d..dc40d9155 100644=0A=
--- a/libbb/missing_syscalls.c=0A=
+++ b/libbb/missing_syscalls.c=0A=
@@ -15,14 +15,6 @@ pid_t getsid(pid_t pid)=0A=
 	return syscall(__NR_getsid, pid);=0A=
 }=0A=
 =0A=
-int stime(const time_t *t)=0A=
-{=0A=
-	struct timeval tv;=0A=
-	tv.tv_sec =3D *t;=0A=
-	tv.tv_usec =3D 0;=0A=
-	return settimeofday(&tv, NULL);=0A=
-}=0A=
-=0A=
 int sethostname(const char *name, size_t len)=0A=
 {=0A=
 	return syscall(__NR_sethostname, name, len);=0A=
diff --git a/util-linux/rdate.c b/util-linux/rdate.c=0A=
index 70f829e7f..878375d78 100644=0A=
--- a/util-linux/rdate.c=0A=
+++ b/util-linux/rdate.c=0A=
@@ -95,9 +95,13 @@ int rdate_main(int argc UNUSED_PARAM, char **argv)=0A=
 	if (!(flags & 2)) { /* no -p (-s may be present) */=0A=
 		if (time(NULL) =3D=3D remote_time)=0A=
 			bb_error_msg("current time matches remote time");=0A=
-		else=0A=
-			if (stime(&remote_time) < 0)=0A=
+		else {=0A=
+			struct timespec ts;=0A=
+			ts.tv_sec =3D remote_time;=0A=
+			ts.tv_nsec =3D 0;=0A=
+			if (clock_settime(CLOCK_REALTIME, &ts) < 0)=0A=
 				bb_perror_msg_and_die("can't set time of day");=0A=
+		}=0A=
 	}=0A=
 =0A=
 	if (flags !=3D 1) /* not lone -s */=0A=
=0A=
=3D=3D=3DEnd File busybox-glibc-2.31.patch=3D=3D=3D=0A=
=0A=
#------------ Cut and Paste start=0A=
cd /sources=0A=
tar xvf busybox-1.31.1.tar.bz2=0A=
cd busybox-1.31.1=0A=
cat ../busybox-glibc-2.31.patch | patch -Np1=0A=
make defconfig=0A=
sed 's/# CONFIG_STATIC is not set/CONFIG_STATIC=3Dy/' -i .config=0A=
=0A=
sed 's/CONFIG_FEATURE_HAVE_RPC=3Dy/# CONFIG_FEATURE_HAVE_RPC is not set/' \=
=0A=
        -i .config=0A=
sed 's/CONFIG_FEATURE_MOUNT_NFS=3Dy/# CONFIG_FEATURE_MOUNT_NFS is not set/'=
 \=0A=
        -i .config=0A=
sed 's/CONFIG_FEATURE_INETD_RPC=3Dy/# CONFIG_FEATURE_INETD_RPC is not set/'=
 \=0A=
        -i .config=0A=
make=0A=
cp -v busybox /bin=0A=
#------------ Cut and Paste end=0A=
=0A=
=0A=
Step 5) Create ramdisk.=0A=
=0A=
Do this step from inside the LFS chroot environment.   This step=0A=
creates a busybox based ramdisk.   The ramdisk does the work of=0A=
creating and mounting the union filesystem and switching to it=0A=
for the root file system.=0A=
=0A=
#------------ Cut and Paste start=0A=
cd /sources=0A=
echo "Teo En Ming Linux 2020.03 (FINAL) Bootable Live CD/DVD" >id_label=0A=
mkdir -pv mnt_init/{bin,boot}=0A=
cp -v id_label mnt_init/boot=0A=
cp -v /bin/busybox mnt_init/bin=0A=
cp init.sh mnt_init/init=0A=
sed -i "s/<ARCH>/$(uname -m)/g" mnt_init/init=0A=
chmod +x mnt_init/init=0A=
=0A=
pushd mnt_init=0A=
find . | ./bin/busybox cpio -o -H newc -F ../initramfs.cpio=0A=
popd=0A=
gzip -9 initramfs.cpio=0A=
rm -rf mnt_init=0A=
mv initramfs.cpio.gz /boot/initram.fs=0A=
mv id_label /boot=0A=
#------------ Cut and Paste end=0A=
=0A=
=0A=
Step 6) Make a squashed version of your LFS.=0A=
=0A=
   This step should be done on the HOST (not inside chroot).=0A=
=0A=
   Do any needed cleanup and final tweaking of your LFS system prior to =0A=
continuing.  Strip any binaries you want stripped, remove any build cruft, =
=0A=
remove $LFS/tools, etc.   Add any additional data that you would like=0A=
to be present on the live CD/DVD, etc.  A base LFS system (without source) =
turns into only=0A=
a 267 megabyte (or thereabouts) size iso, so there should be plenty of =0A=
space available for extras.=0A=
=0A=
   Exit the chroot and unmount any filesystems that are associated with=0A=
the $LFS directory.   At this point, it is a good idea to do a system =0A=
shutdown and restart to ensure that the LFS directory is unused and=0A=
in a quiescent state.   Make sure LFS is set again after the reboot.=0A=
=0A=
=0A=
#------------ Cut and Paste start=0A=
# Set LFS value as needed...=0A=
export LFS=3D/mnt/lfs=0A=
cd /home/teo-en-ming=0A=
echo $LFS=0A=
rm -f root.sfs=0A=
sudo mksquashfs $LFS root.sfs -comp xz=0A=
#------------ Cut and Paste end=0A=
=0A=
(omit the -comp xz if your squashfs tools don't support xz compression).=0A=
=0A=
=0A=
=0A=
Step 7) Add syslinux and create CD/DVD image.=0A=
=0A=
This step should be done on the HOST (not inside chroot).=0A=
=0A=
Setup the isolinux configuration file:=0A=
=0A=
#------------ Cut and Paste start=0A=
cd /home/teo-en-ming=0A=
=0A=
cat > isolinux.cfg << EOF=0A=
DEFAULT menu.c32=0A=
PROMPT 0=0A=
MENU TITLE Select an option...=0A=
TIMEOUT 300=0A=
=0A=
LABEL live=0A=
    MENU LABEL ^Boot Teo En Ming Linux 2020.03 (FINAL) Live CD/DVD ($(uname=
 -m))=0A=
    MENU DEFAULT=0A=
    KERNEL /boot/$(uname -m)/vmlinuz=0A=
    APPEND initrd=3D/boot/$(uname -m)/initram.fs quiet=0A=
=0A=
LABEL busybox=0A=
    MENU LABEL ^Boot busybox ($(uname -m))=0A=
    KERNEL /boot/$(uname -m)/vmlinuz=0A=
    APPEND initrd=3D/boot/$(uname -m)/initram.fs quiet busybox=0A=
=0A=
LABEL harddisk=0A=
    MENU LABEL Boot from first ^Hard disk=0A=
    LOCALBOOT 0x80=0A=
=0A=
EOF=0A=
#------------ Cut and Paste end=0A=
=0A=
Package the isolinux bootloader, squashed rootfs and ramdisk =0A=
into a subdirectory:=0A=
=0A=
#------------ Cut and Paste start=0A=
tar xf syslinux-4.06.tar.xz=0A=
rm -rf live=0A=
mkdir -p live/boot/{isolinux,$(uname -m)}=0A=
cp -v syslinux-4.06/core/isolinux.bin live/boot/isolinux=0A=
cp -v syslinux-4.06/com32/menu/menu.c32 live/boot/isolinux=0A=
mv -v /home/teo-en-ming/isolinux.cfg                 live/boot/isolinux=0A=
=0A=
cp -v /home/teo-en-ming/root.sfs live/boot/$(uname -m)=0A=
cp -v $LFS/boot/vmlinuz-5.5.7-turritopsis.dohrnii.teo.en.ming   live/boot/$=
(uname -m)/vmlinuz=0A=
cp -v $LFS/boot/id_label live/boot/$(uname -m)=0A=
cp -v $LFS/boot/initram.fs live/boot/$(uname -m)/initram.fs=0A=
=0A=
#------------ Cut and Paste end=0A=
=0A=
Create the live CD/DVD iso image using whatever iso creation tool you=0A=
have.   In this example, it is 'genisoimage':=0A=
=0A=
#------------ Cut and Paste start=0A=
genisoimage -o teo-en-ming-linux-2020.03-final-live-cd-dvd.iso     \=0A=
        -b boot/isolinux/isolinux.bin \=0A=
        -c boot.cat                   \=0A=
        -no-emul-boot                 \=0A=
        -boot-load-size 4             \=0A=
        -boot-info-table              \=0A=
        -joliet -l -R                 \=0A=
        live=0A=
=0A=
rm -rf live ### OPTIONAL=0A=
#------------ Cut and Paste end=0A=
=0A=
Step 8) Burn and boot.=0A=
=0A=
Burn the iso using whatever cd/dvd writing tools you prefer.  =0A=
Teo En Ming uses k3b. Reboot the =0A=
system with the CD/DVD inserted and it should boot into your live CD/DVD.=
=0A=
=0A=
Step 9) Usage=0A=
=0A=
The CD/DVD boot menu allows you to boot busybox or the live cd/dvd.   Busyb=
ox=0A=
may be useful if debugging or experimenting is needed.=0A=
=0A=
You can use the live cd/dvd to inject your LFS image onto the target comput=
er (=0A=
rather than rebuilding from scratch..)   First, mount=0A=
/dev/cdrom somewhere.   In the boot subdirectory in the cd image, you will=
=0A=
find the root.sfs file.   root.sfs is your LFS system in a squashed format.=
=0A=
To install it into the target, either use the unsquashfs tools to =0A=
uncompress it onto the target computer system or loop mount the root.sfs =
=0A=
file and then use tar or some other directory copy tool to inject=0A=
it into the target computer.=0A=
=0A=
    =0A=
=0A=
ACKNOWLEDGEMENTS:=0A=
  * The LFS from script project (http://lfscript.org/wiki/index.php/Main_Pa=
ge)=0A=
  * The LFS project (http://www.linuxfromscratch.org/lfs/)=0A=
=0A=
CHANGELOG:=0A=
[2013-01-20]=0A=
  * Initial hint by Jimmy Anderson.=0A=
[2020-03-14]=0A=
  * Modifications by Turritopsis Dohrnii Teo En Ming, Singapore=0A=
=0A=
ADDENDUM: v Cut and save the remainder of this file as $LFS/sources/init.sh=
 v=0A=
#!/bin/busybox sh=0A=
#=0A=
# This file is a modified version of:=0A=
#=0A=
# Initramfs boot script 1.3.1 (2012-02-09)=0A=
# Copyright (c) 2010-2012   Marcel van den Boer=0A=
#=0A=
# Permission is hereby granted, free of charge, to any person obtaining a c=
opy=0A=
# of this software and associated documentation files (the "Software"), to=
=0A=
# deal in the Software without restriction, including without limitation th=
e=0A=
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/=
or=0A=
# sell copies of the Software, and to permit persons to whom the Software i=
s=0A=
# furnished to do so, subject to the following conditions:=0A=
#=0A=
# The above copyright notice and this permission notice shall be included i=
n=0A=
# all copies or substantial portions of the Software.=0A=
#=0A=
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS O=
R=0A=
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,=
=0A=
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL T=
HE=0A=
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER=0A=
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
=0A=
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS=0A=
# IN THE SOFTWARE.=0A=
=0A=
# FS layout at the start of this script:=0A=
# - /boot/id_label=0A=
# - /bin/busybox=0A=
# - /dev/console (created by kernel)=0A=
# - /init (this file)=0A=
=0A=
set -e=0A=
=0A=
ARCH=3D"<ARCH>"=0A=
=0A=
###########################################=0A=
copyBindMount() { # COPY/BIND LIVECD MODE #=0A=
###########################################=0A=
=0A=
# This function bind-mounts directories which are designed to be capable of=
=0A=
# read-only access and copies the remaining directories to a tmpfs.=0A=
#=0A=
# The downside of this method is that the resulting root filesystem is not=
=0A=
# fully writable. So, for example, installation of new programs will not be=
=0A=
# possible.=0A=
#=0A=
# However, this function can be used without any modification to the kernel=
 and=0A=
# is therefore perfect for use as a fallback if other options are not avail=
able.=0A=
=0A=
# Mount a tmpfs where the new rootfs will be.=0A=
mount -t tmpfs tmpfs ${ROOT} # Allows remounting root in the bootscripts=0A=
=0A=
# Bind mount read-only filesystems, copy the rest=0A=
cd /mnt/system=0A=
for dir in $(ls -1); do=0A=
    case ${dir} in=0A=
        lost+found)=0A=
            ;;=0A=
        bin | boot | lib | opt | sbin | usr)=0A=
            mkdir ${ROOT}/${dir}=0A=
            mount --bind ${dir} ${ROOT}/${dir}=0A=
            ;;=0A=
        *)=0A=
            cp -R ${dir} ${ROOT}=0A=
            ;;=0A=
    esac=0A=
done=0A=
cd /=0A=
=0A=
##############################################=0A=
}; unionMount() { # UNIONFS/AUFS LIVECD MODE #=0A=
##############################################=0A=
=0A=
# A union mount takes one or more directories and combines them transparant=
ly=0A=
# in a third. This function creates a writable directory in memory (tmpfs) =
and=0A=
# uses it to overlay the read-only system image, resulting in a fully writa=
ble=0A=
# root file system.=0A=
#=0A=
# The only downside to this method is that it requires a union type filesys=
tem=0A=
# in the kernel, which can only be accomplished by patching the kernel as t=
here=0A=
# is no such feature in a vanilla kernel.=0A=
=0A=
mkdir -p /mnt/writable=0A=
mount -t tmpfs -o rw tmpfs /mnt/writable=0A=
=0A=
UNIONFSOPT=3D"/mnt/writable=3Drw:/mnt/system=3Dro"=0A=
AUFSOPT=3D"/mnt/writable=3Drw:/mnt/system=3Dro"=0A=
mount -t unionfs -o dirs=3D${UNIONFSOPT} unionfs ${ROOT} 2> /dev/null || \=
=0A=
mount -t aufs -o br=3D${AUFSOPT} none ${ROOT} 2> /dev/null || \=0A=
{=0A=
    # If UnionFS fails, fall back to copy/bind mounting=0A=
    copyBindMount=0A=
}=0A=
=0A=
######################=0A=
} # END OF FUNCTIONS #=0A=
######################=0A=
=0A=
# Make required applets easier to access=0A=
for applet in cat chmod cp cut grep ls mkdir mknod mount umount switch_root=
 \=0A=
    rm mv vi cpio tar mke2fs sync fdisk dd ; do=0A=
    /bin/busybox ln /bin/busybox /bin/${applet}=0A=
done=0A=
=0A=
# Clear the screen=0A=
#clear # Don't! This will clear the Linux boot logo when using a framebuffe=
r.=0A=
       # If you want to clear the screen on boot add the "clear" command to=
=0A=
       # '/usr/share/live/sec_init.sh' in the system image.=0A=
=0A=
# Create device nodes required to run this script=0A=
# Note: /dev/console will already be available in the ramfs=0A=
mknod /dev/null c  1  3=0A=
=0A=
mknod /dev/scd0 b 11  0  # +--------=0A=
mknod /dev/scd1 b 11  1  # |=0A=
mknod /dev/scd2 b 11  2  # |=0A=
mknod /dev/scd3 b 11  3  # |=0A=
                         # |=0A=
mknod /dev/hdc  b 22  0  # |=0A=
                         # |=0A=
mknod /dev/sda  b  8  0  # |=0A=
mknod /dev/sda1 b  8  1  # |=0A=
mknod /dev/sda2 b  8  2  # |=0A=
mknod /dev/sda3 b  8  3  # |=0A=
mknod /dev/sda4 b  8  4  # |=0A=
                         # |=0A=
mknod /dev/sdb  b  8 16  # |    <----=0A=
mknod /dev/sdb1 b  8 17  # |        Devices which could be or contain the=
=0A=
mknod /dev/sdb2 b  8 18  # |        boot medium...=0A=
mknod /dev/sdb3 b  8 19  # |=0A=
mknod /dev/sdb4 b  8 20  # |=0A=
                         # |=0A=
mknod /dev/sdc  b  8 32  # |=0A=
mknod /dev/sdc1 b  8 33  # |=0A=
mknod /dev/sdc2 b  8 34  # |=0A=
mknod /dev/sdc3 b  8 35  # |=0A=
mknod /dev/sdc4 b  8 36  # |=0A=
                         # |=0A=
mknod /dev/sdd  b  8 48  # |=0A=
mknod /dev/sdd1 b  8 49  # |=0A=
mknod /dev/sdd2 b  8 50  # |=0A=
mknod /dev/sdd3 b  8 51  # |=0A=
mknod /dev/sdd4 b  8 52  # +--------=0A=
=0A=
# Create mount points for filesystems=0A=
mkdir -p /mnt/medium=0A=
mkdir -p /mnt/system=0A=
mkdir -p /mnt/rootfs=0A=
=0A=
# Mount the /proc filesystem (enables filesystem detection for 'mount')=0A=
mkdir /proc=0A=
mount -t proc proc /proc=0A=
=0A=
# Invoke busybox if requested via the kernel command line.=0A=
if [ `grep -c "busybox" /proc/cmdline` -ne "0" ]; then =0A=
    echo "Busybox requested"; =0A=
    busybox sh=0A=
fi=0A=
=0A=
# Search for, and mount the boot medium=0A=
LABEL=3D"$(cat /boot/id_label)"=0A=
for device in $(ls /dev); do=0A=
    [ "${device}" =3D=3D "console" ] && continue=0A=
    [ "${device}" =3D=3D "null"    ] && continue=0A=
=0A=
    mount -o ro /dev/${device} /mnt/medium 2> /dev/null && \=0A=
    if [ "$(cat /mnt/medium/boot/${ARCH}/id_label)" !=3D "${LABEL}" ]; then=
=0A=
        umount /mnt/medium=0A=
    else=0A=
        DEVICE=3D"${device}"=0A=
        break=0A=
    fi=0A=
done=0A=
=0A=
if [ "${DEVICE}" =3D=3D "" ]; then=0A=
    echo "FATAL: Boot medium not found."=0A=
    /bin/busybox sh=0A=
fi=0A=
=0A=
# Mount the system image=0A=
mount -t squashfs -o ro,loop /mnt/medium/boot/${ARCH}/root.sfs /mnt/system =
|| {=0A=
    echo "FATAL: Boot medium found, but system image is missing."=0A=
    /bin/busybox sh=0A=
}=0A=
=0A=
# Define where the new root filesystem will be=0A=
ROOT=3D"/mnt/rootfs" # Also needed for /usr/share/live/sec_init.sh=0A=
=0A=
# Run in bootable cd mode if requested via the kernel command line.=0A=
if [ `grep -c "bootcd" /proc/cmdline` -ne "0" ]; then =0A=
    echo "Bootcd mode (bind mount) requested"; =0A=
    copyBindMount=0A=
else=0A=
    # Select LiveCD mode=0A=
    unionMount # Might fall back to copyBindMount=0A=
fi=0A=
=0A=
# Tell LFS to skip fsck during startup:=0A=
> $ROOT/fastboot=0A=
=0A=
# Get rid of / manipulations in mountfs script:=0A=
grep -v ' \/ ' $ROOT/etc/rc.d/init.d/mountfs > $ROOT/tmp/mountfs=0A=
rm -f $ROOT/etc/rc.d/init.d/mountfs=0A=
mv $ROOT/tmp/mountfs $ROOT/etc/rc.d/init.d/mountfs=0A=
chmod +x $ROOT/etc/rc.d/init.d/mountfs=0A=
=0A=
# Move current mounts to directories accessible in the new root=0A=
cd /mnt=0A=
for dir in $(ls -1); do=0A=
    if [ "${dir}" !=3D "rootfs" ]; then=0A=
        mkdir -p ${ROOT}/mnt/.boot/${dir}=0A=
        mount --move /mnt/${dir} ${ROOT}/mnt/.boot/${dir}=0A=
    fi=0A=
done=0A=
cd /=0A=
=0A=
# Run secondary initialization (if the system provides it)=0A=
if [ -x ${ROOT}/usr/share/live/sec_init.sh ]; then=0A=
    . ${ROOT}/usr/share/live/sec_init.sh=0A=
fi=0A=
=0A=
# Clean up=0A=
umount /proc=0A=
=0A=
# Switch to the new root and launch INIT!=0A=
exec switch_root -c /dev/console ${ROOT} /sbin/init=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
-----BEGIN EMAIL SIGNATURE-----=0A=
=0A=
The Gospel for all Targeted Individuals (TIs):=0A=
=0A=
[The New York Times] Microwave Weapons Are Prime Suspect in Ills of=0A=
U.S. Embassy Workers=0A=
=0A=
Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html=0A=
=0A=
***************************************************************************=
*****************=0A=
=0A=
=0A=
=0A=
Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic=0A=
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the United=
 Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 2019) and A=
ustralia (25 Dec 2019 to 9 Jan 2020):=0A=
=0A=
=0A=
[1] https://tdtemcerts.wordpress.com/=0A=
=0A=
[2] https://tdtemcerts.blogspot.sg/=0A=
=0A=
[3] https://www.scribd.com/user/270125049/Teo-En-Ming=0A=
=0A=
-----END EMAIL SIGNATURE-----=0A=
=0A=
=0A=
=0A=
