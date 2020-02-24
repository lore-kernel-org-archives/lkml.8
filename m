Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F28C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CA7206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaSIrPgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgBXBhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:37:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34825 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgBXBhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:37:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id c7so10015659edu.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 17:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=u+oray2bgOt7e+taME/KMpY4sGXSbSggtlYDfHrOmh4=;
        b=EaSIrPgRZB9n3t9NNRqAFnEzdW+2UEREmcSBRO95Bc3auBZyhN4baEIvvBKAYA4PtJ
         qIvSl5wL+/p3yUpQhRhzRtT8Ciht0NX51Jl1vpg9W/VFDOyYwW7zVaB4nbZ0GWiXG+qX
         7wJZFRezrZXQnlwuYrQlM+L5A3fTP7Ozpn8R/FWb0DGnXTfLNi8zRL/4wyp32ds5NxUj
         0YO5PZNM93K67eP9pyy9rFwfLMKK5v7Rxdihss5eEnq/DXG14KkynS9vLkbi6boZXOEr
         jbBD+05yBH4m7RlbFazZUGT4NgaPoaJ4T4+RZeSN5FKXu/htTz8QO6RsFJR/+q6UY5xp
         W/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=u+oray2bgOt7e+taME/KMpY4sGXSbSggtlYDfHrOmh4=;
        b=kRQfhw92jdfgIX0XNlvOBkgtYTDfx2bqM2izYINt/jygnLen2vFGmpSHPa+W0Ru1SM
         yWzEycpU/lft4fxyNGhRRU2EfiN4QiPCTeVJmwAw2mJuY1yQMx2MFG+TtbJGYPV1kviK
         3wyxx3ABjxdFN+kjIonZeCQqZpWm9WcfJRh1nMa+SufyQeWR6alqK/nkqbmpx+/vMnTl
         xqTvuul+gGZlUUE2uEddVbSG2q56s+ZiBZBPJW2BVvDJaRPpnQB2d4MIufXZmCsk63HC
         UdLtvLD0/eJqkVxiwUfrS7BDw9ugl4c+H4gVrAdYQ9H+TeIjGttydvIdAq2yELct6zRP
         +UpQ==
X-Gm-Message-State: APjAAAXEmB05gSZRyH18ej+2R3CrKzJJkuX+Wwg/npVteAkj37VR7729
        nwaSfU/hMZ/Ow61M+U+7wzIi2u6UlkWd/oha+Vtu2Gh2
X-Google-Smtp-Source: APXvYqzKVAxjI4Qv/cWzWSPke9snBElsIO88Etx07b0LnQnFzTWLq3aDyS25m2f89DnnE/Lcb87xJ7/JNJxKf01iVXg=
X-Received: by 2002:a17:906:535d:: with SMTP id j29mr44402472ejo.230.1582508263826;
 Sun, 23 Feb 2020 17:37:43 -0800 (PST)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Sun, 23 Feb 2020 17:37:33 -0800
Message-ID: <CAGRSmLsyDeKgkmsFXYRZVkkHawfZjw63uUs=zWQv=smLgB+5Eg@mail.gmail.com>
Subject: BUG: Compile Fail 5.4 x64 version.
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tried to build updates for the x86 and x64 versions of kernel.  The
x86 built, the x64 didn't.  But x64 includes more devices and items.
Here is the screen output of the failure:

 CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/pci.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt7615/mac.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.o
In file included from ./include/linux/export.h:42:0,
                 from ./include/linux/linkage.h:7,
                 from ./include/linux/kernel.h:8,
                 from ./include/linux/skbuff.h:13,
                 from ./include/linux/if_ether.h:19,
                 from ./include/linux/etherdevice.h:20,
                 from drivers/net/wireless/mediatek/mt76/mt7615/mac.c:10:
drivers/net/wireless/mediatek/mt76/mt7615/mac.c: In function =E2=80=98to_rs=
si=E2=80=99:
./include/linux/compiler.h:350:38: error: call to
=E2=80=98__compiletime_assert_18=E2=80=99 declared with attribute error: BU=
ILD_BUG_ON
failed: (((field) + (1ULL << (__builtin_ffsll(field) - 1))) &
(((field) + (1ULL << (__builtin_ffsll(field) - 1))) - 1)) !=3D 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:331:4: note: in definition of macro
=E2=80=98__compiletime_assert=E2=80=99
    prefix ## suffix();    \
    ^
./include/linux/compiler.h:350:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
./include/linux/bitfield.h:46:3: note: in expansion of macro =E2=80=98BUILD=
_BUG_ON_MSG=E2=80=99
   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
   ^
./include/linux/bitfield.h:95:3: note: in expansion of macro =E2=80=98__BF_=
FIELD_CHECK=E2=80=99
   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
   ^
drivers/net/wireless/mediatek/mt76/mt7615/mac.c:18:10: note: in
expansion of macro =E2=80=98FIELD_GET=E2=80=99
  return (FIELD_GET(field, rxv) - 220) / 2;
          ^
./include/linux/compiler.h:350:38: error: call to
=E2=80=98__compiletime_assert_18=E2=80=99 declared with attribute error: BU=
ILD_BUG_ON
failed: (((field) + (1ULL << (__builtin_ffsll(field) - 1))) &
(((field) + (1ULL << (__builtin_ffsll(field) - 1))) - 1)) !=3D 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:331:4: note: in definition of macro
=E2=80=98__compiletime_assert=E2=80=99
    prefix ## suffix();    \
    ^
./include/linux/compiler.h:350:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
./include/linux/bitfield.h:48:3: note: in expansion of macro =E2=80=98BUILD=
_BUG_ON_MSG=E2=80=99
   BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is zero"); \
   ^
./include/linux/bitfield.h:95:3: note: in expansion of macro =E2=80=98__BF_=
FIELD_CHECK=E2=80=99
   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
   ^
drivers/net/wireless/mediatek/mt76/mt7615/mac.c:18:10: note: in
expansion of macro =E2=80=98FIELD_GET=E2=80=99
  return (FIELD_GET(field, rxv) - 220) / 2;
          ^
./include/linux/compiler.h:350:38: error: call to
=E2=80=98__compiletime_assert_18=E2=80=99 declared with attribute error: BU=
ILD_BUG_ON
failed: (((field) + (1ULL << (__builtin_ffsll(field) - 1))) &
(((field) + (1ULL << (__builtin_ffsll(field) - 1))) - 1)) !=3D 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:331:4: note: in definition of macro
=E2=80=98__compiletime_assert=E2=80=99
    prefix ## suffix();    \
    ^
./include/linux/compiler.h:350:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
./include/linux/build_bug.h:50:2: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON_MSG=E2=80=99
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^
./include/linux/build_bug.h:21:2: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON=E2=80=99
  BUILD_BUG_ON(((n) & ((n) - 1)) !=3D 0)
  ^
./include/linux/bitfield.h:54:3: note: in expansion of macro
=E2=80=98__BUILD_BUG_ON_NOT_POWER_OF_2=E2=80=99
   __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +   \
   ^
./include/linux/bitfield.h:95:3: note: in expansion of macro =E2=80=98__BF_=
FIELD_CHECK=E2=80=99
   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
   ^
drivers/net/wireless/mediatek/mt76/mt7615/mac.c:18:10: note: in
expansion of macro =E2=80=98FIELD_GET=E2=80=99
  return (FIELD_GET(field, rxv) - 220) / 2;
          ^
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/init.o
scripts/Makefile.build:265: recipe for target
'drivers/net/wireless/mediatek/mt76/mt7615/mac.o' failed
make[9]: *** [drivers/net/wireless/mediatek/mt76/mt7615/mac.o] Error 1
scripts/Makefile.build:509: recipe for target
'drivers/net/wireless/mediatek/mt76/mt7615' failed
make[8]: *** [drivers/net/wireless/mediatek/mt76/mt7615] Error 2
make[8]: *** Waiting for unfinished jobs....
  AR      drivers/net/wireless/mediatek/built-in.a
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/main.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/phy.o
  LD [M]  drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0u.o
  LD [M]  drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0e.o
  CC      drivers/ptp/ptp_clock.o
  CC      drivers/ptp/ptp_chardev.o
  LD [M]  drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0-common.o
scripts/Makefile.build:509: recipe for target
'drivers/net/wireless/mediatek/mt76' failed
make[7]: *** [drivers/net/wireless/mediatek/mt76] Error 2
scripts/Makefile.build:509: recipe for target
'drivers/net/wireless/mediatek' failed
make[6]: *** [drivers/net/wireless/mediatek] Error 2
scripts/Makefile.build:509: recipe for target 'drivers/net/wireless' failed
make[5]: *** [drivers/net/wireless] Error 2
scripts/Makefile.build:509: recipe for target 'drivers/net' failed
make[4]: *** [drivers/net] Error 2
make[4]: *** Waiting for unfinished jobs....
  CC      drivers/ptp/ptp_sysfs.o
  CC [M]  drivers/ptp/ptp_kvm.o
  AR      drivers/ptp/built-in.a
Makefile:1652: recipe for target 'drivers' failed
make[3]: *** [drivers] Error 2
debian/rules:6: recipe for target 'build' failed
make[2]: *** [build] Error 2
dpkg-buildpackage: error: debian/rules build gave error exit status 2
scripts/Makefile.package:82: recipe for target 'bindeb-pkg' failed
make[1]: *** [bindeb-pkg] Error 2
Makefile:1430: recipe for target 'bindeb-pkg' failed
make: *** [bindeb-pkg] Error 2
