Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F6AC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D1B20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="MyC5bnD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBJSEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:04:36 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33756 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgBJSEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:04:35 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so7468011qkm.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gKGd+We8hlvofVjVWN0aaW1Wq2XoR6rLJG7u31lttMk=;
        b=MyC5bnD1vIPO5KVsbhf+SXsrFgdwRl+B/wOolBuqlMtsAuam4z4CSy/YyAFub7wsTd
         UGp5V8S/oQbiC7doKAAtm5SmauBrCYWmGcjdV5cFBcJVA5ZIL45iHLeXdRD0JY8V3LNg
         XxTkLoJE5/HLfVE7mfnA/Mhuc4IfpLygGzf9yeSKaSx5GbAK/ADDbHS7OwiWM1nnfZ95
         O659wC3JO8sECXXH4HFM+On7zMopyxGVKessLXf5JMUAP3u0DQu/Effl0D7DGxIISiJW
         a1F8LF4dTrSVXE80VwF2NAFfZwaKfWvtidZIYGILGv9Hu0eLgK7r2avKF8HYnOLtSe6L
         XvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gKGd+We8hlvofVjVWN0aaW1Wq2XoR6rLJG7u31lttMk=;
        b=SBnhA3y4UMW0e546oJZKhAAj7dreVtvyPp4yIUPHmEmpiwO6EDAn4WoDTczLNxbyd3
         2fCfRZQ4EQzuUeAnVG+u/W6FL+01gT4TTEzViDDw6gQAn0zG10Q7y8ZawJ3embnzPVu1
         jN5kwaQoMEYjUjJqwDadrzD+vlP8dr9WHb4Zdupx93HJ36ZIkv8cC5yEOnfD4X1mWSQJ
         wbz7l0wNoO575aMXv+0MHLSjgLHXTp2V2fXW8tG1Yzel04xs74lNf0VLWOGOsYPmDR4u
         FMuKbQX0IIENXV/94O/jeXpDmdtGvs/eriwFVodiz2I1DMjs5HBICvEqtfob1YqLvmz/
         kKQA==
X-Gm-Message-State: APjAAAXFN1m86wpmS3DGeuzLxSWFmH7jd78BUO/KWXAq9ykd9WUA8/NP
        ap25nQxe6HGuOBXAioIaCZGaxg==
X-Google-Smtp-Source: APXvYqwqBWBXLGexugc7PbDR4M9v/o3Mm2y0TpqeCwWRGc+GsKH4GjevjWhvLVomwtoe78AMVNwxEQ==
X-Received: by 2002:a05:620a:1656:: with SMTP id c22mr2642194qko.144.1581357873836;
        Mon, 10 Feb 2020 10:04:33 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id u25sm515521qkj.43.2020.02.10.10.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:04:32 -0800 (PST)
Date:   Mon, 10 Feb 2020 13:04:31 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: Lower than expected CPU pressure in PSI
Message-ID: <20200210180431.GB1588@cmpxchg.org>
References: <CABWYdi25Y=zrfdnitT3sSgC3UqcFHfz6-N2YP7h2TJai=JH_zg@mail.gmail.com>
 <20200109161632.GB8547@cmpxchg.org>
 <20200207130829.GG14897@hirez.programming.kicks-ass.net>
 <20200208101957.GU14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208101957.GU14946@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 11:19:57AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 07, 2020 at 02:08:29PM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 09, 2020 at 11:16:32AM -0500, Johannes Weiner wrote:
> > > On Wed, Jan 08, 2020 at 11:47:10AM -0800, Ivan Babrou wrote:
> > > > We added reporting for PSI in cgroups and results are somewhat surprising.
> > > > 
> > > > My test setup consists of 3 services:
> > > > 
> > > > * stress-cpu1-no-contention.service : taskset -c 1 stress --cpu 1
> > > > * stress-cpu2-first-half.service    : taskset -c 2 stress --cpu 1
> > > > * stress-cpu2-second-half.service   : taskset -c 2 stress --cpu 1
> > > > 
> > > > First service runs unconstrained, the other two compete for CPU.
> > > > 
> > > > As expected, I can see 500ms/s sched delay for the latter two and
> > > > aggregated 1000ms/s delay for /system.slice, no surprises here.
> > > > 
> > > > However, CPU pressure reported by PSI says that none of my services
> > > > have any pressure on them. I can see around 434ms/s pressure on
> > > > /unified/system.slice and 425ms/s pressure on /unified cgroup, which
> > > > is surprising for three reasons:
> > > > 
> > > > * Pressure is absent for my services (I expect it to match scheed delay)
> > > > * Pressure on /unified/system.slice is lower than both 500ms/s and 1000ms/s
> > > > * Pressure on root cgroup is lower than on system.slice
> > > 
> > > CPU pressure is currently implemented based only on the number of
> > > *runnable* tasks, not on who gets to actively use the CPU. This works
> > > for contention within cgroups or at the global scope, but it doesn't
> > > correctly reflect competition between cgroups. It also doesn't show
> > > the effects of e.g. cpu cycle limiting through cpu.max where there
> > > might *be* only one runnable task, but it's not getting the CPU.
> > > 
> > > I've been working on fixing this, but hadn't gotten around to sending
> > > the patch upstream. Attaching it below. Would you mind testing it?
> > > 
> > > Peter, what would you think of the below?
> > 
> > I'm not loving it; but I see what it does and I can't quickly see an
> > alternative.
> > 
> > My main gripe is doing even more of those cgroup traversals.
> > 
> > One thing pick_next_task_fair() does is try and limit the cgroup
> > traversal to the sub-tree that contains both prev and next. Not sure
> > that is immediately applicable here, but it might be worth looking into.
> 
> One option I suppose, would be to replace this:

Thanks for looking closer at this, this is a cool idea.

> +static inline void psi_sched_switch(struct task_struct *prev,
> +                                   struct task_struct *next,
> +                                   bool sleep)
> +{
> +       if (static_branch_likely(&psi_disabled))
> +               return;
> +
> +       /*
> +        * Clear the TSK_ONCPU state if the task was preempted. If
> +        * it's a voluntary sleep, dequeue will have taken care of it.
> +        */
> +       if (!sleep)
> +               psi_task_change(prev, TSK_ONCPU, 0);
> +
> +       psi_task_change(next, 0, TSK_ONCPU);
> +}
> 
> With something like:
> 
> static inline void psi_sched_switch(struct task_struct *prev,
>                                    struct task_struct *next,
>                                    bool sleep)
> {
> 	struct psi_group *g, *p = NULL;
> 
> 	set = TSK_ONCPU;
> 	clear = 0;
> 
> 	while ((g = iterate_group(next, &g))) {
> 		u32 nr_running = per_cpu_ptr(g->pcpu, cpu)->tasks[NR_RUNNING];

[ I'm assuming you meant NR_ONCPU instead of NR_RUNNING since the
  incoming task will already be runnable and all its groups will
  always have NR_RUNNING elevated.

  Would switching this to NR_RUNNABLE / TSK_RUNNABLE be better? ]

Anyway, I implemented this and it seems to be working quite well. When
cgroup siblings contend over a CPU, i.e. context switching doesn't
change the group state, no group updates are performed at all:

  # cat /proc/self/cgroup 
  0::/user.slice/user-0.slice/session-c2.scope
  # stress -c 64
  stress: info: [216] dispatching hogs: 64 cpu, 0 io, 0 vm, 0 hdd

          stress-238   [001] d..2    50.077379: psi_task_switch: stress->[stress] 0/4 cgroups updated
          stress-238   [001] d..2    50.077380: psi_task_switch: [stress]->stress 0/4 cgroups updated
          stress-265   [003] d..2    50.078379: psi_task_switch: stress->[stress] 0/4 cgroups updated
          stress-245   [000] d..2    50.078379: psi_task_switch: stress->[stress] 0/4 cgroups updated
          stress-265   [003] d..2    50.078380: psi_task_switch: [stress]->stress 0/4 cgroups updated
          stress-245   [000] d..2    50.078380: psi_task_switch: [stress]->stress 0/4 cgroups updated

But even with otherwise no overlap in the user-created hierarchy, at
least the root group updates are avoided:

          stress-261   [003] d..2    50.075265: psi_task_switch: stress->[kworker/u8:1] 0/1 cgroups updated
          stress-261   [003] d..2    50.075266: psi_task_switch: [stress]->kworker/u8:1 3/4 cgroups updated

---
From 1cfa3601865b33f98415993a5774c509c6585900 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 10 Feb 2020 11:14:40 -0500
Subject: [PATCH] psi: optimize switching tasks inside shared cgroups

Unlike other task state changes, when merely switching tasks running
on a CPU, the aggregate state of the group that contains both tasks
does not change. We can exploit that. Update the group state only up
to the first shared ancestor.

We can identify the first shared ancestor by walking the groups of the
incoming task until we see TSK_ONCPU set on the local CPU; that's the
first group that also contains the outgoing task.

The new psi_task_switch() is similar to psi_task_change(). To allow
code reuse, move the task flag maintenance code into a new function
and the poll/avg worker wakeups into the shared psi_group_change().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/psi.h  |  2 +
 kernel/sched/psi.c   | 87 ++++++++++++++++++++++++++++++++++----------
 kernel/sched/stats.h |  9 +----
 3 files changed, 70 insertions(+), 28 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7b3de7321219..7361023f3fdd 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -17,6 +17,8 @@ extern struct psi_group psi_system;
 void psi_init(void);
 
 void psi_task_change(struct task_struct *task, int clear, int set);
+void psi_task_switch(struct task_struct *prev, struct task_struct *next,
+		     bool sleep);
 
 void psi_memstall_tick(struct task_struct *task, int cpu);
 void psi_memstall_enter(unsigned long *flags);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 245aec187e4f..a053304b932b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -667,13 +667,14 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		groupc->times[PSI_NONIDLE] += delta;
 }
 
-static u32 psi_group_change(struct psi_group *group, int cpu,
-			    unsigned int clear, unsigned int set)
+static void psi_group_change(struct psi_group *group, int cpu,
+			     unsigned int clear, unsigned int set,
+			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
+	u32 state_mask = 0;
 	unsigned int t, m;
 	enum psi_states s;
-	u32 state_mask = 0;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
@@ -715,7 +716,11 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
 
 	write_seqcount_end(&groupc->seq);
 
-	return state_mask;
+	if (state_mask & group->poll_states)
+		psi_schedule_poll_work(group, 1);
+
+	if (wake_clock && !delayed_work_pending(&group->avgs_work))
+		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
 }
 
 static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
@@ -742,27 +747,32 @@ static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
 	return &psi_system;
 }
 
-void psi_task_change(struct task_struct *task, int clear, int set)
+static void psi_flags_change(struct task_struct *task, int clear, int set)
 {
-	int cpu = task_cpu(task);
-	struct psi_group *group;
-	bool wake_clock = true;
-	void *iter = NULL;
-
-	if (!task->pid)
-		return;
-
 	if (((task->psi_flags & set) ||
 	     (task->psi_flags & clear) != clear) &&
 	    !psi_bug) {
 		printk_deferred(KERN_ERR "psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
-				task->pid, task->comm, cpu,
+				task->pid, task->comm, task_cpu(task),
 				task->psi_flags, clear, set);
 		psi_bug = 1;
 	}
 
 	task->psi_flags &= ~clear;
 	task->psi_flags |= set;
+}
+
+void psi_task_change(struct task_struct *task, int clear, int set)
+{
+	int cpu = task_cpu(task);
+	struct psi_group *group;
+	bool wake_clock = true;
+	void *iter = NULL;
+
+	if (!task->pid)
+		return;
+
+	psi_flags_change(task, clear, set);
 
 	/*
 	 * Periodic aggregation shuts off if there is a period of no
@@ -775,14 +785,51 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 		     wq_worker_last_func(task) == psi_avgs_work))
 		wake_clock = false;
 
-	while ((group = iterate_groups(task, &iter))) {
-		u32 state_mask = psi_group_change(group, cpu, clear, set);
+	while ((group = iterate_groups(task, &iter)))
+		psi_group_change(group, cpu, clear, set, wake_clock);
+}
+
+void psi_task_switch(struct task_struct *prev, struct task_struct *next,
+		     bool sleep)
+{
+	struct psi_group *group, *common = NULL;
+	int cpu = task_cpu(prev);
+	void *iter;
+
+	if (next->pid) {
+		psi_flags_change(next, 0, TSK_ONCPU);
+		/*
+		 * When moving state between tasks, the group that
+		 * contains them both does not change: we can stop
+		 * updating the tree once we reach the first common
+		 * ancestor. Iterate @next's ancestors until we
+		 * encounter @prev's state.
+		 */
+		iter = NULL;
+		while ((group = iterate_groups(next, &iter))) {
+			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+				common = group;
+				break;
+			}
+
+			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
+		}
+	}
+
+	/*
+	 * If this is a voluntary sleep, dequeue will have taken care
+	 * of the outgoing TSK_ONCPU alongside TSK_RUNNING already. We
+	 * only need to deal with it during preemption.
+	 */
+	if (sleep)
+		return;
 
-		if (state_mask & group->poll_states)
-			psi_schedule_poll_work(group, 1);
+	if (prev->pid) {
+		psi_flags_change(prev, TSK_ONCPU, 0);
 
-		if (wake_clock && !delayed_work_pending(&group->avgs_work))
-			schedule_delayed_work(&group->avgs_work, PSI_FREQ);
+		iter = NULL;
+		while ((group = iterate_groups(prev, &iter)) && group != common)
+			psi_group_change(group, cpu, TSK_ONCPU, 0, true);
 	}
 }
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 6ff0ac1a803f..1339f5bfe513 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -141,14 +141,7 @@ static inline void psi_sched_switch(struct task_struct *prev,
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	/*
-	 * Clear the TSK_ONCPU state if the task was preempted. If
-	 * it's a voluntary sleep, dequeue will have taken care of it.
-	 */
-	if (!sleep)
-		psi_task_change(prev, TSK_ONCPU, 0);
-
-	psi_task_change(next, 0, TSK_ONCPU);
+	psi_task_switch(prev, next, sleep);
 }
 
 static inline void psi_task_tick(struct rq *rq)
-- 
2.24.1

