Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FEBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F922207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgEOIrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:47:47 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:44103 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgEOIrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:47:46 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 430FBF8391
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:47:43 +0100 (IST)
Received: (qmail 17997 invoked from network); 15 May 2020 08:47:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 May 2020 08:47:42 -0000
Date:   Fri, 15 May 2020 09:47:40 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jirka Hladky <jhladky@redhat.com>, Phil Auld <pauld@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200515084740.GJ3758@techsingularity.net>
References: <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200514153122.GE2978@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 05:31:22PM +0200, Peter Zijlstra wrote:
> On Wed, May 13, 2020 at 04:30:23PM +0100, Mel Gorman wrote:
> > Complete shot in the dark but restore adjust_numa_imbalance() and try
> > this
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 1a9983da4408..0b31f4468d5b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2393,7 +2393,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
> >  	struct rq_flags rf;
> >  
> >  #if defined(CONFIG_SMP)
> > -	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
> > +	if (sched_feat(TTWU_QUEUE)) {
> 
> just saying that this has the risk of regressing other workloads, see:
> 
>   518cd6234178 ("sched: Only queue remote wakeups when crossing cache boundaries")
> 

Sure, I didn't really think that this was appropriate but it was the best I
had at the time. This can be a lot more targetted but it took me a while
to put together a picture as it was difficult for me to analyse. I was
going to post this as a seperate RFC but given this thread, what do you
think of this?

---8<---
sched: Wake cache-local tasks via wake_list if wakee CPU is polling

There are two separate method for waking a task from idle, one for
tasks running on CPUs that share a cache and one for when the caches are
separate. The methods can loosely be called local and remote even though
this is not directly related to NUMA and instead is due to the expected
cost of accessing data that is cache-hot on another CPU. The "local" costs
are expected to be relatively cheap as they share the LLC in comparison to
a remote IPI that is potentially required when using the "remote" wakeup.
The problem is that the local wakeup is not always cheaper and it appears
to have degraded even further around the 4.19 mark.

There appears to be a couple of reasons why it can be slower.

The first is specific to pairs of tasks where one or both rapidly enters
idle. For example, on netperf UDP_STREAM, the client sends a bunch of
packets, wakes the server, the server processes some packets and goes
back to sleep. There is a relationship between the tasks but it's not
strictly synchronous. The timing is different if the client/server are on
separate NUMA nodes and netserver is more likely to enter idle (measured
as server entering idle 10% more times when tasks are local vs remote
but machine-specific). However, the wakeups are so rapid that the wakeup
happens while the server is descheduling. That forces the waker to spin
on smp_cond_load_acquire for longer. In this case, it can be cheaper to
add the task to the rq->wake_list even if that potentially requires an IPI.

The second is that the local wakeup path is simply not always
that fast. Using ftrace, the cost of the locks, update_rq_clock and
ttwu_do_activate was measured as roughly 4.5 microseconds. While it's
a single instance, the cost of the "remote" wakeup for try_to_wake_up
was roughly 2.5 microseconds versus 6.2 microseconds for the "fast" local
wakeup. When there are tens of thousands of wakeups per second, these costs
accumulate and manifest as a throughput regression in netperf UDP_STREAM.

The essential difference in costs comes down to whether the CPU is fully
idle, a task is descheduling or polling in poll_idle(). This patch
special cases ttwu_queue() to use the "remote" method if the CPUs
task is polling as it's generally cheaper to use the wake_list in that
case than the local method because an IPI should not be required. As it is
race-prone, a reschedule IPI may still be sent but in that case the local
wakeup would also have to send a reschedule IPI so it should be harmless.

The benefit is not universal as it requires the specific pattern of wakeups
that happen when the wakee is likely to be descheduling. netperf UDP_STREAM
is one of the more obvious examples and it is more obvious since the
load balancer was reconciled and the client and server are more likely to
be running on the same NUMA node which is why it was missed for so long.

netperf-udp
                                  5.7.0-rc5              5.7.0-rc5
                                    vanilla          wakelist-v1r1
Hmean     send-64         211.25 (   0.00%)      228.61 *   8.22%*
Hmean     send-128        413.49 (   0.00%)      458.00 *  10.77%*
Hmean     send-256        786.31 (   0.00%)      879.30 *  11.83%*
Hmean     send-1024      3055.75 (   0.00%)     3429.45 *  12.23%*
Hmean     send-2048      6052.79 (   0.00%)     6878.99 *  13.65%*
Hmean     send-3312      9208.09 (   0.00%)    10832.19 *  17.64%*
Hmean     send-4096     11268.45 (   0.00%)    12968.39 *  15.09%*
Hmean     send-8192     17943.12 (   0.00%)    19886.07 *  10.83%*
Hmean     send-16384    29732.94 (   0.00%)    32297.44 *   8.63%*
Hmean     recv-64         211.25 (   0.00%)      228.61 *   8.22%*
Hmean     recv-128        413.49 (   0.00%)      458.00 *  10.77%*
Hmean     recv-256        786.31 (   0.00%)      879.30 *  11.83%*
Hmean     recv-1024      3055.75 (   0.00%)     3429.45 *  12.23%*
Hmean     recv-2048      6052.79 (   0.00%)     6878.99 *  13.65%*
Hmean     recv-3312      9208.09 (   0.00%)    10832.19 *  17.64%*
Hmean     recv-4096     11268.45 (   0.00%)    12968.39 *  15.09%*
Hmean     recv-8192     17943.12 (   0.00%)    19886.06 *  10.83%*
Hmean     recv-16384    29731.75 (   0.00%)    32296.08 *   8.62%*

It's less obvious on something like TCP_STREAM as there is a stricter
relationship between the client and server but with the patch, it's
much less variable

netperf-tcp
                             5.7.0-rc5              5.7.0-rc5
                               vanilla          wakelist-v1r1
Hmean     64         769.28 (   0.00%)      779.96 *   1.39%*
Hmean     128       1497.54 (   0.00%)     1509.33 *   0.79%*
Hmean     256       2806.00 (   0.00%)     2787.59 (  -0.66%)
Hmean     1024      9700.80 (   0.00%)     9720.02 (   0.20%)
Hmean     2048     17071.28 (   0.00%)    16968.92 (  -0.60%)
Hmean     3312     22976.20 (   0.00%)    23012.80 (   0.16%)
Hmean     4096     25885.74 (   0.00%)    26152.49 *   1.03%*
Hmean     8192     34014.83 (   0.00%)    33878.67 (  -0.40%)
Hmean     16384    39482.14 (   0.00%)    40307.22 (   2.09%)
Stddev    64           2.60 (   0.00%)        0.17 (  93.31%)
Stddev    128          3.69 (   0.00%)        1.52 (  58.97%)
Stddev    256         31.06 (   0.00%)       14.76 (  52.47%)
Stddev    1024        96.50 (   0.00%)       46.43 (  51.89%)
Stddev    2048       115.98 (   0.00%)       62.59 (  46.03%)
Stddev    3312       293.28 (   0.00%)       41.92 (  85.71%)
Stddev    4096       173.45 (   0.00%)      123.19 (  28.98%)
Stddev    8192       783.59 (   0.00%)      129.62 (  83.46%)
Stddev    16384     1012.37 (   0.00%)      252.08 (  75.10%)

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..59077c7c6660 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2380,13 +2380,32 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 	struct rq_flags rf;
 
 #if defined(CONFIG_SMP)
-	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
+	if (sched_feat(TTWU_QUEUE)) {
+		/*
+		 * A remote wakeup is often expensive as can require
+		 * an IPI and the wakeup path is slow. However, in
+		 * the specific case where the target CPU is idle
+		 * and polling, the CPU is active and rapidly checking
+		 * if a reschedule is needed. In this case, the idle
+		 * task just needs to be marked for resched and p
+		 * will rapidly be requeued which is less expensive
+		 * than the direct wakeup path.
+		 */
+		if (cpus_share_cache(smp_processor_id(), cpu)) {
+			struct thread_info *ti = task_thread_info(p);
+			typeof(ti->flags) val = READ_ONCE(ti->flags);
+
+			if (val & _TIF_POLLING_NRFLAG)
+				goto activate;
+		}
+
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
 		ttwu_queue_remote(p, cpu, wake_flags);
 		return;
 	}
 #endif
 
+activate:
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 	ttwu_do_activate(rq, p, wake_flags, &rf);
