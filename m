Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C45C352B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30D6206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436517AbgDNIUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:20:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:45273 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407121AbgDNIUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:20:11 -0400
IronPort-SDR: E6zgEvJUb8254+yefp2FRuGtsE+1LY+1SgmrL6JH5h3/lSRkHQyJrwYZL0NvOU11oTrgkNJBCB
 HXEtvUrUedOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 01:20:09 -0700
IronPort-SDR: JopTCPnjzFLZZ8cKp57yAyT9I6YLmJmlurj9Vy0jL18U93ZNwGO6HJi3E3cjAVtEmGdv+tFkW2
 SZ9d2CK/3+Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="245359547"
Received: from haihuilv-mobl1.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.215.18])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2020 01:20:06 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: [RFC] autonuma: Support to scan page table asynchronously
Date:   Tue, 14 Apr 2020 16:19:51 +0800
Message-Id: <20200414081951.297676-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current AutoNUMA implementation, the page tables of the processes
are scanned periodically to trigger the NUMA hint page faults.  The
scanning runs in the context of the processes, so will delay the
running of the processes.  In a test with 64 threads pmbench memory
accessing benchmark on a 2-socket server machine with 104 logical CPUs
and 256 GB memory, there are more than 20000 latency outliers that are
> 1 ms in 3600s run time.  These latency outliers are almost all
caused by the AutoNUMA page table scanning.  Because they almost all
disappear after applying this patch to scan the page tables
asynchronously.

Because there are idle CPUs in system, the asynchronous running page
table scanning code can run on these idle CPUs instead of the CPUs the
workload is running on.

So on system with enough idle CPU time, it's better to scan the page
tables asynchronously to take full advantages of these idle CPU time.
Another scenario which can benefit from this is to scan the page
tables on some service CPUs of the socket, so that the real workload
can run on the isolated CPUs without the latency outliers caused by
the page table scanning.

But it's not perfect to scan page tables asynchronously too.  For
example, on system without enough idle CPU time, the CPU time isn't
scheduled fairly because the page table scanning is charged to the
workqueue thread instead of the process/thread it works for.  And
although the page tables are scanned for the target process, it may
run on a CPU that is not in the cpuset of the target process.

One possible solution is to let the system administrator to choose the
better behavior for the system via a sysctl knob (implemented in the
patch).  But it's not perfect too.  Because every user space knob adds
maintenance overhead.

A better solution may be to back-charge the CPU time to scan the page
tables to the process/thread, and find a way to run the work on the
proper cpuset.  After some googling, I found there's some discussion
about this as in the following thread,

https://lkml.org/lkml/2019/6/13/1321

So this patch may be not ready to be merged by upstream yet.  It
quantizes the latency outliers caused by the page table scanning in
AutoNUMA.  And it provides a possible way to resolve the issue for
users who cares about it.  And it is a potential customer of the work
related to the cgroup-aware workqueue or other asynchronous execution
mechanisms.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Aubrey Li <aubrey.li@intel.com>
---
 include/linux/sched.h        |  1 +
 include/linux/sched/sysctl.h |  1 +
 kernel/exit.c                |  1 +
 kernel/sched/fair.c          | 55 +++++++++++++++++++++++++++---------
 kernel/sysctl.c              |  9 ++++++
 5 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 04278493bf15..433f77436ed4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1087,6 +1087,7 @@ struct task_struct {
 	u64				last_task_numa_placement;
 	u64				last_sum_exec_runtime;
 	struct callback_head		numa_work;
+	struct work_struct		numa_async_work;
 
 	/*
 	 * This pointer is only modified for current in syscall and
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f..ea595ae9e573 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -37,6 +37,7 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
+extern unsigned int sysctl_numa_balancing_scan_async;
 
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
diff --git a/kernel/exit.c b/kernel/exit.c
index 0b81b26a872a..f5e84ff4b788 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -798,6 +798,7 @@ void __noreturn do_exit(long code)
 	if (group_dead)
 		disassociate_ctty(1);
 	exit_task_namespaces(tsk);
+	cancel_work_sync(&tsk->numa_async_work);
 	exit_task_work(tsk);
 	exit_thread(tsk);
 	exit_umh(tsk);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c1217bfe5e81..7d82c6826708 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1064,6 +1064,9 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
 /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
 unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
+/* Scan asynchronously via work queue */
+unsigned int sysctl_numa_balancing_scan_async;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -2481,24 +2484,17 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
-/*
- * The expensive part of numa migration is done from task_work context.
- * Triggered from task_tick_numa().
- */
-static void task_numa_work(struct callback_head *work)
+static void numa_scan(struct task_struct *p)
 {
 	unsigned long migrate, next_scan, now = jiffies;
-	struct task_struct *p = current;
+	struct task_struct *pc = current;
 	struct mm_struct *mm = p->mm;
-	u64 runtime = p->se.sum_exec_runtime;
+	u64 runtime = pc->se.sum_exec_runtime;
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
 
-	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
-
-	work->next = work;
 	/*
 	 * Who cares about NUMA placement when they're dying.
 	 *
@@ -2621,12 +2617,36 @@ static void task_numa_work(struct callback_head *work)
 	 * Usually update_task_scan_period slows down scanning enough; on an
 	 * overloaded system we need to limit overhead on a per task basis.
 	 */
-	if (unlikely(p->se.sum_exec_runtime != runtime)) {
-		u64 diff = p->se.sum_exec_runtime - runtime;
+	if (unlikely(pc->se.sum_exec_runtime != runtime)) {
+		u64 diff = pc->se.sum_exec_runtime - runtime;
 		p->node_stamp += 32 * diff;
 	}
 }
 
+/*
+ * The expensive part of numa migration is done from task_work context.
+ * Triggered from task_tick_numa().
+ */
+static void task_numa_work(struct callback_head *work)
+{
+	struct task_struct *p = current;
+
+	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
+
+	work->next = work;
+
+	numa_scan(p);
+}
+
+static void numa_async_work(struct work_struct *work)
+{
+	struct task_struct *p;
+
+	p = container_of(work, struct task_struct, numa_async_work);
+
+	numa_scan(p);
+}
+
 void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 {
 	int mm_users = 0;
@@ -2650,6 +2670,7 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->last_sum_exec_runtime	= 0;
 
 	init_task_work(&p->numa_work, task_numa_work);
+	INIT_WORK(&p->numa_async_work, numa_async_work);
 
 	/* New address space, reset the preferred nid */
 	if (!(clone_flags & CLONE_VM)) {
@@ -2699,8 +2720,14 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 			curr->numa_scan_period = task_scan_start(curr);
 		curr->node_stamp += period;
 
-		if (!time_before(jiffies, curr->mm->numa_next_scan))
-			task_work_add(curr, work, true);
+		if (!time_before(jiffies, curr->mm->numa_next_scan)) {
+			if (sysctl_numa_balancing_scan_async)
+				queue_work_node(numa_node_id(),
+						system_unbound_wq,
+						&curr->numa_async_work);
+			else
+				task_work_add(curr, work, true);
+		}
 	}
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a..31a987230c58 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -418,6 +418,15 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "numa_balancing_scan_async",
+		.data		= &sysctl_numa_balancing_scan_async,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "numa_balancing",
 		.data		= NULL, /* filled in by handler */
-- 
2.25.1

