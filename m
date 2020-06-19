Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED70FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9CA208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxKooY1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgFSNjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732993AbgFSNjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:39:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69BBC0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:39:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n9so3951833plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6z1WoXbyKErhNE6Tp2clfySWFQeOwZaqr/w/IRKxzM=;
        b=uxKooY1m8zt26BaQ7pp0BwB2Hz8VGn5h0VDQskeON/SVJ3b/vj65AH8w4JJnbSqKDw
         3C5T8V6siQbA7SJrJ9hIu69tGYyrqON/s6pjqxnQ+tvtCR5loWcyJH6oRd4JTz9fNA9s
         Ea0PggrWpvphGkuwtNOy7Kw6EUvQmvsg8pzsn80vYluJ8of0jju3p6g2Nflb+ADcghwN
         c7Q6VxhSZA5w9TsDtykvRmQ7cavkVl8KFYDBmodM6G3SFSUJ45t2ypfmQ/s/ZOQcIv62
         0x8NH92CaNQYgtAJNIRMqmeBs/clWKC6fyqB7wDFfIej5nrVnxUPU9fqpHaUb6DbOzjB
         KyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6z1WoXbyKErhNE6Tp2clfySWFQeOwZaqr/w/IRKxzM=;
        b=Lgo2i9MqizqEq5MSFNYCsBAkW5Ps79iJpiAkS3yN9ByUeeIEQ0wjjAKet0AJ1p8kLy
         mbdtLdbyywaWMTTUTFEwSHWTZTsDzzCuymaVKKp0YA6WGA3++/GlxtVTgUSG6XyMTxGP
         aV4ESVNymHvypfImTQxpmj9BU0+g7e0cEwGLiV8ZOHPhhZPJ6FEKUIlgUc8VlppLKsZV
         +WEAdCNrIcDofxmDbUMZywzvSa7PcnGb1F2ez7LWMBC0g51p2TqErlQi7xFkwK4jfEto
         t08/XJ4JDIA70BatbMa4jupQhoeXSI+COh4bRKwUL+X2swL6eAr95or6OuxYBUYCIfFX
         NqaQ==
X-Gm-Message-State: AOAM531LdgX6Cf6QAc3dpLh2xJk61KCvbqy0oDgJ5+0i3qVwcPU2Ee+X
        YTZFMVB9jtPjTbacaK9aX2FOHKVcLjtpxHxUs28xZw==
X-Google-Smtp-Source: ABdhPJyYWnwH0B9PgJ5hdzT8BtVrPZSQhiOIC4nhIghUPVzQ68/9f359Mu/AzkXqQ5E6pt9pMSqp438masJ3Mmhat2I=
X-Received: by 2002:a17:90b:1244:: with SMTP id gx4mr3558685pjb.136.1592573975033;
 Fri, 19 Jun 2020 06:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000004a76305a8624d22@google.com> <20200619095342.GT576905@hirez.programming.kicks-ass.net>
 <CACT4Y+aWkGTGXB+h1Hp1yxmrTBRDn1r4YHSQ6-SUK4SHn9serQ@mail.gmail.com>
In-Reply-To: <CACT4Y+aWkGTGXB+h1Hp1yxmrTBRDn1r4YHSQ6-SUK4SHn9serQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 19 Jun 2020 15:39:23 +0200
Message-ID: <CAAeHK+xiQWyUzOMw8xWkCyshMmWHpEfZqhAkvYmwcsGcoSOpLg@mail.gmail.com>
Subject: Re: INFO: trying to register non-static key in is_dynamic_key
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+42bc0d31b9a21faebdf8@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>, devel@etsukata.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:03 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Jun 19, 2020 at 11:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jun 18, 2020 at 02:17:15PM -0700, syzbot wrote:
> >
> > > INFO: trying to register non-static key.
> > > the code is fine but needs lockdep annotation.
> > > turning off the locking correctness validator.
> > > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  <IRQ>
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0xf6/0x16e lib/dump_stack.c:118
> > >  assign_lock_key kernel/locking/lockdep.c:894 [inline]
> > >  register_lock_class+0x1442/0x17e0 kernel/locking/lockdep.c:1206
> > >  arch_stack_walk+0x81/0xf0 arch/x86/kernel/stacktrace.c:25
> > >  lock_downgrade+0x720/0x720 kernel/locking/lockdep.c:4624
> > >  is_dynamic_key+0x1b0/0x1b0 kernel/locking/lockdep.c:1176
> > >  trace_hardirqs_off+0x50/0x1f0 kernel/trace/trace_preemptirq.c:83
> > >  __lock_acquire+0x101/0x6270 kernel/locking/lockdep.c:4259
> > >  save_stack+0x32/0x40 mm/kasan/common.c:50
> >
> > So I'm thinking this is in fact:
> >
> >         spin_lock_irqsave(&depot_lock, flags);
> >
> > from lib/stackdepot.c:stack_depot_save(), which has gone missing from
> > the stack due to tail-call optimizations.
> >
> > Now depot_lock is declared thusly:
> >
> >   static DEFINE_SPINLOCK(depot_lock);
> >
> > and I'm trying to figure out how lockdep manages to conclude that isn't
> > static storage.... most odd.
>
> Note there also was something wrong with the unwinder:
> https://syzkaller.appspot.com/x/log.txt?x=13f305a9100000
> (or with something else in the kernel), so potentially it did not
> happen save_stack.
>
> In fact, Andrey just reverted this parsing of questionable frames in syzkaller:
> https://github.com/google/syzkaller/commit/4d2d1ebee3b65c404576d1c8573a0ec48b03b883
> (was done because of what turned out to be ORC unwinder bug, which was fixed).
>
> So potentially we just need to close this is invalid now.

Rerunning the repro shows a different stack:

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0-rc1+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:894
 register_lock_class+0x1228/0x16d0 kernel/locking/lockdep.c:1206
 __lock_acquire+0x100/0x6950 kernel/locking/lockdep.c:4259
 lock_acquire+0x18b/0x7c0 kernel/locking/lockdep.c:4959
 __raw_spin_lock_irqsave ./include/linux/spinlock_api_smp.h:110
 _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
 ath9k_htc_rxep+0x31/0x210 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c:1128
 ath9k_htc_rx_msg+0x2d9/0xb10 drivers/net/wireless/ath/ath9k/htc_hst.c:459
 ath9k_hif_usb_rx_stream drivers/net/wireless/ath/ath9k/hif_usb.c:638
 ath9k_hif_usb_rx_cb+0xc76/0x1050 drivers/net/wireless/ath/ath9k/hif_usb.c:671
 __usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1716
 dummy_timer+0x125d/0x333b drivers/usb/gadget/udc/dummy_hcd.c:1967
 call_timer_fn+0x1ac/0x6e0 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449
 __run_timers kernel/time/timer.c:1773
 __run_timers kernel/time/timer.c:1740
 run_timer_softirq+0x5e5/0x14c0 kernel/time/timer.c:1786
 __do_softirq+0x21e/0x98b kernel/softirq.c:292
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack ./arch/x86/include/asm/irq_stack.h:22
 run_on_irqstack_cond ./arch/x86/include/asm/irq_stack.h:48
 do_softirq_own_stack+0x109/0x140 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:387
 __irq_exit_rcu kernel/softirq.c:417
 irq_exit_rcu+0x16f/0x1a0 kernel/softirq.c:429
 sysvec_apic_timer_interrupt+0xd3/0x1b0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 ./arch/x86/include/asm/idtentry.h:596
RIP: 0010:native_safe_halt ./arch/x86/include/asm/irqflags.h:60
RIP: 0010:arch_safe_halt ./arch/x86/include/asm/irqflags.h:103
RIP: 0010:default_idle+0x28/0x2f0 arch/x86/kernel/process.c:700
Code: cc cc 41 56 41 55 65 44 8b 2d 44 77 66 7a 41 54 55 53 0f 1f 44
00 00 e8 f6 d7 a9 fb e9 07 00 00 00 0f 00 2d 2a 34 47 00 fb f4 <65> 44
8b 2d 20 77 66 7a 0f 1f 44 00 00 5b 5d 41 3
RSP: 0018:ffffffff87007da0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff8702f840 RCX: 1ffffffff0fd45ea
RDX: 1ffffffff0e0600f RSI: 0000000000000000 RDI: ffffffff87030078
RBP: fffffbfff0e05f08 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff87ea1fc8 R15: 0000000000000000
 cpuidle_idle_call kernel/sched/idle.c:154
 do_idle+0x3ec/0x510 kernel/sched/idle.c:269
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:365
 start_kernel+0x9fc/0xa39 init/main.c:1043
 secondary_startup_64+0xb6/0xc0 arch/x86/kernel/head_64.S:243

So this is a dup of:

#syz dup: INFO: trying to register non-static key in ath9k_htc_rxep

Not sure why lockdep triggered on save_stack() in this run.
