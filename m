Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0C9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F1420848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuNFoNFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgCaKTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:19:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46603 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbgCaKTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:19:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id u4so22304749qkj.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzNurC8m2BgER49ycEMEtlBfddUEOvSlWj/tf+H1wCY=;
        b=LuNFoNFC8TXQngMjWPdYR8nHhN29U4SK5C/6tu+C6Z+PgEZak1OdwmNwOwVU1VCNX8
         5FFNFZzh/c3BjbWbwjiCJ/Px8B3CJYWOU0jKrkqngnC8Z3geASSUwfcxngVJ9pyA2k+B
         GK821BnTbwITarKSs0rPfntebe3NC3+eh+7Xe6jabLQDHgxYSd8Cw9LZICdLhAFfJK2F
         bBf5z/hdULxDQ5F3/JfyloyIoJ/14dPwO5HKdKRssBNBSpFPGY9LNWtiNxX9LFsT08Wo
         tsecSlt49ZGCgU2UOucZHKuyp/u+YgFHzwmpUgqvb/fPtcJf5o84lnrY3A+KeX+d2j0F
         8NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzNurC8m2BgER49ycEMEtlBfddUEOvSlWj/tf+H1wCY=;
        b=DYdMuNhHb5Cf29uroJ/EylqOPq5setS4oqPL3PNejBb/hIW9hyXjYKUO5SI/WeHVS0
         QgJ8ByfWeYLTPvVemC0Gb1fnkf1+F+IRGdPqvXS/FsK6Vp0OmGAX2ChQikzJPAACZ62o
         VLtuerQmbF4QnxBOeHVZC1tbgcwz4FHSGLJ9NM97jFz8NPyNXju47Hc8AKlcBaFwxyOk
         pPrmScwkyozkNRH74KOkHr90B2om//JlmSSHmb0UKrO5JnY1AzS8KlKnnxPUhDfrIP4s
         Tz7Gm68atW8A3LtdohuvIh6AK3a3ZvxpECDzuMIPfuTW+Vnp9qffyX/7lEfoNBViDHEC
         fvEw==
X-Gm-Message-State: ANhLgQ2v1QOQG4c1SeXJ/sr+J6aX8OggjNC+CDkdIuyVzYN/2QNjRVIy
        lqwZpMezpnMibj87Or8spcsEaPmsY6hhZ8x0OMd9LA==
X-Google-Smtp-Source: ADFU+vt5VB3XZM3XDJ4oOkj4wPSxUd+9SkOx1m0xsv+BrY3woUVq5c+khDRiYmVZHffq+/U/ZpzyS1ldKBsjZWQnyIs=
X-Received: by 2002:a37:8d86:: with SMTP id p128mr4267320qkd.250.1585649940834;
 Tue, 31 Mar 2020 03:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ec257905a21f7415@google.com> <20200331095737.GO20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200331095737.GO20730@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 31 Mar 2020 12:18:49 +0200
Message-ID: <CACT4Y+bqBCqDPQZ1Nk8G+8y2vu8aaT2S54J4UqRPaFNUcusbYw@mail.gmail.com>
Subject: Re: INFO: trying to register non-static key in try_to_wake_up
To:     Peter Zijlstra <peterz@infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Cc:     syzbot <syzbot+e84d7ebd1361da13c356@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 30, 2020 at 10:01:12PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    9420e8ad Merge tag 'for-linus' of git://git.kernel.org/pub..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1206ed4be00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e84d7ebd1361da13c356
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+e84d7ebd1361da13c356@syzkaller.appspotmail.com
> >
> > INFO: trying to register non-static key.
> > the code is fine but needs lockdep annotation.
> > turning off the locking correctness validator.
> > CPU: 1 PID: 1014 Comm: syz-executor.0 Not tainted 5.6.0-rc7-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x188/0x20d lib/dump_stack.c:118
> >  assign_lock_key kernel/locking/lockdep.c:880 [inline]
> >  register_lock_class+0x14c4/0x1540 kernel/locking/lockdep.c:1189
> >  __lock_acquire+0xfc/0x3ca0 kernel/locking/lockdep.c:3836
> >  lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
> >  try_to_wake_up+0x9f/0x17c0 kernel/sched/core.c:2547
>
> That's p->pi_lock, which gets initialized in rt_mutex_init_task() in
> copy_process(). This should be impossible. Very odd.

The stack mentions fbdev, which is a red flag at the moment. There are
a dozen of bad bugs in fbdev and around. Just few days ago Andy
pointed to another "impossible" crash "general protection fault in
do_syscall_64" which is related to dri:
https://syzkaller.appspot.com/bug?id=0ec7b2602b1ff40f0d34f38baa4ba1640727c3d9
https://groups.google.com/forum/#!msg/syzkaller-bugs/ePqhfYx0-8M/Q_Urt97iAAAJ

There are probably more random manifestations of these bugs already,
and I guess we will be getting more.

+fbdev maintainers



> >  wake_up_worker kernel/workqueue.c:836 [inline]
> >  insert_work+0x2ad/0x3a0 kernel/workqueue.c:1337
> >  __queue_work+0x50d/0x1280 kernel/workqueue.c:1488
> >  call_timer_fn+0x195/0x760 kernel/time/timer.c:1404
> >  expire_timers kernel/time/timer.c:1444 [inline]
> >  __run_timers kernel/time/timer.c:1773 [inline]
> >  __run_timers kernel/time/timer.c:1740 [inline]
> >  run_timer_softirq+0x412/0x1600 kernel/time/timer.c:1786
> >  __do_softirq+0x26c/0x99d kernel/softirq.c:292
> >  invoke_softirq kernel/softirq.c:373 [inline]
> >  irq_exit+0x192/0x1d0 kernel/softirq.c:413
> >  exiting_irq arch/x86/include/asm/apic.h:546 [inline]
> >  smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1146
> >  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
> >  </IRQ>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200331095737.GO20730%40hirez.programming.kicks-ass.net.
