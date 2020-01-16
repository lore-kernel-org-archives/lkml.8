Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D12C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D90A2192A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbgAPQ5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:57:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52553 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733266AbgAPQ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:57:42 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is8SZ-0005b9-2I; Thu, 16 Jan 2020 17:57:31 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0053B101226; Thu, 16 Jan 2020 17:57:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] watchdog: Fix possible soft lockup warning at bootup
In-Reply-To: <20200116151146.wn6ec7igl2bfk4c2@rric.localdomain>
References: <20200103151032.19590-1-longman@redhat.com> <87sgkgw3xq.fsf@nanos.tec.linutronix.de> <87blr3wrqw.fsf@nanos.tec.linutronix.de> <20200116151146.wn6ec7igl2bfk4c2@rric.localdomain>
Date:   Thu, 16 Jan 2020 17:57:29 +0100
Message-ID: <87tv4vuyo6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter <rrichter@marvell.com> writes:
> On 16.01.20 12:44:07, Thomas Gleixner wrote:
>> And looking at this with a more awake brain, the root cause is pretty
>> obvious.
>> 
>> sched_clock() advances by 24 seconds, but clock MONOTONIC on which the
>> watchdog timer is based does not. As the timestamps you printed have 7
>> trailing zeros, it's pretty clear that timekeeping is still jiffies
>> based at this point and HZ is set to 100.
>> 
>> So while bringing up the non-boot CPUs the boot CPU loses ~2000 timer
>> interrupts. That needs to be fixed and not papered over.
>
> I have looked into this back in December and observed the following
> soft lockups on cpu #15 to #155 (out of 224):
>
> [   22.697242] watchdog: BUG: soft lockup - CPU#15 stuck for 20s! [swapper/15:0]
> ...
> [   25.191382] watchdog: BUG: soft lockup - CPU#155 stuck for 11s! [swapper/155:0]
>
> The reason it starts at #15 is that this is the first cpu where the
> timer starts at 1 sec, cpus #1 to #14 have a value of 0 which is
> handled special (see watchdog_timer_fn(), if (touch_ts == 0) ...).
> Otherwise those cpus would also show the soft lockup.

Bah. That's broken to begin with, but trivial to fix. 

> The reason it stops after cpu #155 is that the boot process advanced
> (25 secs) so that watchdog_touch_ts is now updated properly.
>
> During secondary boot cpu bringup I have seen the hrtimer callback
> watchdog_timer_fn() running correctly. get_timestamp() is also

On all the upcoming CPUs?

> correct. But watchdog_touch_ts is not updated since softlockup_fn() is
> not running for more than 23 secs, it still keeps the original time
> from watchdog_enable() (e.g. 1 for cpu #15). So the high prio
> stop_worker thread which calls softlockup_fn() is not scheduled for
> some reason.  But it looks like scheduling starts around the time the
> primary cpu has scheduled all secondary cpus to become online
> (smp_init()).

So what prevents the stopper thread to run? It should be runnable right
after the point when the upcoming CPU reaches cpu_startup_entry(). The
stopper thread is unparked _before_ the hotplug thread on the upcoming
CPU is woken.

> So your theory the MONOTONIC clock runs differently/wrongly could
> explain that (assuming this drives the sched clock). Though, I am

No. sched_clock() is separate. It uses a raw timestamp (in your case
from the ARM arch timer) and converts it to something which is close to
proper time. So my assumption was based on the printout Waiman had:

 [ 1... ] CPU.... watchdog_fn now  170000000
 [ 25.. ] CPU.... watchdog_fn now 4170000000

I assumed that now comes from ktime_get() or something like
that. Waiman?

The printk timestamps come from sched_clock().

> wondering in what state the scheduler is until to the point it is
> finally starting to run, idle?

The scheduler is active right at the point where the upcoming CPU
reaches cpu_startup_entry()

> On the other side, could it be that the scheduler starts running only
> after the primary cpu finishs smp_init()? Meaning, if that takes
> longer than the soft_thresh we will see soft lockups?

No.

> Note: We have seen it in a bios change causing longer delays when
> executing the onlining of cpus by the fw call.

The onlining through the firmware call is just a tiny part of the
hotplug procedure. Hotplug does:

 Control CPU              Upcoming CPU

 prepare_stuff_for_cpu()
 kick_cpu_alive()         <- Firmware call, IPI, whatever

 wait_for_idle()
                          Low level init
                          cpu_startup_entry()
 unpark_stopper()
 kick_hotplug_thread()
                          thread context init

 wait_for_online()
                          final state reached

But IF the firmware call takes ages, then the boot CPU which is
responsible for timekeeping at this point might actually miss timer
interrupts en masse. Let's assume the firmware call takes one second and
we have HZ 100.

Real time  Kernel time   Context
0.0        0.0           firmware call
1.0        0.01          timer interrupt
                         hotplug stuff
1.01       0.02          timer interrupt
...                       
1.05       0.05          firmware call
2.05       0.06          timer interrupt

That sums up quickly. And that would obviously cause the watchdog timers
to expire late as well as they are based on kernel time.

If the watchdog timer then fires after a while, the timestamp is already
off by more than the threshold and the lockup detector triggers.

So yes, this would be a very reasonable explanation. Let's do the math
for Waiman's example:

While sched clock advanced by 24.4 seconds kernel time advanced only by
4 seconds.

The whole hotplug machinery takes:

 [    0.115632] CPU1: Booted secondary processor 0x0000000100 [0x431f0af1]
 [   27.177282] CPU223: Booted secondary processor 0x0000011b03 [0x431f0af1]

27 seconds, which means ~120ms per CPU. 

From the time delta we know that we lost ~2000 timer interrupts in 24.4
seconds, which is about 24.4 / 0.12 ~= 203 CPUs.

Now 2000 timer interrupts (HZ=100) are 20 seconds which means that the
firmware call took about 100ms (20/203) per CPU.

Waiman also said, that on a HPE machine the clock delta was observable
as well, but not as bad, which means the firmware call there is
significantly shorter.

Of course this cannot be observed on x86 because all x86 does to kick a
secondary CPU into life is to send an IPI to it.

Hmm?

Thanks,

        tglx
