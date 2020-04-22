Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4C4C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B72F2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgDVJCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:02:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:54334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgDVJCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:02:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19549ADE3;
        Wed, 22 Apr 2020 09:02:31 +0000 (UTC)
Message-ID: <1587546150.9537.84.camel@suse.cz>
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Harald Arnesen <harald@skogtun.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 22 Apr 2020 11:02:30 +0200
In-Reply-To: <20200421212347.GV2483@worktop.programming.kicks-ass.net>
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
         <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
         <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
         <20200421212347.GV2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Peter:

the panic seen by Harald Arnesen (and Dave Kleikamp) is unrelated to
virtualization, and happens on all machines that have a CPU with less than 4
physical cores. It's a very serious (and very stupid) bug in the original
version of my code and is fixed by patch 2/4 "x86, sched: Account for CPUs
with less than 4 cores in freq. invariance" in the series 

https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz

Harald, Dave:

for peace of mind, can you please share the output of

  turbostat --interval 1 sleep 0

from your machines? This should print a long list of power management-related
information, including your CPU model and the content of MSR_TURBO_RATIO_LIMIT.
In all likelihood that MSR says that the "4 cores turbo frequency" of your CPU
is zero, and the buggy code divides by that value.

Harald:

I'll echo Linus' request of testing that the patch series linked above fixes
the problem on your machine. Since you're testing -rc kernels and bisecting
bugs I assume you're comfortable with patching and compiling kernels, but if
that is not the case I am more than happy to assist by providing either an RPM
or a DEB package, depending on the distribution you're running. Let me know.

More comments below.

On Tue, 2020-04-21 at 23:23 +0200, Peter Zijlstra wrote:
> On Tue, Apr 21, 2020 at 12:03:10PM -0700, Linus Torvalds wrote:
> > On Mon, Apr 20, 2020 at 1:52 AM Harald Arnesen <harald@skogtun.org> wrote:
> > > 
> > > Neither rc1 nor rc2 will boot on my laptop. The attached picture is all
> > > I have been able to capture.
> > 
> > I know you saw the reply about this probably being fixed by
> > 
> >   https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/
> > 
> > but it would be lovely if you could actually verify that that series
> > of four patches does indeed fix it for you.
> 
> (not seeing the original report in the archives or my list copy)
> 
> I'm assuming it's some sort of dodgy virt setup, actual real proper
> hardware should never get here like that.

I think Peter is mentioning virtualization because in another patch of my
bugfix series I address a separate issue, indeed arising in hypervisors:
patch 1/4 "x86, sched: Bail out of frequency invariance if base frequency is
unknown".

The thing is that my original code does two divisions (just grep for "div" in
the patch 1567c3e3467c "x86, sched: Add support for frequency invariance").
One of them divides by zero when num_cpus < 4, the other divides by zero on
some hypervisors (basically).

Here are the incriminated statements (file arch/x86/kernel/smpboot.c):

  (1)  arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
                                       base_freq);
       /* ... stuff ... */
       
       mcnt *= arch_max_freq_ratio;
  (2)  freq_scale = div64_u64(acnt, mcnt);

Hypervisors:
If base_freq is zero, division (1) fails. This is addressed by patch 1/4 in the
bugfix series linked above. base_freq is read from MSR_PLATFORM_INFO (no BIOS
involved, it's straight from the CPU) and is the max CPU clock frequency
without counting turbo. The Intel SDM specifies this MSR's content, none of the
machines I tested said "my base clock frequency is zero", but I didn't think
of hypervisors.

Small machines:
If turbo_freq is zero, division (2) fails. This is addressed by patch 2/4
"x86, sched: Account for CPUs with less than 4 cores in freq. invariance".
I read turbo_freq from MSR_TURBO_RATIO_LIMIT (again: no BIOS involved), at a
specific offset where it should contain the clock frequency sustainable by 4
cores simultaneously. If the machines has less than for cores, this data is
rightfully zero and thus the panic that Harald Arnesen and Dave Kleikamp
observed. It's an embarrassing mistake I made, I tested on several machines
including a consumer-level Atom Airmont (Dell Wyse thin client) but all had at
least 4 cores so I didn't see it.

For the records: there is a report for the "small machines" div-by-zero bug
from a 24 core Atom P-Series (new product line from 2020), but the fix works
on that machine, see
https://lore.kernel.org/lkml/bf43772d-48e5-01d4-dd03-330110e487fa@linux.intel.com/

> 
> > Your oops is on that divide instruction:
> > 
> >         freq_scale = div64_u64(acnt, mcnt);
> > 
> > and while we had a check for mcnt not being zero earlier, we did
> > 
> >         mcnt *= arch_max_freq_ratio;
> > 
> > after that check. I could see it becoming zero either due to an
> > overflow, or due to arch_max_freq_ratio being 0.
> 
> Right, so that's not supposed to happen, as you say, we should not
> enable this code if the ratio is 0, and we should not overflow mcnt due
> to reading that reg once per tick.
> 
> But yeha, virt, anything can happen :/
> 
> > I think the first commit in that series is supposed to fix that
> > arch_max_freq_ratio being 0 case, but it still feels like the code
> > that does the divide is checking for zero in the wrong place...
> 
> Yeah, we can certainly modify that. As is, real actual hardware should
> never even hit that case either. So we might as well move that check and
> then also make it disable all this frequency scaling stuff if we ever do
> hit it.

I'm going to send the following patch. There are a number of reasons why mcnt
overflowing and landing exactly at zero is unlikely (we read MPERF once every
tick, and arch_max_freq_ratio is a small number) but it's still a real problem
(eg. tickless kernels) and the zero check is 4 lines above where it should be,
it just needs to move down.

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8c89e4d9ad28..fb71395cbcad 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2055,14 +2055,14 @@ void arch_scale_freq_tick(void)
 
        acnt = aperf - this_cpu_read(arch_prev_aperf);
        mcnt = mperf - this_cpu_read(arch_prev_mperf);
-       if (!mcnt)
-               return;
 
        this_cpu_write(arch_prev_aperf, aperf);
        this_cpu_write(arch_prev_mperf, mperf);
 
        acnt <<= 2*SCHED_CAPACITY_SHIFT;
        mcnt *= arch_max_freq_ratio;
+       if (!mcnt)
+               return;
 
        freq_scale = div64_u64(acnt, mcnt);



Giovanni
