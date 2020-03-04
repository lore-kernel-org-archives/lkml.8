Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD7BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9C721741
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vd1akRsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgCDIeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:34:05 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36609 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgCDIeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:34:04 -0500
Received: by mail-qv1-f65.google.com with SMTP id r15so427340qve.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 00:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGkxEVuNmSpsbMjbs4y3ZqP9ci0NOJ4QjgZ1q4n/Bvw=;
        b=Vd1akRsv09v+hvji2/nchiQdEo0xQsLZ8q88rQU7ex+/UraV53POStpzqHkK+bKTBy
         MwIh+WhO2pXt7FC0xQema4LRUdAsMpIxdguBysHFyVX8o+CLLMpKtPoa0c6gBqHscTyM
         TPEAkhpsZ5FJPB5NHE1SeRunP29S4Dijaz2kYxxolpJLvIzcoyy9gg+/T7UlTdWWHzCs
         Sn+mY3sEGXQksFTp5C78RqTWr2WvF7a81HSvzr+YMOWaxgDc7EvcsKXWil9kzkOJV/Jp
         PtgAIZFbiIa5DUn+6ciE+FEHhN5Cr2RhNyM1d6UGfofP9i+huwEiDCOS1fhZbyCihmvr
         1erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGkxEVuNmSpsbMjbs4y3ZqP9ci0NOJ4QjgZ1q4n/Bvw=;
        b=PUPIKZbEI+Wg/7WEmEi6Sz7hnQ1m0h5+cyax5Ax+DIJfNcLRL5zQGliiq+vftaD+hE
         W82bUb1pkCE+lPqQzcJ8GgfeZvp6umG/bQbPYG2HPoChCB05utYA9n+AWMI3nrfqI2Ol
         q98n1eY+J2yfUCEBHM9Y/A5AA35fyoVX9IIqOR8Az5VqS9nhpKjf3D8kDn/uBwOM0l8K
         R76NaTO0RTXxYUHN8iZl0h9QLdzFgFmomecOjiEMCOvbbT/tS4ZlVESt49g4eyM6MUFd
         fDoGs/FgUjR/c553rGre6ONGIAyauzejW2dzZFxqiHm0H9Ie21jtAOllXxvwalbm1hMs
         oBNA==
X-Gm-Message-State: ANhLgQ2rvcpW/lWgps0DLhGiDP+8iNsWl2FGbiqCWRNJ9+6RJO1V3xCp
        nHGJdyU4Zn7X5MgCBUcPrYNIXLDPrPkmF6AGa9Cfpfrw4po=
X-Google-Smtp-Source: ADFU+vuB7L2HUb1i+bmixGUr4XNwKTkeerY/THkgSV70b+AvmmYexUusyAJuJ3H6lfOlHIv7gap3vHv3Jeq3qSWNHXk=
X-Received: by 2002:a05:6214:1467:: with SMTP id c7mr1246909qvy.122.1583310841976;
 Wed, 04 Mar 2020 00:34:01 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dd909105a002ebe6@google.com> <CACT4Y+ZyhwEsuGK9aJZ=4vXJ_AfHqFn6n5d58H_5E_-o9qHRWA@mail.gmail.com>
 <01d56a46-2ed1-9953-9824-f32e778beea4@moonlit-rail.com> <60c24894-f0ab-fb41-b0f3-e6c9f940a955@moonlit-rail.com>
In-Reply-To: <60c24894-f0ab-fb41-b0f3-e6c9f940a955@moonlit-rail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Mar 2020 09:33:50 +0100
Message-ID: <CACT4Y+ZqVOHSa+xrOXF+cOwuB_1_q-6+Z5A2SqKw_D1hT2mbQQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_keyctl
To:     Kris Karas <linux-1993@moonlit-rail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 9:32 AM Kris Karas <linux-1993@moonlit-rail.com> wrote:
>
> Dmitry Vyukov wrote:
> > syzbot wrote:
> >> Call Trace:
> >>   <IRQ>
> >>   __dump_stack lib/dump_stack.c:77 [inline]
> >>   dump_stack+0x197/0x210 lib/dump_stack.c:118
> >>   nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
> >>   nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
> >>   arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
> >>   trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
> >>   rcu_dump_cpu_stacks+0x183/0x1cf kernel/rcu/tree_stall.h:254
> >>   print_cpu_stall kernel/rcu/tree_stall.h:475 [inline]
> >>   check_cpu_stall kernel/rcu/tree_stall.h:549 [inline]
> >>   rcu_pending kernel/rcu/tree.c:3030 [inline]
> >>   rcu_sched_clock_irq.cold+0x51a/0xc37 kernel/rcu/tree.c:2276
> >>   update_process_times+0x2d/0x70 kernel/time/timer.c:1726
> >>   tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:171
> >>   tick_sched_timer+0x53/0x140 kernel/time/tick-sched.c:1314
> >>   __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
> >>   __hrtimer_run_queues+0x364/0xe40 kernel/time/hrtimer.c:1579
> >>   hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1641
> >>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1119 [inline]
> >>   smp_apic_timer_interrupt+0x160/0x610 arch/x86/kernel/apic/apic.c:1144
> >>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
> >>   </IRQ>
> >>
> > +lib/mpi maintainers
> >
> > I wonder if this can also be triggered by remote actors (tls, wifi, usb, etc).
> >
>
> This looks somewhat similar to an OOPS + rcu stall I reported earlier in
> reply to Greg KH's announcement of 5.5.7:
>
>         rcu: INFO: rcu_sched self-detected stall on CPU
>         rcu:    14-....: (20999 ticks this GP) idle=216/1/0x4000000000000002 softirq=454/454 fqs=5250
>                 (t=21004 jiffies g=-755 q=1327)
>         NMI backtrace for cpu 14
>         CPU: 14 PID: 520 Comm: pidof Tainted: G      D           5.5.7 #1
>         Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X470 Taichi, BIOS P3.50 07/18/2019
>         Call Trace:
>          <IRQ>
>          dump_stack+0x50/0x70
>          nmi_cpu_backtrace.cold+0x14/0x53
>          ? lapic_can_unplug_cpu.cold+0x44/0x44
>          nmi_trigger_cpumask_backtrace+0x7b/0x88
>          rcu_dump_cpu_stacks+0x7b/0xa9
>          rcu_sched_clock_irq.cold+0x152/0x39b
>          update_process_times+0x1f/0x50
>          tick_sched_timer+0x40/0x90
>          ? tick_sched_do_timer+0x50/0x50
>          __hrtimer_run_queues+0xdd/0x180
>          hrtimer_interrupt+0x108/0x230
>          smp_apic_timer_interrupt+0x53/0xa0
>          apic_timer_interrupt+0xf/0x20
>          </IRQ>
>
> I don't have a reproducer for it, either.  It showed up in 5.5.7 (but
> might be from earlier as it reproduces so infrequently).
>
> Kris

Hi Kris,

Please re-send this to full To/Cc list. Nobody reads LKML/syzbot per se.
