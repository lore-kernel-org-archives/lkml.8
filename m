Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF6FC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7952073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfqgBbZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDUIOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDUIOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:14:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1233DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:14:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so2611413wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hzdBfCko64Cr24a0dsvDnS+0zFtQQxlJxNUpgXOxXug=;
        b=HfqgBbZ+KORLSWrZg+uwnOOQfUMtqRbkrl38Q632Fdc6V5IW56KGWPgEM24jxdobdM
         QAi/sKJkSkCEYYoUeiGq4KXLZi8VLLS+r3A/R9eaEJC91h+MTYe3wdxaaVhmZ7sjwnOg
         NXeiVjQl1pL9wW1HjdPWpB0rIMGSHtx19/KiJN81BNVVzaN/xLD5f1Z//5BIh3hija2n
         YPjkhc8paEWjmecpb1xVwDt3kZ/PNsaiV3tNfSZ/LJgPigjVcBpLk1SYcxNSOm/BWSdb
         V+6n/1zKm02sVo2B0frd08g90qwhvEiiidp6YlQyZvPPYjkF/AWr3GkBtgtsfeYCxKFA
         +vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hzdBfCko64Cr24a0dsvDnS+0zFtQQxlJxNUpgXOxXug=;
        b=nAz3N2/5GdtmD0c30FuGP2MCbPN1h1kFwFB06+2zYxP7BnBqNf2Zo8jzvqM7WHyId0
         QaOZCWn2Vz3otOJCREMnqcuxcPDHgnkxPcAjCM9pquAOjxLLCxgRSdSgpPriXrbvIcbY
         IBzEED99Rz9bdZfFPngcrIDRQ9iKO02S5K8E85gS5VRGrKd4nZuBcummV9YivgLK09vq
         nAHkB6bFiCFtEXF2D9y7hoDvQuBMG1OFCuwfXSgrduZUdIALaUOx0QdAwB5HGnWOrvu/
         dpug5o3+8F6stn8jPjfBkM6yhQvOHOyMMesfZnOgo1857TcMEkXKUVKDwmJQn0Ix31yq
         TO1Q==
X-Gm-Message-State: AGi0PubX76YpSY3sm5sE67Lw8I4zyvG4/jhiLPSKOcf6e8YFQ87o3t2E
        wm0vfocrB24TM0j8yIZLwookYceCZiaSB5fPYeB9Gg==
X-Google-Smtp-Source: APiQypLT4d1gLh7HfoMWCX5K/gIVomdjR0LZgpdYpVrGjdc2dDWKXWmyoBN5HMsumMUMwTuZ3kXM1TIGMv0+3x35zvQ=
X-Received: by 2002:a1c:f312:: with SMTP id q18mr3562037wmq.175.1587456876418;
 Tue, 21 Apr 2020 01:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200419100848.63472-1-glider@google.com> <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook> <20200421034249.GB23230@ZenIV.linux.org.uk>
In-Reply-To: <20200421034249.GB23230@ZenIV.linux.org.uk>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 Apr 2020 10:14:25 +0200
Message-ID: <CAG_fn=VZZ7yUxtOGzuTLkr7wmfXWtKK9BHHYawj=rt9XWnCYvg@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in fill_thread_core_info()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Not lately and I would also like to hear the details; which regset it is?
> Should be reasonably easy to find - just memset() the damn thing to somet=
hing
> recognizable, do whatever triggers that KMSAN report and look at that
> resulting coredump.

The bug is easily triggerable by the following program:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
int main() {
  volatile char *c =3D 0;
  (void)*c;
  return 0;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

in my QEMU after I do `ulimit -c 10000`.

I use the following patch:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f4713ea76e827..570193a1b291d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1734,6 +1734,7 @@ static int fill_thread_core_info(struct
elf_thread_core_info *t,
                        int ret;
                        size_t size =3D regset_size(t->task, regset);
                        void *data =3D kmalloc(size, GFP_KERNEL);
+                       memset(data, 0xae, size);
                        if (unlikely(!data))
                                return 0;
                        ret =3D regset->get(t->task, regset,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

to find uninitialized bytes in the core file using hexdump.
Those are:

0x96c--0x984 (24 bytes)
0x98c--0xa0c (128 bytes)
0xb0c--0xb3c (48 bytes)
0xbac--0x13ec (2112 bytes)

I added kmsan_check_memory(addr, nr) to dump_emit() and got the
following reports when calling dump_emit(cprm, men->data, men->datasz)
in writenote():

BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10
mm/kmsan/kmsan_hooks.c:428
Bytes 0-23 of 2696 are uninitialized
BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10
mm/kmsan/kmsan_hooks.c:428
Bytes 32-159 of 2696 are uninitialized
BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10
mm/kmsan/kmsan_hooks.c:428
Bytes 416-463 of 2696 are uninitialized
BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10
mm/kmsan/kmsan_hooks.c:428
Bytes 576-2687 of 2696 are uninitialized

FWIW one of such reports looks as follows:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10
mm/kmsan/kmsan_hooks.c:428
CPU: 0 PID: 1503 Comm: probe Not tainted 5.6.0-rc7+ #4105
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/=
2014
Call Trace:
 __dump_stack lib/dump_stack.c:77
 dump_stack+0x16f/0x208 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 kmsan_internal_check_memory+0x22e/0x3c0 mm/kmsan/kmsan.c:423
 kmsan_check_memory+0xd/0x10 mm/kmsan/kmsan_hooks.c:428
 dump_emit+0x1ab/0x580 fs/coredump.c:824
 writenote+0x30a/0x4b0 fs/binfmt_elf.c:1420
 free_note_info fs/binfmt_elf.c:1910
 elf_core_dump+0x644c/0x6e60 fs/binfmt_elf.c:2377
 do_coredump+0x488d/0x5400 fs/coredump.c:790
 get_signal+0x147f/0x2d50 kernel/signal.c:2733
 do_signal+0x6d/0xda0 arch/x86/kernel/signal.c:813
 exit_to_usermode_loop arch/x86/entry/common.c:160
...
Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144
 kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:127
 kmsan_poison_shadow+0x5f/0xa0 mm/kmsan/kmsan_hooks.c:405
 kmalloc ./include/linux/slab.h:560
 fill_thread_core_info fs/binfmt_elf.c:1736
 fill_note_info fs/binfmt_elf.c:1838
 elf_core_dump+0x2f8c/0x6e60 fs/binfmt_elf.c:2239
 do_coredump+0x488d/0x5400 fs/coredump.c:790
 get_signal+0x147f/0x2d50 kernel/signal.c:2733
 do_signal+0x6d/0xda0 arch/x86/kernel/signal.c:813
 exit_to_usermode_loop arch/x86/entry/common.c:160
 prepare_exit_to_usermode+0x337/0x480 arch/x86/entry/common.c:195
 swapgs_restore_regs_and_return_to_usermode+0x0/0x80
arch/x86/entry/entry_64.S:625

Bytes 0-23 of 2696 are uninitialized
Memory access of size 2696 starts at ffff9e85a7115000
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
