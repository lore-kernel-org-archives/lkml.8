Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF76D2068F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyFVt2VZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHCE4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 00:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgHCE4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:56:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6BC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 21:56:03 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v22so21471926qtq.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyIjl45Pgy9vqtiCILUPKeLARSoW/w/mL0qhhwzHC28=;
        b=EyFVt2VZ8Ypbf92YqwMST/cJOlYaDNNhjqrA1BOWdl2lKE+jxoNuSy7GtWa6rENExR
         Bu++8NiQc0f27dh9ELvN0vyv0cbrIRwPjZG7xgUQu92KjoG4Z3uTgg499nDL22KpaCZ1
         dh9ecR+S+FA9++APiZrhRdwmknmI3t47YBF7rofxRUo6Tlfh3NwpntH0jC3WCCKG6aBd
         efkPTAp6tm7QfM6b6fYoO/gKnEpwruc+G1twi2yhQFo+jbUKHW3+VOB/buoC4nQqpRa9
         Lo3KwuajlcwKE1Z6qsbz4HbAp2zVC6E9SPPkprlFSzESxWeflltccCbAF5Eq6wCC4DGE
         2rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyIjl45Pgy9vqtiCILUPKeLARSoW/w/mL0qhhwzHC28=;
        b=FCeVGqFt/j8W0Xfhb17vjKYJfDC4MIjWsdMHsLvNV+KrFfG7LiHmXJSBUxLx0A8j1y
         KPp5vsr8GKh9WZDlrUWINln76KI28S71Uosd6/3MTvaS8shmpxUXpFDMiFK8Cqc0tIQJ
         4465csrtUYh3Clubdp3slJQ44ZqB9SMkqf0Y7HnQ9kK4CpTWTy1rI4sHd10dZ4Icw0Z+
         stkprRiaJXL1ICv81EKtlYSx1c6/yeUFYyKHlt3eaKMSP4abGDxz0/f8XbmdGdsJWxV9
         cHhKij2nWo183fSkIlSDtOqq/p/1C7imjlTf6fggj1kr5l4Kb/IhqhWc+2ecFHGG2Yvw
         0xJA==
X-Gm-Message-State: AOAM5334Lw6xhQ/9Ui01bxDbVvSLUmuiDZnD0CJbcIZe+cT68vvFQVMR
        2mubSlPPW0Jam6yoGm7JQWCycwMk+kcIjaD5DkZAvg==
X-Google-Smtp-Source: ABdhPJwOfOBRTqkKy+IRRMnbEl3O4sksn6aBy3aYn6KC5Qma3qzdN0TXFqkSV/cfbNV3J92CHbWuPip3hnGKkvR777w=
X-Received: by 2002:ac8:470e:: with SMTP id f14mr15037252qtp.380.1596430562036;
 Sun, 02 Aug 2020 21:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XNC7=jNN1Aoe4TDqXNj8jr5MRYOpS5PkqOY14Sp-mv13w@mail.gmail.com>
In-Reply-To: <CAFcO6XNC7=jNN1Aoe4TDqXNj8jr5MRYOpS5PkqOY14Sp-mv13w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Aug 2020 06:55:50 +0200
Message-ID: <CACT4Y+b1zC+ghEWX5rY5yCM0H_+_-EPTsd_9qMzMZVO0WM1ipQ@mail.gmail.com>
Subject: Re: kernel panic: panic_on_warn set
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 5:24 AM butt3rflyh4ck <butterflyhuangxx@gmail.com> wrote:
>
> Hi, syzkaller always get this crashes, I think this crash is not a
> bug, maybe some wrong configs
> cause, can you give me some help. thanks.
>
> log is below:
> ffff888063151a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888063151a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 18555 Comm: syz-executor.2 Tainted: G    B             5.8.0-rc7+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  panic+0x2e3/0x75c kernel/panic.c:231
>  end_report+0x4d/0x53 mm/kasan/report.c:104
>  __kasan_report mm/kasan/report.c:520 [inline]
>  kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
>  __fb_pad_aligned_buffer include/linux/fb.h:655 [inline]
>  bit_putcs_aligned drivers/video/fbdev/core/bitblit.c:96 [inline]
>  bit_putcs+0xbb6/0xd20 drivers/video/fbdev/core/bitblit.c:185
>  fbcon_putcs+0x33c/0x3f0 drivers/video/fbdev/core/fbcon.c:1362
>  do_update_region+0x399/0x630 drivers/tty/vt/vt.c:683
>  redraw_screen+0x64c/0x770 drivers/tty/vt/vt.c:1029
>  vc_do_resize+0x1111/0x13f0 drivers/tty/vt/vt.c:1320
>  vt_ioctl+0x2037/0x2670 drivers/tty/vt/vt_ioctl.c:901
>  tty_ioctl+0x1019/0x15f0 drivers/tty/tty_io.c:2656
>  vfs_ioctl fs/ioctl.c:48 [inline]
>  ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
>  __do_sys_ioctl fs/ioctl.c:762 [inline]
>  __se_sys_ioctl fs/ioctl.c:760 [inline]
>  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
>  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x467129
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb6f7854c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000071e7c0 RCX: 0000000000467129
> RDX: 0000000020000000 RSI: 000000000000560a RDI: 0000000000000003
> RBP: 00000000004c0bd5 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000076bf00
> R13: 0000000000000000 R14: 000000000076bf00 R15: 00007ffd478a3fc0
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 1 seconds..

+syzkaller mailing list, LKML
-syzkaller-bugs to BCC

Hi butt3rflyh4ck,

This is a very real kernel bug, see:
https://groups.google.com/forum/#!searchin/syzkaller-bugs/%22bit_putcs_aligned%22%7Csort:date
There are some reproducers available if you need them.
