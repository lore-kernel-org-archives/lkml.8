Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F9BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D17E2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V+Pg235A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgHTPrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:47:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:41485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbgHTPqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597938388;
        bh=zvocH08i6MtUf0HLDjXaePZn6A49ALLiRY3gLkB1JE4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V+Pg235AWZvkb1BrODDVs/v8IGJJSj5heUngs//ufhCcfEZXzSmEbOoxyOGoc5u/Z
         kioRBJ5fFAHx7VLgg1Sc2NKXAFEfILUHhSKRRRxHd/CtbU7oTJVcAjfM/ops/UGs7h
         MfmBIY7Qa4m7DSsG0BtlMWQtACCekmwWButOb8Oc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from obelix.fritz.box ([46.142.24.146]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1kB3wi2Cca-00X5XV; Thu, 20
 Aug 2020 17:46:28 +0200
Subject: Re: BUG with 5.8.x and make xconfig
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <ab0cfaed-50bb-5b29-cb93-a2987c384af1@gmx.de>
 <CAK7LNASZ_sHPjDLd7+LTc0Sj9K+W51zoRq-=r-0_5AJC06jaEg@mail.gmail.com>
From:   Ronald Warsow <rwarsow@gmx.de>
Message-ID: <862c22df-9f9b-67b3-2b98-9109f26aaac8@gmx.de>
Date:   Thu, 20 Aug 2020 17:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNASZ_sHPjDLd7+LTc0Sj9K+W51zoRq-=r-0_5AJC06jaEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0AEr3q7taH9msBXOwragGkMKO/+zBaqPB1xERal1jUBc7FrXniF
 eifQ46TClQhmiCcHQC+42BLRksMfC195Uj2MeZDzN5g4IlHXAHbQj+ZmNCxKZJR10GXGaHT
 DMBu1GPQBX7dq3CbXeE5KWP8EzHYSXRDymHjICNvtaJSYgJAWiVEEoVO8vIidbdzzaj/onJ
 FE72ZpUiLbx9h+liQUwig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zXYF6RrEarE=:roMlipVwjrtEX3D7BNjOu3
 jfQzcxKA05v/5TG8yYCyvKabthRUBEcgfmZbnU6LKlxTlja42pdwncQ1nt0epl/Ht/dzyge7L
 2gNebVzDdUbeDuf5ZO5hTinLXJIfBbJtlGfVuSValmD/IiVlq8MfAZ8fZHhAXQbRvvWWeFcCU
 zlAp1NNSLNbYwfqHu3Ze4xjQvzVSo/6yFyrFWbyA6FEE4cl3bqP6PI+pYRLxbZ5CPt5qBgEUT
 kiBXc5VeRf/sHGi3isXNNvvU5Ub2GTRKGQhPwOKNcSd7O1Sohk2o/BpXIcMaTFxnsbhyGWwxg
 cREyBwWMIm8/+gYm8Lj54ehhfCQv9+Q1+NsTv1U46pqQbhyRfwKPyhz8wp9R9gg4yoJsCGWHY
 tp2rGz2/INUIqd3FZ2rW3KTQTuGfYBCD9xjb2N918MetHy8TBss1Ul4e9WyOPoVWE0rdYprD7
 QGfIXSyi3gHZLblr+OGzd9nlt5rMeijx9pVrNAp3EZccsjjo0CmI3OQz9P/3WfHDQHyV84mWO
 BgtSPWITgHtR36XW0FfE/GVjKHDrvY+x8fgb4ktpbvsabHsf3mJEVQG6CzeLsp3P3anvjZa+u
 Gre3jn7PzBkB9KmaKK3IZ8OWuhcOIc6FEPaJjfSpoOw9Z8ESxx+Z0X32P4YRn8Lu9Ov0if+v+
 8NiFYgmWNDx1YLWueI37kRXwXIgv1DVhhEQxzsf1/MbhevgQyamEC07q4qMVBjEEAzP6/P7K+
 R1ukDQewzkJ0DITtXWzdh0rAcT2slW8gLftBzltCfyF93hDY/QHIeB6cgkf4S7R3VYpwx9D5P
 bWRuUL2G1/HygMT5+wl9i2rYgXAhX62mKX8lX9bJjJG0e/1lwqSmyasfh3B0a/WVY2ESnlwAv
 rjByBgDNykdIQABKASBBmyVHhK/7zOAdKW38PFyBO9QXmyjwdvxZbS0h5sq/0etPyjXnjnYzt
 8sy032MFl5Roj8UVpAmemLoP7oxtqf6OgyKYMhEyirerHpfsOUEeEabgsSoT5jZe9uZ6FYbt6
 OHTfBaylacarwEq2tgBTVIPS+TkjJJ42kDkgnpPGl/hTifvXkgSBS9A+OZOj6gDhEGNBlzwKV
 Y/q6M9DjGI8PpFNYYHvugHxd/36umn7Kp49bYgfX4uBsTi8LYuvUX7rYV14qwsVuOlO/rJ7G3
 /dRjzdysvJFxRcD501Ws9GjoWSj+4eY3nNLfidUA/ItpXTms18Cgeim3MbfuR0Ad+Gj7GWOKI
 JzhAIgEMD/RzJEOtY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.20 13:33, Masahiro Yamada wrote:
> On Thu, Aug 20, 2020 at 4:19 AM Ronald Warsow <rwarsow@gmx.de> wrote:
>>
...
>
>
> I think you are using Qt4
> (dnf install qt4-devel).

no, there is no qt4-devel in the Fedora repos:

rpm -qa|grep -i qt4

adwaita-qt4-1.1.3-2.fc32.x86_64



all qt relative currently installed, is this:

rpm -qa|grep -i qt|sort:


adwaita-qt4-1.1.3-2.fc32.x86_64
adwaita-qt5-1.1.3-2.fc32.x86_64
dbusmenu-qt-0.9.3-0.22.20160218.fc32.x86_64
gstreamer1-plugins-good-qt-1.16.2-2.fc32.x86_64
ibus-qt-1.3.3-24.fc32.x86_64
qt-4.8.7-55.fc32.x86_64
qt5-qtbase-5.14.2-5.fc32.x86_64
qt5-qtbase-common-5.14.2-5.fc32.noarch
qt5-qtbase-gui-5.14.2-5.fc32.x86_64
qt5-qtdeclarative-5.14.2-1.fc32.x86_64
qt5-qtmultimedia-5.14.2-1.fc32.x86_64
qt5-qtsvg-5.14.2-1.fc32.x86_64
qt5-qtwayland-5.14.2-4.fc32.x86_64
qt5-qtx11extras-5.14.2-1.fc32.x86_64
qt5-qtxmlpatterns-5.14.2-1.fc32.x86_64
qt5-srpm-macros-5.14.2-3.fc32.noarch
qt-common-4.8.7-55.fc32.noarch
qt-devel-4.8.7-55.fc32.x86_64
qt-settings-32.0-3.fc32.noarch
qt-x11-4.8.7-55.fc32.x86_64
quazip-qt5-0.7.6-6.fc32.x86_64
sni-qt-0.2.7-0.4.20170217.fc32.x86_64


>
> If you install Qt5
> (dnf install qt5-devel),
> you will be able to do "make xconfig".

so I did dnf install qt5-devel


make xconfig runs now, but it gives:


  UPD     scripts/kconfig/qconf-cfg
   HOSTCXX scripts/kconfig/qconf.o
scripts/kconfig/qconf.cc: In member function =E2=80=98void
ConfigInfoView::menuInfo()=E2=80=99:
scripts/kconfig/qconf.cc:1080:61: warning: =E2=80=98QString&
QString::sprintf(const char*, ...)=E2=80=99 is deprecated: Use asprintf(),=
 arg()
or QTextStream instead [-Wdeprecated-declarations]
  1080 |      head +=3D QString().sprintf("<a href=3D\"s%s\">", sym->name)=
;
       |                                                             ^
In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
                  from /usr/include/qt5/QtWidgets/qaction.h:44,
                  from /usr/include/qt5/QtWidgets/QAction:1,
                  from scripts/kconfig/qconf.cc:7:
/usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
   382 |     QString &sprintf(const char *format, ...)
Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
       |              ^~~~~~~
scripts/kconfig/qconf.cc:1089:60: warning: =E2=80=98QString&
QString::sprintf(const char*, ...)=E2=80=99 is deprecated: Use asprintf(),=
 arg()
or QTextStream instead [-Wdeprecated-declarations]
  1089 |     head +=3D QString().sprintf("<a href=3D\"s%s\">", sym->name);
       |                                                            ^
In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
                  from /usr/include/qt5/QtWidgets/qaction.h:44,
                  from /usr/include/qt5/QtWidgets/QAction:1,
                  from scripts/kconfig/qconf.cc:7:
/usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
   382 |     QString &sprintf(const char *format, ...)
Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
       |              ^~~~~~~
scripts/kconfig/qconf.cc:1117:90: warning: =E2=80=98QString&
QString::sprintf(const char*, ...)=E2=80=99 is deprecated: Use asprintf(),=
 arg()
or QTextStream instead [-Wdeprecated-declarations]
  1117 |   debug +=3D QString().sprintf("defined at %s:%d<br><br>",
_menu->file->name, _menu->lineno);
       |
                          ^
In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
                  from /usr/include/qt5/QtWidgets/qaction.h:44,
                  from /usr/include/qt5/QtWidgets/QAction:1,
                  from scripts/kconfig/qconf.cc:7:
/usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
   382 |     QString &sprintf(const char *format, ...)
Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
       |              ^~~~~~~
scripts/kconfig/qconf.cc: In member function =E2=80=98QString
ConfigInfoView::debug_info(symbol*)=E2=80=99:
scripts/kconfig/qconf.cc:1140:68: warning: =E2=80=98QString&
QString::sprintf(const char*, ...)=E2=80=99 is deprecated: Use asprintf(),=
 arg()
or QTextStream instead [-Wdeprecated-declarations]
  1140 |    debug +=3D QString().sprintf("prompt: <a href=3D\"m%s\">",
sym->name);
       |
    ^
In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
                  from /usr/include/qt5/QtWidgets/qaction.h:44,
                  from /usr/include/qt5/QtWidgets/QAction:1,
                  from scripts/kconfig/qconf.cc:7:
/usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
   382 |     QString &sprintf(const char *format, ...)
Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
       |              ^~~~~~~
scripts/kconfig/qconf.cc: In static member function =E2=80=98static void
ConfigInfoView::expr_print_help(void*, symbol*, const char*)=E2=80=99:
scripts/kconfig/qconf.cc:1215:59: warning: =E2=80=98QString&
QString::sprintf(const char*, ...)=E2=80=99 is deprecated: Use asprintf(),=
 arg()
or QTextStream instead [-Wdeprecated-declarations]
  1215 |   *text +=3D QString().sprintf("<a href=3D\"s%s\">", sym->name);
       |                                                           ^
In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
                  from /usr/include/qt5/QtWidgets/qaction.h:44,
                  from /usr/include/qt5/QtWidgets/QAction:1,
                  from scripts/kconfig/qconf.cc:7:
/usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
   382 |     QString &sprintf(const char *format, ...)
Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
       |              ^~~~~~~
   MOC     scripts/kconfig/qconf-moc.cc
   HOSTCXX scripts/kconfig/qconf-moc.o
   HOSTLD  scripts/kconfig/qconf
scripts/kconfig/qconf  Kconfig




>
> I will consider what to do about this.
>


thanks Masahiro.


=2D-
regards

Ronald
