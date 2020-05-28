Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5210C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A46C2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jv-coder.de header.i=@jv-coder.de header.b="NxXBPn8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbgE1Lvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:51:31 -0400
Received: from mail.jv-coder.de ([5.9.79.73]:45294 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388480AbgE1Lv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:51:29 -0400
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 07:51:28 EDT
Received: from [192.168.178.40] (unknown [188.192.1.13])
        by mail.jv-coder.de (Postfix) with ESMTPSA id E0CECA3440;
        Thu, 28 May 2020 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1590666063; bh=WXDcfwZSvWW9FRRstQ/LEdAer2SgJFTyaVpYap2AsCM=;
        h=To:From:Subject:Message-ID:Date:MIME-Version;
        b=NxXBPn8SA6q5GXMYZUMoqF61RuAezvi8W7SvY0Do8AnVGL0EOxTlLcDwykFKXtO7j
         Qse4MvfR3KYkzkWmZlTyarv7VCJnXyTnola52jD42GuJD1mvJ8tdFATDmgqIrGp1rD
         9/yvbRZKuSiuTs2rcgdYWPfhbVOwoQp/PYuWbqUs=
To:     linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
From:   Joerg Vehlow <lkml@jv-coder.de>
Subject: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
Message-ID: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
Date:   Thu, 28 May 2020 13:41:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I found a bug in the kernel with rt patches (or maybe even without).
This applies to all kernels propably starting at 2.6.27.

When a kernel panic is triggered from an interrupt handler, the dump-capture
kernel is not started, instead the system acts as if it was not installed.
The reason for this is, that panic calls __crash_kexec, which is protected
by a mutex. On an rt kernel this mutex is an rt mutex and when trylock 
is called
on an rt mutex, the first check is whether the current kthread is in an 
nmi or
irq handler. If it is, the function just returns 0 -> locking failed.

According to rt_mutex_trylock documentation, it is not allowed to call this
function from an irq handler, but panic can be called from everywhere 
and thus
rt_mutex_trylock can be called from everywhere. Actually even 
mutex_trylock has
the comment, that it is not supposed to be used from interrupt context, 
but it
still locks the mutex. I guess this could also be a bug in the non-rt 
kernel.

I found this problem using a test module, that triggers the softlock 
detection.
It is a pretty simple module, that creates a kthread, that disables 
preemption,
spins 60 seconds in an endless loop and then reenables preemption and 
terminates
the thread. This reliably triggers the softlock detection and if
kernel.softlockup_panic=0, the system resumes perfectly fine afterwards. If
kernel.softlockup_panic=1 I would expect the dump-capture kernel to be 
executed,
but it is not due to the bug (without rt patches it works), instead the 
panic
function is executed until the end to the endless loop.


A stacktrace captured at the trylock call inside kexec_code looks like this:
#0  __rt_mutex_trylock (lock=0xffffffff81701aa0 <kexec_mutex>) at 
/usr/src/kernel/kernel/locking/rtmutex.c:2110
#1  0xffffffff8087601a in _mutex_trylock (lock=<optimised out>) at 
/usr/src/kernel/kernel/locking/mutex-rt.c:185
#2  0xffffffff803022a0 in __crash_kexec (regs=0x0 <irq_stack_union>) at 
/usr/src/kernel/kernel/kexec_core.c:941
#3  0xffffffff8027af59 in panic (fmt=0xffffffff80fa3d66 "softlockup: 
hung tasks") at /usr/src/kernel/kernel/panic.c:198
#4  0xffffffff80325b6d in watchdog_timer_fn (hrtimer=<optimised out>) at 
/usr/src/kernel/kernel/watchdog.c:464
#5  0xffffffff802e6b90 in __run_hrtimer (flags=<optimised out>, 
now=<optimised out>, timer=<optimised out>, base=<optimised out>, 
cpu_base=<optimised out>) at /usr/src/kernel/kernel/time/hrtimer.c:1417
#6  __hrtimer_run_queues (cpu_base=0xffff88807db1c000, now=<optimised 
out>, flags=<optimised out>, active_mask=<optimised out>) at 
/usr/src/kernel/kernel/time/hrtimer.c:1479
#7  0xffffffff802e7704 in hrtimer_interrupt (dev=<optimised out>) at 
/usr/src/kernel/kernel/time/hrtimer.c:1539
#8  0xffffffff80a020f2 in local_apic_timer_interrupt () at 
/usr/src/kernel/arch/x86/kernel/apic/apic.c:1067
#9  smp_apic_timer_interrupt (regs=<optimised out>) at 
/usr/src/kernel/arch/x86/kernel/apic/apic.c:1092
#10 0xffffffff80a015df in apic_timer_interrupt () at 
/usr/src/kernel/arch/x86/entry/entry_64.S:909


Obviously and as expected the panic was triggered in the context of the apic
interrupt. So in_irq() is true and trylock fails.


About 12 years ago this was not implemented using a mutex, but using xchg.
See: 8c5a1cf0ad3ac5fcdf51314a63b16a440870f6a2


Since my knowledege about mutexes inside the kernel is very limited, I 
do not
know how this can be fixed and whether it should be fixed in the rt 
patches or
if this really is a bug in mainline kernel (because trylock is also not 
allowed
to be used in interrupt handlers.


Jörg
