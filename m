Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4CCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D482B2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgEVN3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:29:00 -0400
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:45140 "EHLO
        outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728898AbgEVN27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:28:59 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id C095BCCAFB
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:28:56 +0100 (IST)
Received: (qmail 7197 invoked from network); 22 May 2020 13:28:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 May 2020 13:28:56 -0000
Date:   Fri, 22 May 2020 14:28:54 +0100
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
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>,
        riel@surriel.com
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200522132854.GF7167@techsingularity.net>
References: <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
 <20200515111732.GS2957@hirez.programming.kicks-ass.net>
 <20200515142444.GK3001@hirez.programming.kicks-ass.net>
 <20200521103816.GA7167@techsingularity.net>
 <20200521114132.GI325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200521114132.GI325280@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 01:41:32PM +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2020 at 11:38:16AM +0100, Mel Gorman wrote:
> > IIUC, this patch front-loads as much work as possible before checking if
> > the task is on_rq and then the waker/wakee shares a cache, queue task on
> > the wake_list and otherwise do a direct wakeup.
> > 
> > The advantage is that spinning is avoided on p->on_rq when p does not
> > share a cache. The disadvantage is that it may result in tasks being
> > stacked but this should only happen when the domain is overloaded and
> > select_task_eq() is unlikely to find an idle CPU. The load balancer would
> > soon correct the situation anyway.
> > 
> > In terms of netperf for my testing, the benefit is marginal because the
> > wakeups are primarily between tasks that share cache. It does trigger as
> > perf indicates that some time is spent in ttwu_queue_remote with this
> > patch, it's just that the overall time spent spinning on p->on_rq is
> > very similar. I'm still waiting on other workloads to complete to see
> > what the impact is.
> 
> So it might make sense to play with the exact conditions under which
> we'll attempt this remote queue, if we see a large 'local' p->on_cpu
> spin time, it might make sense to attempt the queue even in this case.
> 
> We could for example change it to:
> 
> 	if (REAC_ONCE(p->on_cpu) && ttwu_queue_remote(p, cpu, wake_flags | WF_ON_CPU))
> 		goto unlock;
> 
> and then use that in ttwu_queue_remote() to differentiate between these
> two cases.
> 

>  #endif /* CONFIG_SMP */
>  
>  	ttwu_queue(p, cpu, wake_flags);

Is something like this on top of your patch what you had in mind?

---8<---

---
 kernel/sched/core.c  | 35 ++++++++++++++++++++++++++---------
 kernel/sched/sched.h |  3 ++-
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 987b8ecf2ee9..435ecf5820ee 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2330,13 +2330,19 @@ void scheduler_ipi(void)
 	irq_exit();
 }
 
-static void __ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+/*
+ * Queue a task on the target CPUs wake_list and wake the CPU via IPI if
+ * necessary. The wakee CPU on receipt of the IPI will queue the task
+ * via sched_ttwu_wakeup() for activation instead of the waking task
+ * activating and queueing the wakee.
+ */
+static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
 
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
-	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
+	if (llist_add(&p->wake_entry, &rq->wake_list)) {
 		if (!set_nr_if_polling(rq->idle))
 			smp_send_reschedule(cpu);
 		else
@@ -2373,12 +2379,23 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
-static bool ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
-	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
-		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
-		__ttwu_queue_remote(p, cpu, wake_flags);
-		return true;
+	if (sched_feat(TTWU_QUEUE)) {
+		/*
+		 * If CPU does not share cache then queue the task on the remote
+		 * rqs wakelist to avoid accessing remote data. Alternatively,
+		 * if the task is descheduling and the only running task on the
+		 * CPU then use the wakelist to offload the task activation to
+		 * the CPU that will soon be idle so the waker can continue.
+		 * nr_running is checked to avoid unnecessary task stacking.
+		 */
+		if (!cpus_share_cache(smp_processor_id(), cpu) ||
+		    ((wake_flags & WF_ON_RQ) && cpu_rq(cpu)->nr_running <= 1)) {
+			sched_clock_cpu(cpu); /* Sync clocks across CPUs */
+			__ttwu_queue_wakelist(p, cpu, wake_flags);
+			return true;
+		}
 	}
 
 	return false;
@@ -2391,7 +2408,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 	struct rq_flags rf;
 
 #if defined(CONFIG_SMP)
-	if (ttwu_queue_remote(p, cpu, wake_flags))
+	if (ttwu_queue_wakelist(p, cpu, wake_flags))
 		return;
 #endif
 
@@ -2611,7 +2628,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * let the waker make forward progress. This is safe because IRQs are
 	 * disabled and the IPI will deliver after on_cpu is cleared.
 	 */
-	if (READ_ONCE(p->on_cpu) && ttwu_queue_remote(p, cpu, wake_flags))
+	if (READ_ONCE(p->on_cpu) && ttwu_queue_wakelist(p, cpu, wake_flags | WF_ON_RQ))
 		goto unlock;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..06297d1142a0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1688,7 +1688,8 @@ static inline int task_on_rq_migrating(struct task_struct *p)
  */
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
 #define WF_FORK			0x02		/* Child wakeup after fork */
-#define WF_MIGRATED		0x4		/* Internal use, task got migrated */
+#define WF_MIGRATED		0x04		/* Internal use, task got migrated */
+#define WF_ON_RQ		0x08		/* Wakee is on_rq */
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
