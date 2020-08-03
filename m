Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E1BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE9E2068F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAECeuEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHCE6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 00:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgHCE6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:58:33 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A21CC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 21:58:33 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so1994833qki.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 21:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeVASvFLppDxXKUutRPWlnLrOhCa6irb0IZXRh/d/lw=;
        b=aAECeuEQCzTE20catutV3+KzgOHdyYW4vnJzs3GDAOjmMWpuVDUikaGnt4RA/QqZV8
         T3R4kRUBHmGhoaFeGW55cCFP9ixB62RHzgX69J9GvPdmZP/dakK0BDj8QjhY13g25A7S
         tKX7MDwDrRZJDa09vLfXvNue3verMeAmJU++f+dHlO1lv99NR+vH94/IY/G2uAppDNzb
         rsj1Rn3J9aAgr3WfLidxSdJd1zi3TGNTG4zxy4tObT5HnDIhJeM8vbZrqXZSWZ8ofEcO
         wYZHIakqsge4//w+3csDg3ClCjLPY7t/HISFw52yyxgecf0D7oe+watYG+/zA3tfKZ8g
         hpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeVASvFLppDxXKUutRPWlnLrOhCa6irb0IZXRh/d/lw=;
        b=YRSd5+yHhBWAECc5/TcG/3USsp3yzbOQs+4Ks3bCqHT8CRpgtCqHimb7CYjv59K3BG
         oiG64C0uQCXSn45LSfe/dLzT+0ol8TyOK99IHkh99XUGFSRU+J2qdTN67zR7E4yWGer6
         /vuGcLYkz8ct3xaer8yKKjgqJdEvZ2Dxi5xcuKNsyOtrhXIuedSMEiuX/z95Io3uYtQA
         /ojCK8AiUGRv1OyacBMRTwpYBL9YsOoFHrKaCU7fKg/S5bbNNumaj4zhThmmys+qOdTO
         H4lBT8UprEVVdy+kJKWbMLezr6XdMKkr5T4eTl0hOtHBKpGSF2fPF41d/k73s2QB7gMV
         Oziw==
X-Gm-Message-State: AOAM532Y4JGo13Zj9uImpoDgavHFN/mYqIO1Wn4ekM2qlDBHJQc04WCo
        M7tmoiP6xksMhdvj37cdT29OqBAew2S4xkK9gg1LNg==
X-Google-Smtp-Source: ABdhPJzmYqP3+MoGwkSKVHqXHrUpncCmasuLKqWdq6TDvQTpaWuFYGaC6hqU/N3Y0XQzc63x9Wh/jRpKiaPVIJnZW4A=
X-Received: by 2002:a05:620a:676:: with SMTP id a22mr14759229qkh.8.1596430712275;
 Sun, 02 Aug 2020 21:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XNC7=jNN1Aoe4TDqXNj8jr5MRYOpS5PkqOY14Sp-mv13w@mail.gmail.com>
 <CACT4Y+b1zC+ghEWX5rY5yCM0H_+_-EPTsd_9qMzMZVO0WM1ipQ@mail.gmail.com>
In-Reply-To: <CACT4Y+b1zC+ghEWX5rY5yCM0H_+_-EPTsd_9qMzMZVO0WM1ipQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Aug 2020 06:58:21 +0200
Message-ID: <CACT4Y+YWMCEzoSrQrryApN0767p_D_POUCBkw_gaoPEHKUQL6A@mail.gmail.com>
Subject: Re: kernel panic: panic_on_warn set
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 6:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Aug 3, 2020 at 5:24 AM butt3rflyh4ck <butterflyhuangxx@gmail.com> wrote:
> >
> > Hi, syzkaller always get this crashes, I think this crash is not a
> > bug, maybe some wrong configs
> > cause, can you give me some help. thanks.
> >
> > log is below:
> > ffff888063151a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff888063151a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ==================================================================
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: 18555 Comm: syz-executor.2 Tainted: G    B             5.8.0-rc7+ #3
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.10.2-1ubuntu1 04/01/2014
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x18f/0x20d lib/dump_stack.c:118
> >  panic+0x2e3/0x75c kernel/panic.c:231
> >  end_report+0x4d/0x53 mm/kasan/report.c:104
> >  __kasan_report mm/kasan/report.c:520 [inline]
> >  kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
> >  __fb_pad_aligned_buffer include/linux/fb.h:655 [inline]
> >  bit_putcs_aligned drivers/video/fbdev/core/bitblit.c:96 [inline]
> >  bit_putcs+0xbb6/0xd20 drivers/video/fbdev/core/bitblit.c:185
> >  fbcon_putcs+0x33c/0x3f0 drivers/video/fbdev/core/fbcon.c:1362
> >  do_update_region+0x399/0x630 drivers/tty/vt/vt.c:683
> >  redraw_screen+0x64c/0x770 drivers/tty/vt/vt.c:1029
> >  vc_do_resize+0x1111/0x13f0 drivers/tty/vt/vt.c:1320
> >  vt_ioctl+0x2037/0x2670 drivers/tty/vt/vt_ioctl.c:901
> >  tty_ioctl+0x1019/0x15f0 drivers/tty/tty_io.c:2656
> >  vfs_ioctl fs/ioctl.c:48 [inline]
> >  ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
> >  __do_sys_ioctl fs/ioctl.c:762 [inline]
> >  __se_sys_ioctl fs/ioctl.c:760 [inline]
> >  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
> >  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x467129
> > Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fb6f7854c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 000000000071e7c0 RCX: 0000000000467129
> > RDX: 0000000020000000 RSI: 000000000000560a RDI: 0000000000000003
> > RBP: 00000000004c0bd5 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000076bf00
> > R13: 0000000000000000 R14: 000000000076bf00 R15: 00007ffd478a3fc0
> > Dumping ftrace buffer:
> >    (ftrace buffer empty)
> > Kernel Offset: disabled
> > Rebooting in 1 seconds..
>
> +syzkaller mailing list, LKML
> -syzkaller-bugs to BCC
>
> Hi butt3rflyh4ck,
>
> This is a very real kernel bug, see:
> https://groups.google.com/forum/#!searchin/syzkaller-bugs/%22bit_putcs_aligned%22%7Csort:date
> There are some reproducers available if you need them.

Or if you are asking about "Kernel panic - not syncing: panic_on_warn
set" specifically, it happens because you set panic_on_warn=1 cmdline
argument. But it only happens if there is a bug happened in the kernel
before, it just turns some non-fatal bugs into fatal. So removing
panic_on_warn=1 won't help. It's the right setting for syzkaller.
