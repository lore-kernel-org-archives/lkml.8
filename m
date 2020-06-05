Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7513C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEFD2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqUl9Ad5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgFEKWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgFEKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:22:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00586C08C5C5
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 03:22:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id x93so7003280ede.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/7kpylh0DFfkHHWAOwcR79ZPvCJMRxID3i22/+RvTqA=;
        b=dqUl9Ad5uySoQuXHTyZVmFzbMV6TUk4Mi0qyrrDyIdYbPM+WdFgPc3fKoUO4dqHImT
         PLJIIVcSv6uz8BDrZz2aFGyhXCJw/SSKenHv+pnJkbkLG3Lcoc81iQtgyo7xj6Pnsq/S
         CvSOrUEaYFfbxrjH6WsQLhZkixn222abgZTtNNWlqytjKL9nqR+5rISIUdXzZ3qBgy1x
         4D75jX/vXWZ7cDW+XPpo09lpD7j4X4WrNeUcB733RhKzyIgZHLAVVqS0sFOFFO0iEhR/
         mEEr4lIcUVJd4LCjnATtYboYULDHlN5lL4skuDi+JW4PjBZpYUcni5kHM9Ht4XRi2czG
         AioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/7kpylh0DFfkHHWAOwcR79ZPvCJMRxID3i22/+RvTqA=;
        b=UTtTP4v4awuahoXyRtRc4CREGL3E48pP7J7W95j/guaAw92bWMSKGTAXt0i5mOKRZy
         iGDFtoXU9RjnOUB3jwFXruGu9W1wvOdu5QdenXLz51OXMN72VTW7EEL0hv2qnDRQlBlt
         5m7u4f1J+S/QSxPy/iY3UhfqQkTpCMR+QGDd4MxQJSOp5c2ow3EIjkLJ3Hep5nrp0osn
         GMOqD1gHyOVzLte8K3frgCLyZW9QQw/eERWjEzTx96cBXhd7RwWEJFSu2+mmxyDSRsCW
         cfhAr4eiXDelYA+PBkaQAs3EeO0aRO+ZswLx3aysKpxIdc4XFhsqRacmlqA43J1kgTKC
         U/vQ==
X-Gm-Message-State: AOAM533pZ9XDYD77RNyMAivyce+6+BjAfy4IHuGeGXe9LwO/k5NaX1F2
        z3/tTX2CJMn7uWs4c/E5oEsz66gon3AtQyqzXES+6DEJkgE=
X-Google-Smtp-Source: ABdhPJyCs7FyaRsyn6lj2nsklqUCQwascOuPM/9UznbeWbFth6b6mD1G1GUwqWWNXPc8mMkCqjTtsnhnki/cdayl42M=
X-Received: by 2002:aa7:da8c:: with SMTP id q12mr8766574eds.385.1591352520428;
 Fri, 05 Jun 2020 03:22:00 -0700 (PDT)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Fri, 5 Jun 2020 13:21:49 +0300
Message-ID: <CADxRZqwxxvxo_JhtDVX7ke09tVDOW-d6dz4bw1OVhHETnrE+mQ@mail.gmail.com>
Subject: unable to compile after "module: Make module_enable_ro() static again"
To:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jkosina@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

i'm unable to compile kernel on debian sid/unstable (tested on sparc64
and ppc64) after commit e6eff4376e2897c2e14b70d87bf7284cdb093830

~/linux-2.6$ git bisect bad
e6eff4376e2897c2e14b70d87bf7284cdb093830 is the first bad commit
commit e6eff4376e2897c2e14b70d87bf7284cdb093830
Author: Josh Poimboeuf <jpoimboe@redhat.com>
Date:   Wed Apr 29 10:24:53 2020 -0500

    module: Make module_enable_ro() static again

    Now that module_enable_ro() has no more external users, make it static
    again.

    Suggested-by: Jessica Yu <jeyu@kernel.org>
    Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
    Acked-by: Jessica Yu <jeyu@kernel.org>
    Signed-off-by: Jiri Kosina <jkosina@suse.cz>

 include/linux/module.h | 6 ------
 kernel/module.c        | 3 ++-
 2 files changed, 2 insertions(+), 7 deletions(-)


git bisect log :

~/linux-2.6$ git bisect log
git bisect start
# bad: [435faf5c218a47fd6258187f62d9bb1009717896] Merge tag
'riscv-for-linus-5.8-mw0' of
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
git bisect bad 435faf5c218a47fd6258187f62d9bb1009717896
# good: [6929f71e46bdddbf1c4d67c2728648176c67c555] atomisp: avoid
warning about unused function
git bisect good 6929f71e46bdddbf1c4d67c2728648176c67c555
# bad: [694b5a5d313f3997764b67d52bab66ec7e59e714] Merge tag
'arm-soc-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad 694b5a5d313f3997764b67d52bab66ec7e59e714
# good: [d9b8fbf15d05350b36081eddafcf7b15aa1add50] ALSA: es1688: Add
the missed snd_card_free()
git bisect good d9b8fbf15d05350b36081eddafcf7b15aa1add50
# bad: [9ff7258575d5fee011649d20cc56de720a395191] Merge branch
'proc-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
git bisect bad 9ff7258575d5fee011649d20cc56de720a395191
# good: [acf25aa66371359f542d14e8d993b530fe25d7ac] Merge tag
'Smack-for-5.8' of git://github.com/cschaufler/smack-next
git bisect good acf25aa66371359f542d14e8d993b530fe25d7ac
# good: [86c67ce20d080bdfefafd461d3068cad0a49a66b] Merge tag
'leds-5.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds
git bisect good 86c67ce20d080bdfefafd461d3068cad0a49a66b
# bad: [9fb4c5250f10dc4d8257cd766991be690eb25c5b] Merge branch
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/l=
ivepatching
git bisect bad 9fb4c5250f10dc4d8257cd766991be690eb25c5b
# good: [16ba7e312045cd5d32fba0156312b4303f200787] Merge branches
'for-5.7/upstream-fixes', 'for-5.8/apple', 'for-5.8/asus',
'for-5.8/core', 'for-5.8/intel-ish', 'for-5.8/logitech',
'for-5.8/mcp2221' and 'for-5.8/multitouch' into for-linus
git bisect good 16ba7e312045cd5d32fba0156312b4303f200787
# good: [5b384f933590a086ca9a0abdc2e55e41107ac440] x86/module: Use
text_mutex in apply_relocate_add()
git bisect good 5b384f933590a086ca9a0abdc2e55e41107ac440
# bad: [f55d9895884b1e816f95b5109b4b3827ae18c4ab] MAINTAINERS: add
lib/livepatch to LIVE PATCHING
git bisect bad f55d9895884b1e816f95b5109b4b3827ae18c4ab
# bad: [2a4248749624a38ebddcd1fd82bbab8132d655ad] MAINTAINERS: adjust
to livepatch .klp.arch removal
git bisect bad 2a4248749624a38ebddcd1fd82bbab8132d655ad
# bad: [e6eff4376e2897c2e14b70d87bf7284cdb093830] module: Make
module_enable_ro() static again
git bisect bad e6eff4376e2897c2e14b70d87bf7284cdb093830
# first bad commit: [e6eff4376e2897c2e14b70d87bf7284cdb093830] module:
Make module_enable_ro() static again



error message is :

~/linux-2.6$ make  -j 24
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CHK     include/generated/compile.h
  CC      kernel/module.o
kernel/module.c: In function =E2=80=98do_init_module=E2=80=99:
kernel/module.c:3576:2: error: implicit declaration of function
=E2=80=98module_enable_ro=E2=80=99; did you mean =E2=80=98module_enable_x=
=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
 3576 |  module_enable_ro(mod, true);
      |  ^~~~~~~~~~~~~~~~
      |  module_enable_x
cc1: some warnings being treated as errors
make[1]: *** [scripts/Makefile.build:266: kernel/module.o] Error 1
make: *** [Makefile:1722: kernel] Error 2


$ gcc --version
gcc (Debian 9.3.0-12) 9.3.0
