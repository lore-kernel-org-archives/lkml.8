Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7542AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4202820FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwfCmmQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389664AbgFXHUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388622AbgFXHUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:20:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A98C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:20:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so1466193wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=drCCaJCXIn2mo+mQ/UY/6xEqi1xm+UmU4NktVohFN/Y=;
        b=uwfCmmQYp9GrrUekyLK9vL9jLZ+BwiKQT7PnF9ENmwqfacWCXDWDc3lgTq1uBdt+mU
         KgZtLqjaY++wcvGB/U/848Y51wtS9SAJQE6Hm5LnXVf0ywEJzZO9Jv7GPqlku7yyWCHh
         VtjPKHb2fcDeTtCVb0eUtP+fUxypcKWnomiHuBVwQHQZzdj+fORnm3a7mQGSSpMu4AyX
         YEChk4cs8+zf0/6boK/kWeBSE56gbOccn+DjLtSkaSqpreg0q8QAo6QhemyBJFY34iHp
         fhPuDxK81n6wiD5nsWSG1vhXoGYk1yzlNYjOptytz/rGMjNPjWpRtfhAJZKTiU53o38m
         CtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=drCCaJCXIn2mo+mQ/UY/6xEqi1xm+UmU4NktVohFN/Y=;
        b=BKKsm5gzaV/6j6hQlUzizUQBoGvRC86+m839BEj9COWuiB0+fd0UDoVG8jmeNnRsHT
         td8qPUpQXKuPl6DDo9Oxjup6+JEVkF1Uysy6wnWac/L+VuFq3YgyOUlkgPNmTHV5qLsC
         BPEreDcuep61erbk8OedgwNuBvVp+mjDoTCkLc8CYd3l3WbiD+LyMYjJVJTgHnTfDiU0
         nAx0J2VBMT8xgy0UvRL7J/KUmoWig7ygThIqf/9TfY7fBhBw9pNBtP7eUK8T6lEEFCSL
         p4Ehwz4KwGltq1kkA+HoHur4XnbjGNzkTzBheb913OVAbBMT0KBVvXo6ObhbTzYO5cx4
         1L6g==
X-Gm-Message-State: AOAM531uTh109tz2vlmxCDpJjEJwFkHbZtCMbBWa55N+9/Ctg8GSjTaM
        UhZOErgAcP/11BVPmZHtbKlywglu4brtFOXudaWawSxE5RY=
X-Google-Smtp-Source: ABdhPJzHjm8RtRv71V5VykstOzUMuWAtF+YHeHfqQHk/vk+GilfeafMjoA7Y+iN3GJm/COFkDZyZk606mVBBKnpIqFc=
X-Received: by 2002:a1c:61d7:: with SMTP id v206mr25236029wmb.173.1592983231896;
 Wed, 24 Jun 2020 00:20:31 -0700 (PDT)
MIME-Version: 1.0
From:   Caleb Jorden <cjorden@gmail.com>
Date:   Wed, 24 Jun 2020 12:50:19 +0530
Message-ID: <CABD8wQkJ7ZrjeBszFqd92x504hXmbEPdcUpBft3KSnZo-70a2Q@mail.gmail.com>
Subject: GCC_PLUGIN_RANDSTRUCT being set breaks 5.8-rc2 build
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I was trying to test out the 5.8-rc2 kernel using my standard
machine-specific config, but my build kept failing.  I ended up
comparing against the x86_64_defconfig configuration (which worked)
using the config-bisect.pl script, and discovered that if
GCC_PLUGIN_RANDSTRUCT is set, I get this error:

--------------------
In file included from ./arch/x86/include/asm/atomic.h:5,
                 from ./include/linux/atomic.h:7,
                 from ./include/linux/llist.h:51,
                 from ./include/linux/irq_work.h:5,
                 from kernel/smp.c:10:
kernel/smp.c: In function =E2=80=98smp_init=E2=80=99:
./include/linux/compiler.h:392:38: error: call to
=E2=80=98__compiletime_assert_157=E2=80=99 declared with attribute error: B=
UILD_BUG_ON
failed: offsetof(struct task_struct, wake_entry_type) -
offsetof(struct task_struct, wake_entry) !=3D offsetof(struct
__call_single_data, flags) - offsetof(struct __call_single_data,
llist)
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNT=
ER__)
      |                                      ^
./include/linux/compiler.h:373:4: note: in definition of macro
=E2=80=98__compiletime_assert=E2=80=99
  373 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:392:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNT=
ER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg=
)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON_MSG=E2=80=99
   50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |  ^~~~~~~~~~~~~~~~
kernel/smp.c:687:2: note: in expansion of macro =E2=80=98BUILD_BUG_ON=E2=80=
=99
  687 |  BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) -
offsetof(struct task_struct, wake_entry) !=3D
      |  ^~~~~~~~~~~~
  CC      fs/fs_context.o
make[1]: *** [scripts/Makefile.build:281: kernel/smp.o] Error 1
--------------------

I am able to reproduce this error now if I use the x86_64_defconfig,
and simply set GCC_PLUGIN_RANDSTRUCT from the configuration tree in:
- General architecture-dependent options
  - GCC plugins
    [x] Randomize layout of sensitive kernel structures

It appears the cause is this commit:
---------------------
commit a148866489fbe243c936fe43e4525d8dbfa0318f
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue May 26 18:11:04 2020 +0200

    sched: Replace rq::wake_list
---------------------

I am observing these build failures on GCC 9.3.0 (Gentoo) and GCC
10.1.0 (Manjaro) using the 5.8-rc2 kernel from git
(48778464bb7d346b47157d21ffde2af6b2d39110).

I am not on the kernel mailing list, if there is anything I can do to
assist with fixing this, please copy me directly.

Thanks!

Caleb Jorden
cjorden@gmail.com
