Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D650C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6932070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgGBVRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:17:03 -0400
Received: from mail.windriver.com ([147.11.1.11]:51903 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBVRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:17:01 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 062LGABj018020
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 2 Jul 2020 14:16:10 -0700 (PDT)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 14:15:57 -0700
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 589E22E0BF2; Thu,  2 Jul 2020 17:15:57 -0400 (EDT)
Date:   Thu, 2 Jul 2020 17:15:57 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mgorman@techsingularity.net>,
        <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
CC:     Michal Kubecek <mkubecek@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200702211555.GA27819@windriver.com>
References: <20200702171548.GA11813@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200702171548.GA11813@codemonkey.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[weird loadavg on idle machine post 5.7] On 02/07/2020 (Thu 13:15) Dave Jones wrote:

> When I upgraded my firewall to 5.7-rc2 I noticed that on a mostly
> idle machine (that usually sees loadavg hover in the 0.xx range)
> that it was consistently above 1.00 even when there was nothing running.
> All that perf showed was the kernel was spending time in the idle loop
> (and running perf).
> 
> For the first hour or so after boot, everything seems fine, but over
> time loadavg creeps up, and once it's established a new baseline, it
> never seems to ever drop below that again.
> 
> One morning I woke up to find loadavg at '7.xx', after almost as many
> hours of uptime, which makes me wonder if perhaps this is triggered
> by something in cron.  I have a bunch of scripts that fire off
> every hour that involve thousands of shortlived runs of iptables/ipset,
> but running them manually didn't seem to automatically trigger the bug.
> 
> Given it took a few hours of runtime to confirm good/bad, bisecting this
> took the last two weeks. I did it four different times, the first

I've seen pretty much the same thing - I was helping paulmck test
rcu-dev for something hopefully unrelated, when I 1st saw it, and
assumed it came in with the sched-core merge and was using one under
that as "good" to attempt bisect.

> producing bogus results from over-eager 'good', but the last two runs

Yeah - it sucks.  I was using Paul's TREE03 rcu-torture for loading and
even after a two hour test I'd still get "false good" results.  Only
after 7h was I quite confident that good was really good.

> both implicated this commit:
> 
> commit c6e7bd7afaeb3af55ffac122828035f1c01d1d7b (refs/bisect/bad)
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Sun May 24 21:29:55 2020 +0100
> 
>     sched/core: Optimize ttwu() spinning on p->on_cpu

I was down to 10 commits roughly above and below this guy before hearing
you were working the same problem.

I just got this guy to reveal a false load after a 2h test as well.
I want to let the one underneath soak overnight just to also confirm it
is "good" - so that is pending.

What I can add, is that it is like we are "leaking" an instance into
calc_load_tasks -- which isn't anything new -- see when tglx fixed it
before in d60585c5766.  Unfortunate we don't have some low overhead leak
checks on that... ?

Anyway, if I "fix" the leak, then everything seems back to normal:

   (gdb) p calc_load_tasks
   $2 = {counter = 1}
   (gdb) set variable calc_load_tasks = { 0 }
   (gdb) p calc_load_tasks
   $4 = {counter = 0}
   (gdb) continue
   Continuing.
   
   [ ... watching decay on resumed target ....]
   
    10:13:14 up  9:54,  4 users,  load average: 0.92, 0.98, 1.15
    10:13:54 up  9:55,  4 users,  load average: 0.47, 0.86, 1.10
    10:15:17 up  9:56,  4 users,  load average: 0.12, 0.65, 1.00
    10:19:20 up 10:00,  4 users,  load average: 0.00, 0.28, 0.76
    10:26:07 up 10:07,  4 users,  load average: 0.00, 0.06, 0.48
    10:32:48 up 10:14,  4 users,  load average: 0.00, 0.00, 0.29

Obviously that isn't a fix, but it shows it is an accounting thing.
I've also used gdb to snoop all the cfs->avg fields and they look as
expected for a completely idle machine.  Nothing hiding in avg_rt or
avg_dl either.

>     
>     Both Rik and Mel reported seeing ttwu() spend significant time on:
>     
>       smp_cond_load_acquire(&p->on_cpu, !VAL);
>     
>     Attempt to avoid this by queueing the wakeup on the CPU that owns the
>     p->on_cpu value. This will then allow the ttwu() to complete without
>     further waiting.
>     
>     Since we run schedule() with interrupts disabled, the IPI is
>     guaranteed to happen after p->on_cpu is cleared, this is what makes it
>     safe to queue early.
>     
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>     Cc: Jirka Hladky <jhladky@redhat.com>
>     Cc: Vincent Guittot <vincent.guittot@linaro.org>
>     Cc: valentin.schneider@arm.com
>     Cc: Hillf Danton <hdanton@sina.com>
>     Cc: Rik van Riel <riel@surriel.com>
>     Link: https://lore.kernel.org/r/20200524202956.27665-2-mgorman@techsingularity.net
> 
> Unfortunatly it doesn't revert cleanly on top of rc3 so I haven't
> confirmed 100% that it's the cause yet, but the two separate bisects
> seem promising.

I've not tried the revert (yet) - but Kyle saw me boring people on
#kernel with the details of bisecting this and gave me the heads-up you
were looking at it too (thanks Kyle!).   So I figured I'd better add
what I'd seen so far.

I'm testing with what is largely a defconfig, plus KVM_INTEL (needed for
paulmck TREE03 rcu-torture), plus I enabled KGDB and DEBUG_INFO after a
while so I could poke and prod - but was reproducing it before that.

For completeness, the test was:

  tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 24 --duration 120 \
	--configs TREE03 --trust-make

...on a 24 core 2013 vintage xeon-v2 COTS box.   As above, the 120m
seemed to give between 60-75% confidence on not getting a false good.

Anyway - so that is all I know so far...

Paul.
--

> 
> I don't see any obvious correlation between what's changing there and
> the symtoms (other than "scheduler magic") but maybe those closer to
> this have ideas what could be going awry ?
> 
> 	Dave
