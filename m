Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B79FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F241B20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597943771;
	bh=N34A3WHgp/cGJppu76y/fV1cYMbgEKPnB/x2sH/YlPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mN/uhFvoYOQLQOVuAR1iBHv2yd5foS2qhsscfwxTlRxLr4QKsz0rGrdq5Y1VotlNq
	 2oxwOoN3Xj5WBYSVAld0+EvVZa566dvTbNqDcSBOmbXMTsKpUPSLDteI/fGevVGi7H
	 mx6vUqFApr1mgVYT0hPwAoOQ/GJgeB9e1AGa9PB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgHTRQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:16:09 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:42526 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbgHTRP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:15:57 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 07KHFYgU016191
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:15:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 07KHFYgU016191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597943735;
        bh=1fYHm0YHOhT0oGAQUSQ3+S430Paub2ULALUKT/hTGq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v9w7CpA897r+4w0rNr509t6ri5LTckKSNL5sV63maluPu7hUGkpWJ09PRw+UkcxCN
         hDrU+HQbPjZYWrPXv1GgUsNRxjL/wJxsNo15dYfgICpUPN4UbGGmE4JdvZ6h0zj+x0
         lYesyuVP6LtbFmev0KfQEiAP+T+nMPykvsHYvHrRAcn+xCDhxL6wgZ4Kl3CYWx9d5U
         bYFioOq2t1oDqWpKAps9/iw83X+2xNEoIzEdoSDTf5rtY2Up5QxTz0wjfdomjwIDzQ
         1lKw8zXcg8igYERtlFaVvbsY/gYKVL46wFuwhU0ycCfpvJtxYy7CuHbqJ2/d+ncpFo
         PklRD5XA7UP6A==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id n4so1458232vsl.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:15:34 -0700 (PDT)
X-Gm-Message-State: AOAM5305DOW4mYplkQAeV34uI4Es9J5o4zMxISWfPPol+HW8RJLpFxPK
        9Klv21aVEW9cVFKpkCfnaIz2+x5A90OlwyIXu6s=
X-Google-Smtp-Source: ABdhPJz4/R9ocC0kFhrBj/avtkq11h1Sr+K0UjOyUSEz6G3s7gUm6ITOFshoMn0ZDLj7pjAQ4jcHpNBPxgcY6jRXzYc=
X-Received: by 2002:a67:7905:: with SMTP id u5mr2801892vsc.179.1597943733158;
 Thu, 20 Aug 2020 10:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <ab0cfaed-50bb-5b29-cb93-a2987c384af1@gmx.de> <CAK7LNASZ_sHPjDLd7+LTc0Sj9K+W51zoRq-=r-0_5AJC06jaEg@mail.gmail.com>
 <862c22df-9f9b-67b3-2b98-9109f26aaac8@gmx.de>
In-Reply-To: <862c22df-9f9b-67b3-2b98-9109f26aaac8@gmx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Aug 2020 02:14:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3ZfuJTbJin8D7ksU0PxyUcLonuywMUAeAXj+h5xzifw@mail.gmail.com>
Message-ID: <CAK7LNAQ3ZfuJTbJin8D7ksU0PxyUcLonuywMUAeAXj+h5xzifw@mail.gmail.com>
Subject: Re: BUG with 5.8.x and make xconfig
To:     Ronald Warsow <rwarsow@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:46 AM Ronald Warsow <rwarsow@gmx.de> wrote:
>
> On 20.08.20 13:33, Masahiro Yamada wrote:
> > On Thu, Aug 20, 2020 at 4:19 AM Ronald Warsow <rwarsow@gmx.de> wrote:
> >>
> ...
> >
> >
> > I think you are using Qt4
> > (dnf install qt4-devel).
>
> no, there is no qt4-devel in the Fedora repos:
>
> rpm -qa|grep -i qt4
>
> adwaita-qt4-1.1.3-2.fc32.x86_64
>
>
>
> all qt relative currently installed, is this:
>
> rpm -qa|grep -i qt|sort:
>
>
> adwaita-qt4-1.1.3-2.fc32.x86_64
> adwaita-qt5-1.1.3-2.fc32.x86_64
> dbusmenu-qt-0.9.3-0.22.20160218.fc32.x86_64
> gstreamer1-plugins-good-qt-1.16.2-2.fc32.x86_64
> ibus-qt-1.3.3-24.fc32.x86_64
> qt-4.8.7-55.fc32.x86_64
> qt5-qtbase-5.14.2-5.fc32.x86_64
> qt5-qtbase-common-5.14.2-5.fc32.noarch
> qt5-qtbase-gui-5.14.2-5.fc32.x86_64
> qt5-qtdeclarative-5.14.2-1.fc32.x86_64
> qt5-qtmultimedia-5.14.2-1.fc32.x86_64
> qt5-qtsvg-5.14.2-1.fc32.x86_64
> qt5-qtwayland-5.14.2-4.fc32.x86_64
> qt5-qtx11extras-5.14.2-1.fc32.x86_64
> qt5-qtxmlpatterns-5.14.2-1.fc32.x86_64
> qt5-srpm-macros-5.14.2-3.fc32.noarch
> qt-common-4.8.7-55.fc32.noarch
> qt-devel-4.8.7-55.fc32.x86_64

This one is the Qt4 development package.



[masahiro@10484ea7d17a ~]$ dnf info qt-devel
Last metadata expiration check: 0:00:21 ago on Thu Aug 20 17:12:44 2020.
Available Packages
Name         : qt-devel
Epoch        : 1
Version      : 4.8.7
Release      : 55.fc32
Architecture : i686
Size         : 10 M
Source       : qt-4.8.7-55.fc32.src.rpm
Repository   : updates
Summary      : Development files for the Qt toolkit
URL          : http://qt-project.org/
License      : (LGPLv2 with exceptions or GPLv3 with exceptions) and
ASL 2.0 and BSD and FTL and MIT
Description  : This package contains the files necessary to develop
             : applications using the Qt toolkit.  Includes:
             : Qt Linguist

Name         : qt-devel
Epoch        : 1
Version      : 4.8.7
Release      : 55.fc32
Architecture : x86_64
Size         : 9.8 M
Source       : qt-4.8.7-55.fc32.src.rpm
Repository   : updates
Summary      : Development files for the Qt toolkit
URL          : http://qt-project.org/
License      : (LGPLv2 with exceptions or GPLv3 with exceptions) and
ASL 2.0 and BSD and FTL and MIT
Description  : This package contains the files necessary to develop
             : applications using the Qt toolkit.  Includes:
             : Qt Linguist








I do not know why, but both
"dnf install qt-devel" and
"dnf install qt4-devel"
works equivalently.

"dnf install qt4-devel" installs the qt-devel package.





The result in the docker:


[root@10484ea7d17a masahiro]# dnf install qt4-devel
Fedora 32 openh264 (From Cisco) - x86_64
          756  B/s | 986  B     00:01
Fedora Modular 32 - x86_64
          5.1 kB/s | 6.0 kB     00:01
Fedora Modular 32 - x86_64 - Updates
          5.8 kB/s | 4.1 kB     00:00
Fedora Modular 32 - x86_64 - Updates
          2.5 MB/s | 3.5 MB     00:01
Fedora 32 - x86_64 - Updates
           13 kB/s |  17 kB     00:01
Fedora 32 - x86_64 - Updates
          2.1 MB/s |  21 MB     00:10
Fedora 32 - x86_64
           10 kB/s | 6.1 kB     00:00
Dependencies resolved.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Package                               Architecture    Version
                   Repository        Size
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Installing:
 qt-devel                              x86_64          1:4.8.7-55.fc32
                   updates          9.8 M
Installing dependencies:
 alsa-lib                              x86_64          1.2.3.2-1.fc32
                   updates          474 k
 bzip2-devel                           x86_64          1.0.8-2.fc32
                   fedora           214 k
 dbusmenu-qt                           x86_64
0.9.3-0.22.20160218.fc32           fedora            85 k
 dejavu-sans-fonts                     noarch          2.37-8.fc32
                   updates          1.3 M
 expat-devel                           x86_64          2.2.8-2.fc32
                   fedora            47 k
 fontconfig                            x86_64          2.13.92-9.fc32
                   updates          265 k
 fontconfig-devel                      x86_64          2.13.92-9.fc32
                   updates          129 k
 fonts-filesystem                      noarch          2.0.3-1.fc32
                   fedora           7.8 k
 freetype                              x86_64          2.10.2-1.fc32
                   updates          391 k
 freetype-devel                        x86_64          2.10.2-1.fc32
                   updates          1.1 M
 gettext                               x86_64          0.21-1.fc32
                   updates          1.1 M
 gettext-libs                          x86_64          0.21-1.fc32
                   updates          304 k
 gl-manpages                           noarch
1.1-20.20190306.fc32               fedora           1.0 M
 hwdata                                noarch          0.338-1.fc32
                   updates          1.4 M
 jbigkit-libs                          x86_64          2.1-18.fc32
                   fedora            53 k
 langpacks-core-font-en                noarch          3.0-3.fc32
                   fedora           9.4 k
 lcms2                                 x86_64          2.9-7.fc32
                   fedora           167 k
 libICE                                x86_64          1.0.10-3.fc32
                   fedora            71 k
 libICE-devel                          x86_64          1.0.10-3.fc32
                   fedora            46 k
 libSM                                 x86_64          1.2.3-5.fc32
                   fedora            42 k
 libSM-devel                           x86_64          1.2.3-5.fc32
                   fedora            12 k
 libX11                                x86_64          1.6.9-3.fc32
                   fedora           660 k
 libX11-common                         noarch          1.6.9-3.fc32
                   fedora           153 k
 libX11-devel                          x86_64          1.6.9-3.fc32
                   fedora           938 k
 libX11-xcb                            x86_64          1.6.9-3.fc32
                   fedora            11 k
 libXau                                x86_64          1.0.9-3.fc32
                   fedora            31 k
 libXau-devel                          x86_64          1.0.9-3.fc32
                   fedora            14 k
 libXcursor                            x86_64          1.2.0-2.fc32
                   fedora            30 k
 libXcursor-devel                      x86_64          1.2.0-2.fc32
                   fedora            22 k
 libXdamage                            x86_64          1.1.5-2.fc32
                   fedora            22 k
 libXext                               x86_64          1.3.4-3.fc32
                   fedora            39 k
 libXext-devel                         x86_64          1.3.4-3.fc32
                   fedora            73 k
 libXfixes                             x86_64          5.0.3-11.fc32
                   fedora            19 k
 libXfixes-devel                       x86_64          5.0.3-11.fc32
                   fedora            12 k
 libXft                                x86_64          2.3.3-3.fc32
                   fedora            64 k
 libXft-devel                          x86_64          2.3.3-3.fc32
                   fedora            18 k
 libXi                                 x86_64          1.7.10-3.fc32
                   fedora            38 k
 libXi-devel                           x86_64          1.7.10-3.fc32
                   fedora           100 k
 libXinerama                           x86_64          1.1.4-5.fc32
                   fedora            14 k
 libXinerama-devel                     x86_64          1.1.4-5.fc32
                   fedora            13 k
 libXrandr                             x86_64          1.5.2-3.fc32
                   fedora            27 k
 libXrandr-devel                       x86_64          1.5.2-3.fc32
                   fedora            19 k
 libXrender                            x86_64          0.9.10-11.fc32
                   fedora            27 k
 libXrender-devel                      x86_64          0.9.10-11.fc32
                   fedora            16 k
 libXt                                 x86_64          1.2.0-1.fc32
                   fedora           183 k
 libXt-devel                           x86_64          1.2.0-1.fc32
                   fedora           408 k
 libXv                                 x86_64          1.0.11-11.fc32
                   fedora            18 k
 libXv-devel                           x86_64          1.0.11-11.fc32
                   fedora            39 k
 libXxf86vm                            x86_64          1.1.4-13.fc32
                   fedora            18 k
 libdrm                                x86_64          2.4.102-1.fc32
                   updates          159 k
 libglvnd                              x86_64          1:1.3.1-1.fc32
                   fedora           148 k
 libglvnd-core-devel                   x86_64          1:1.3.1-1.fc32
                   fedora            19 k
 libglvnd-devel                        x86_64          1:1.3.1-1.fc32
                   fedora           156 k
 libglvnd-egl                          x86_64          1:1.3.1-1.fc32
                   fedora            46 k
 libglvnd-gles                         x86_64          1:1.3.1-1.fc32
                   fedora            36 k
 libglvnd-glx                          x86_64          1:1.3.1-1.fc32
                   fedora           160 k
 libglvnd-opengl                       x86_64          1:1.3.1-1.fc32
                   fedora            49 k
 libjpeg-turbo                         x86_64          2.0.4-3.fc32
                   updates          168 k
 libmng                                x86_64          2.0.3-11.fc32
                   fedora           188 k
 libpciaccess                          x86_64          0.16-2.fc32
                   fedora            27 k
 libpng                                x86_64          2:1.6.37-3.fc32
                   fedora           116 k
 libpng-devel                          x86_64          2:1.6.37-3.fc32
                   fedora           291 k
 libtextstyle                          x86_64          0.21-1.fc32
                   updates          124 k
 libtiff                               x86_64          4.1.0-2.fc32
                   fedora           185 k
 libwayland-client                     x86_64          1.18.0-1.fc32
                   fedora            35 k
 libwayland-server                     x86_64          1.18.0-1.fc32
                   fedora            43 k
 libxcb                                x86_64          1.13.1-4.fc32
                   fedora           231 k
 libxcb-devel                          x86_64          1.13.1-4.fc32
                   fedora           1.0 M
 libxshmfence                          x86_64          1.3-6.fc32
                   fedora            12 k
 mesa-libEGL                           x86_64          20.1.5-1.fc32
                   updates          126 k
 mesa-libGL                            x86_64          20.1.5-1.fc32
                   updates          184 k
 mesa-libGLU                           x86_64          9.0.1-2.fc32
                   fedora           190 k
 mesa-libGLU-devel                     x86_64          9.0.1-2.fc32
                   fedora            13 k
 mesa-libgbm                           x86_64          20.1.5-1.fc32
                   updates           46 k
 mesa-libglapi                         x86_64          20.1.5-1.fc32
                   updates           58 k
 qt                                    x86_64          1:4.8.7-55.fc32
                   updates          4.7 M
 qt-common                             noarch          1:4.8.7-55.fc32
                   updates          6.6 k
 qt-settings                           noarch          32.0-3.fc32
                   fedora           9.3 k
 qt-x11                                x86_64          1:4.8.7-55.fc32
                   updates           13 M
 xorg-x11-proto-devel                  noarch          2019.1-3.fc32
                   fedora           262 k
Installing weak dependencies:
 compat-f32-dejavu-sans-fonts          noarch          2.37-8.fc32
                   updates          8.5 k
 sni-qt                                x86_64
0.2.7-0.4.20170217.fc32            fedora            61 k

Transaction Summary
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Install  83 Packages

Total download size: 43 M
Installed size: 144 M
Is this ok [y/N]:





> qt-settings-32.0-3.fc32.noarch
> qt-x11-4.8.7-55.fc32.x86_64
> quazip-qt5-0.7.6-6.fc32.x86_64
> sni-qt-0.2.7-0.4.20170217.fc32.x86_64
>
>
> >
> > If you install Qt5
> > (dnf install qt5-devel),
> > you will be able to do "make xconfig".
>
> so I did dnf install qt5-devel
>
>
> make xconfig runs now, but it gives:
>
>
>   UPD     scripts/kconfig/qconf-cfg
>    HOSTCXX scripts/kconfig/qconf.o
> scripts/kconfig/qconf.cc: In member function =E2=80=98void
> ConfigInfoView::menuInfo()=E2=80=99:
> scripts/kconfig/qconf.cc:1080:61: warning: =E2=80=98QString&
> QString::sprintf(const char*, ...)=E2=80=99 is deprecated: Use asprintf()=
, arg()
> or QTextStream instead [-Wdeprecated-declarations]
>   1080 |      head +=3D QString().sprintf("<a href=3D\"s%s\">", sym->name=
);
>        |                                                             ^
> In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
>                   from /usr/include/qt5/QtWidgets/qaction.h:44,
>                   from /usr/include/qt5/QtWidgets/QAction:1,
>                   from scripts/kconfig/qconf.cc:7:
> /usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
>    382 |     QString &sprintf(const char *format, ...)
> Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
>        |              ^~~~~~~
> scripts/kconfig/qconf.cc:1089:60: warning: =E2=80=98QString&
> QString::sprintf(const char*, ...)=E2=80=99 is deprecated: Use asprintf()=
, arg()
> or QTextStream instead [-Wdeprecated-declarations]
>   1089 |     head +=3D QString().sprintf("<a href=3D\"s%s\">", sym->name)=
;
>        |                                                            ^
> In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
>                   from /usr/include/qt5/QtWidgets/qaction.h:44,
>                   from /usr/include/qt5/QtWidgets/QAction:1,
>                   from scripts/kconfig/qconf.cc:7:
> /usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
>    382 |     QString &sprintf(const char *format, ...)
> Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
>        |              ^~~~~~~
> scripts/kconfig/qconf.cc:1117:90: warning: =E2=80=98QString&
> QString::sprintf(const char*, ...)=E2=80=99 is deprecated: Use asprintf()=
, arg()
> or QTextStream instead [-Wdeprecated-declarations]
>   1117 |   debug +=3D QString().sprintf("defined at %s:%d<br><br>",
> _menu->file->name, _menu->lineno);
>        |
>                           ^
> In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
>                   from /usr/include/qt5/QtWidgets/qaction.h:44,
>                   from /usr/include/qt5/QtWidgets/QAction:1,
>                   from scripts/kconfig/qconf.cc:7:
> /usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
>    382 |     QString &sprintf(const char *format, ...)
> Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
>        |              ^~~~~~~
> scripts/kconfig/qconf.cc: In member function =E2=80=98QString
> ConfigInfoView::debug_info(symbol*)=E2=80=99:
> scripts/kconfig/qconf.cc:1140:68: warning: =E2=80=98QString&
> QString::sprintf(const char*, ...)=E2=80=99 is deprecated: Use asprintf()=
, arg()
> or QTextStream instead [-Wdeprecated-declarations]
>   1140 |    debug +=3D QString().sprintf("prompt: <a href=3D\"m%s\">",
> sym->name);
>        |
>     ^
> In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
>                   from /usr/include/qt5/QtWidgets/qaction.h:44,
>                   from /usr/include/qt5/QtWidgets/QAction:1,
>                   from scripts/kconfig/qconf.cc:7:
> /usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
>    382 |     QString &sprintf(const char *format, ...)
> Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
>        |              ^~~~~~~
> scripts/kconfig/qconf.cc: In static member function =E2=80=98static void
> ConfigInfoView::expr_print_help(void*, symbol*, const char*)=E2=80=99:
> scripts/kconfig/qconf.cc:1215:59: warning: =E2=80=98QString&
> QString::sprintf(const char*, ...)=E2=80=99 is deprecated: Use asprintf()=
, arg()
> or QTextStream instead [-Wdeprecated-declarations]
>   1215 |   *text +=3D QString().sprintf("<a href=3D\"s%s\">", sym->name);
>        |                                                           ^
> In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
>                   from /usr/include/qt5/QtWidgets/qaction.h:44,
>                   from /usr/include/qt5/QtWidgets/QAction:1,
>                   from scripts/kconfig/qconf.cc:7:
> /usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
>    382 |     QString &sprintf(const char *format, ...)
> Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
>        |              ^~~~~~~
>    MOC     scripts/kconfig/qconf-moc.cc
>    HOSTCXX scripts/kconfig/qconf-moc.o
>    HOSTLD  scripts/kconfig/qconf
> scripts/kconfig/qconf  Kconfig


I know, this was reported by somebody else before.


I will fix this too.



--=20
Best Regards
Masahiro Yamada
