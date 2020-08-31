Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40AEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8AF206E3
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J16HH5uA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHaNIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgHaNIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:08:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA84C061755
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:08:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kx11so2914697pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mk7FtTc/f6qHI6YR0nGT99GfuEciTtZUAkIA+oGDTfQ=;
        b=J16HH5uA2klm2bdsp1Gjtj0NJQcbP+ztovRXtBEfLffl5VWu5VAYr1HIcUEN/xepfh
         OfjvkYiaTQPNnGgjoi9RP0md3GE1OewP6vWxZJQORJMcGsI/tCEtplqn5+ai9s8eutya
         8uBjxHSndtJjkidrTQppKWNZjEMWQrkUcvstwJXvKTedn5aSTGIJ72ri9Q5yZVQlziwA
         mL9Cvoz/ryNLVMCyjD5IgL+MuFfN/VOaS5DZY9A+0QVCMCoIcL6yKb5gygXvSCZN0GmX
         QdaI7SgotecPklcgE1G9QVQo+1V72flhhzZ863kSeeyV68tWTpHoU4wRYUx1lttszjGj
         G01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mk7FtTc/f6qHI6YR0nGT99GfuEciTtZUAkIA+oGDTfQ=;
        b=ozMpjGqiNi1TkxKXHUvmegQDv26j/iiGxXwiYSd30Ex+hoW/Td84tGyHG1EtSlodNc
         fF3SjVQadKLQEmTjVpUu1D//CfqPhd7dSOHdZknxL0VZtBOo4ASMxtxJGVCjjNJt1CJL
         GarJRyfhnHSibjNHNrrDVrsuYn4MNAfB2Q7IzghEwMFNlgXzfR/k5HT6TL5wM2gOHFTm
         u7h+0Hsfbh4TOMCUAhkISe2uUcPBSQ9SQph+wWrDQhGntFxHb8NXhVyqHyVHb/XWD3aT
         +qDRYCrCfZbF1jT+nst4b5AuYj7cIXqXU0xNbwY3TIcNC3xvEIPkphMEyUPq4cy1bLLM
         ZqkQ==
X-Gm-Message-State: AOAM532UrzIfzzqaaWvl/YgjyKu27GEQKUTJ9QCMI36b2Ab1Gv1f80L2
        mf39F3smp93gA/VJ6ugsb9n+yLFdkleSkorR4jFKjg==
X-Google-Smtp-Source: ABdhPJzYKTYVAtyZXsiilypXQ6hmz9ZsSEUQ6nit9aUfPrUNqSlmP2XSrQ6MdiU36zQQyUD5aa195dzQr1jfsRsM7z8=
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr1016337pls.98.1598879295913;
 Mon, 31 Aug 2020 06:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d3c499057536ce86@google.com> <000000000000c69c7805adef8597@google.com>
 <20200829012415.GB486691@rowland.harvard.edu>
In-Reply-To: <20200829012415.GB486691@rowland.harvard.edu>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 31 Aug 2020 15:08:05 +0200
Message-ID: <CAAeHK+z2KDbNVW5_5BA8P+r=8+VQY1p9ksJmny6ZW0xR3zBobA@mail.gmail.com>
Subject: Re: INFO: task hung in usb_bulk_msg
To:     Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com>,
        andriy.shevchenko@linux.intel.com, bigeasy@linutronix.de,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        rafael.j.wysocki@intel.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 3:24 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Aug 28, 2020 at 05:52:16AM -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1052a669900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7a7613e5ba9ae7bd15f9
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c328e900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155eff41900000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com
> >
> > INFO: task syz-executor790:9958 blocked for more than 143 seconds.
> >       Not tainted 5.9.0-rc2-syzkaller #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:syz-executor790 state:D stack:28240 pid: 9958 ppid:  6854 flags:0x00004004
> > Call Trace:
> >  context_switch kernel/sched/core.c:3778 [inline]
> >  __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
> >  schedule+0xd0/0x2a0 kernel/sched/core.c:4602
> >  schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
> >  do_wait_for_common kernel/sched/completion.c:85 [inline]
> >  __wait_for_common kernel/sched/completion.c:106 [inline]
> >  wait_for_common kernel/sched/completion.c:117 [inline]
> >  wait_for_completion_timeout+0x15e/0x270 kernel/sched/completion.c:157
> >  usb_start_wait_urb+0x144/0x2b0 drivers/usb/core/message.c:63
> >  usb_bulk_msg+0x226/0x550 drivers/usb/core/message.c:254
> >  do_proc_bulk+0x39b/0x710 drivers/usb/core/devio.c:1231
> >  proc_bulk drivers/usb/core/devio.c:1268 [inline]
> >  usbdev_do_ioctl drivers/usb/core/devio.c:2542 [inline]
> >  usbdev_ioctl+0x586/0x3360 drivers/usb/core/devio.c:2708
>
> I'm confused about this bug report.
>
> Here's the syz reproducer from the link listed above:
>
> #
> https://syzkaller.appspot.com/bug?id=bf172344c5f1d3487a4feff67c3dd30e08d5b635
> # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> #{"threaded":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"netdev":true,"close_fds":true}
> r0 = syz_open_dev$usbfs(&(0x7f0000000040)='/dev/bus/usb/00#/00#\x00',
> 0x4000000000000071, 0x28081)
> r1 = socket$inet6(0xa, 0x2, 0x0)
> r2 = dup(r1)
> ioctl$PERF_EVENT_IOC_ENABLE(r2, 0x8912, 0x400200)
> socketpair$unix(0x1, 0x0, 0x0, &(0x7f0000000000))
> ioctl$USBDEVFS_CONTROL(r0, 0x8108551b, &(0x7f0000001140)={0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0})
> ioctl$USBDEVFS_CLEAR_HALT(r0, 0xc0185502, &(0x7f0000000000)={0x1, 0x1})
>
> As far as I can see, the only USB ioctls used in this test are
> USBDEVFS_CONTROL and USBDEVFS_CLEAR_HALT.  Neither of those calls
> do_proc_bulk() or usb_bulk_msg(), so how did those routines end up in
> the stack trace?
>
> In fact, do_proc_bulk() is called only for USBDEVFS_BULK.  But the test
> doesn't use that ioctl!
>
> What's going on?  Am I missing part of the test?

Hi Alan,

Yeah, it's a bit confusing, sorry for that. Since syzkaller mutates
the values that are passed into syscalls, it might mutate the cmd
value of an ioctl. This results in a mismatch between the name of a
syscall in syzkaller's notation, and the actual cmd value. In this
case we have:

ioctl$USBDEVFS_CONTROL(r0, 0x8108551b, ...)

where 0x8108551b == 2164806939, which is the value for
USBDEVFS_DISCONNECT_CLAIM [1], and

ioctl$USBDEVFS_CLEAR_HALT(r0, 0xc0185502, ...)

where 0xc0185502 == 3222820098, which is the value for USBDEVFS_BULK [2].

I remember Dmitry did some changes to this part, but I think syzkaller
only avoids getting disabled ioctls during mutations. Dmitry, maybe it
would make sense to avoid getting other known ioctls during mutations?

Thanks!

[1] https://github.com/google/syzkaller/blob/master/sys/linux/dev_bus_usb.txt.const#L13
[2] https://github.com/google/syzkaller/blob/master/sys/linux/dev_bus_usb.txt.const#L4
