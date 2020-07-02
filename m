Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C7DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB7620772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgGBVgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:36:32 -0400
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:44775 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725915AbgGBVgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:36:31 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id DE5161C4194
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 22:36:29 +0100 (IST)
Received: (qmail 19253 invoked from network); 2 Jul 2020 21:36:29 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.202])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Jul 2020 21:36:29 -0000
Date:   Thu, 2 Jul 2020 22:36:27 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        peterz@infradead.org, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200702213627.GF3183@techsingularity.net>
References: <20200702171548.GA11813@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200702171548.GA11813@codemonkey.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:15:48PM -0400, Dave Jones wrote:
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
> producing bogus results from over-eager 'good', but the last two runs
> both implicated this commit:
> 
> commit c6e7bd7afaeb3af55ffac122828035f1c01d1d7b (refs/bisect/bad)
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Sun May 24 21:29:55 2020 +0100
> 
>     sched/core: Optimize ttwu() spinning on p->on_cpu
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

Peter, I'm not supremely confident about this but could it be because
"p->sched_contributes_to_load = !!task_contributes_to_load(p)" potentially
happens while a task is still being dequeued? In the final stages of a
task switch we have

        prev_state = prev->state;
        vtime_task_switch(prev);
        perf_event_task_sched_in(prev, current);
        finish_task(prev);

finish_task is when p->on_cpu is cleared after the state is updated.
With the patch, we potentially update sched_contributes_to_load while
p->state is transient so if the check below is true and ttwu_queue_wakelist
is used then sched_contributes_to_load was based on a transient value
and potentially wrong.

        if (smp_load_acquire(&p->on_cpu) &&
            ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
                goto unlock;

sched_contributes_to_load determines the value of rq->uninterruptible
which is used in the load value so it's a partial fit. The race would not
happen very often on a normal desktop so it would explain why it takes
a long time for the value to get screwed up and appears to fit.

I'm thinking that the !!task_contributes_to_load(p) should still happen
after smp_cond_load_acquire() when on_cpu is stable and the pi_lock is
held to stabilised p->state against a parallel wakeup or updating the
task rq. I do not see any hazards with respect to smp_rmb and the value
of p->state in this particular path but I've confused myself enough in
the various scheduler and wakeup paths that I don't want to bet money on
it late in the evening

It builds, not booted, it's for discussion but maybe Dave is feeling brave!

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca5db40392d4..52c73598b18a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2592,9 +2592,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	}
 
 #ifdef CONFIG_SMP
-	p->sched_contributes_to_load = !!task_contributes_to_load(p);
-	p->state = TASK_WAKING;
-
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
 	 * possible to, falsely, observe p->on_cpu == 0.
@@ -2650,6 +2647,13 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	smp_cond_load_acquire(&p->on_cpu, !VAL);
 
+	/*
+	 * p is off the cpu and pi_lock is held to p->state is stable
+	 * for calculating whether it contributes to load.
+	 */
+	p->sched_contributes_to_load = !!task_contributes_to_load(p);
+	p->state = TASK_WAKING;
+
 	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
 	if (task_cpu(p) != cpu) {
 		wake_flags |= WF_MIGRATED;

-- 
Mel Gorman
SUSE Labs
