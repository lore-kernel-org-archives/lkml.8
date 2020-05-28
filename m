Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FF1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4332074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389863AbgE1MqS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389783AbgE1MqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:46:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B75206F1;
        Thu, 28 May 2020 12:46:16 +0000 (UTC)
Date:   Thu, 28 May 2020 08:46:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joerg Vehlow <lkml@jv-coder.de>
Cc:     linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in
 interrupt context
Message-ID: <20200528084614.0c949e8d@gandalf.local.home>
In-Reply-To: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Joerg,

This does look like Andrew's commit (from 2008) is buggy (and this is a
mainline bug, not an RT one). (top posting this so Andrew knows to look
further ;-)

On Thu, 28 May 2020 13:41:08 +0200
Joerg Vehlow <lkml@jv-coder.de> wrote:

> Hi,
> 
> I think I found a bug in the kernel with rt patches (or maybe even without).
> This applies to all kernels propably starting at 2.6.27.
> 
> When a kernel panic is triggered from an interrupt handler, the dump-capture
> kernel is not started, instead the system acts as if it was not installed.
> The reason for this is, that panic calls __crash_kexec, which is protected
> by a mutex. On an rt kernel this mutex is an rt mutex and when trylock 
> is called
> on an rt mutex, the first check is whether the current kthread is in an 
> nmi or
> irq handler. If it is, the function just returns 0 -> locking failed.
> 
> According to rt_mutex_trylock documentation, it is not allowed to call this
> function from an irq handler, but panic can be called from everywhere 
> and thus
> rt_mutex_trylock can be called from everywhere. Actually even 
> mutex_trylock has
> the comment, that it is not supposed to be used from interrupt context, 
> but it
> still locks the mutex. I guess this could also be a bug in the non-rt 
> kernel.
> 
> I found this problem using a test module, that triggers the softlock 
> detection.
> It is a pretty simple module, that creates a kthread, that disables 
> preemption,
> spins 60 seconds in an endless loop and then reenables preemption and 
> terminates
> the thread. This reliably triggers the softlock detection and if
> kernel.softlockup_panic=0, the system resumes perfectly fine afterwards. If
> kernel.softlockup_panic=1 I would expect the dump-capture kernel to be 
> executed,
> but it is not due to the bug (without rt patches it works), instead the 
> panic
> function is executed until the end to the endless loop.
> 
> 
> A stacktrace captured at the trylock call inside kexec_code looks like this:
> #0  __rt_mutex_trylock (lock=0xffffffff81701aa0 <kexec_mutex>) at 
> /usr/src/kernel/kernel/locking/rtmutex.c:2110
> #1  0xffffffff8087601a in _mutex_trylock (lock=<optimised out>) at 
> /usr/src/kernel/kernel/locking/mutex-rt.c:185
> #2  0xffffffff803022a0 in __crash_kexec (regs=0x0 <irq_stack_union>) at 
> /usr/src/kernel/kernel/kexec_core.c:941
> #3  0xffffffff8027af59 in panic (fmt=0xffffffff80fa3d66 "softlockup: 
> hung tasks") at /usr/src/kernel/kernel/panic.c:198
> #4  0xffffffff80325b6d in watchdog_timer_fn (hrtimer=<optimised out>) at 
> /usr/src/kernel/kernel/watchdog.c:464
> #5  0xffffffff802e6b90 in __run_hrtimer (flags=<optimised out>, 
> now=<optimised out>, timer=<optimised out>, base=<optimised out>, 
> cpu_base=<optimised out>) at /usr/src/kernel/kernel/time/hrtimer.c:1417
> #6  __hrtimer_run_queues (cpu_base=0xffff88807db1c000, now=<optimised 
> out>, flags=<optimised out>, active_mask=<optimised out>) at   
> /usr/src/kernel/kernel/time/hrtimer.c:1479
> #7  0xffffffff802e7704 in hrtimer_interrupt (dev=<optimised out>) at 
> /usr/src/kernel/kernel/time/hrtimer.c:1539
> #8  0xffffffff80a020f2 in local_apic_timer_interrupt () at 
> /usr/src/kernel/arch/x86/kernel/apic/apic.c:1067
> #9  smp_apic_timer_interrupt (regs=<optimised out>) at 
> /usr/src/kernel/arch/x86/kernel/apic/apic.c:1092
> #10 0xffffffff80a015df in apic_timer_interrupt () at 
> /usr/src/kernel/arch/x86/entry/entry_64.S:909
> 
> 
> Obviously and as expected the panic was triggered in the context of the apic
> interrupt. So in_irq() is true and trylock fails.
> 
> 
> About 12 years ago this was not implemented using a mutex, but using xchg.
> See: 8c5a1cf0ad3ac5fcdf51314a63b16a440870f6a2

Yes, that commit is wrong, because mutex_trylock() is not to be taken in
interrupt context, where crash_kexec() looks like it can be called.

Unless back then crash_kexec() wasn't called in interrupt context, then the
commit that calls it from that combined with this commit is the issue.

-- Steve

> 
> 
> Since my knowledege about mutexes inside the kernel is very limited, I 
> do not
> know how this can be fixed and whether it should be fixed in the rt 
> patches or
> if this really is a bug in mainline kernel (because trylock is also not 
> allowed
> to be used in interrupt handlers.
> 
> 
> Jörg

