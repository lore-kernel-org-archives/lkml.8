Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EAFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5662071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbgEYF07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgEYF06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:26:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DBBC061A0E;
        Sun, 24 May 2020 22:26:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jd5dG-0002km-FT; Mon, 25 May 2020 07:26:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 14BF21C047E;
        Mon, 25 May 2020 07:26:37 +0200 (CEST)
Date:   Mon, 25 May 2020 05:26:36 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Optimize ttwu() spinning on p->on_cpu
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        valentin.schneider@arm.com, Hillf Danton <hdanton@sina.com>,
        Rik van Riel <riel@surriel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200524202956.27665-2-mgorman@techsingularity.net>
References: <20200524202956.27665-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <159038439694.17951.308820958111860270.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c6e7bd7afaeb3af55ffac122828035f1c01d1d7b
Gitweb:        https://git.kernel.org/tip/c6e7bd7afaeb3af55ffac122828035f1c01d1d7b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 24 May 2020 21:29:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 May 2020 07:01:44 +02:00

sched/core: Optimize ttwu() spinning on p->on_cpu

Both Rik and Mel reported seeing ttwu() spend significant time on:

  smp_cond_load_acquire(&p->on_cpu, !VAL);

Attempt to avoid this by queueing the wakeup on the CPU that owns the
p->on_cpu value. This will then allow the ttwu() to complete without
further waiting.

Since we run schedule() with interrupts disabled, the IPI is
guaranteed to happen after p->on_cpu is cleared, this is what makes it
safe to queue early.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jirka Hladky <jhladky@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: valentin.schneider@arm.com
Cc: Hillf Danton <hdanton@sina.com>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/r/20200524202956.27665-2-mgorman@techsingularity.net
---
 kernel/sched/core.c | 52 ++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa905b6..903c9ee 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2312,7 +2312,7 @@ static void wake_csd_func(void *info)
 	sched_ttwu_pending();
 }
 
-static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+static void __ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
 
@@ -2354,6 +2354,17 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 {
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
+
+static bool ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+{
+	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
+		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
+		__ttwu_queue_remote(p, cpu, wake_flags);
+		return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_SMP */
 
 static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
@@ -2362,11 +2373,8 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 	struct rq_flags rf;
 
 #if defined(CONFIG_SMP)
-	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
-		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
-		ttwu_queue_remote(p, cpu, wake_flags);
+	if (ttwu_queue_remote(p, cpu, wake_flags))
 		return;
-	}
 #endif
 
 	rq_lock(rq, &rf);
@@ -2548,7 +2556,15 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (p->on_rq && ttwu_remote(p, wake_flags))
 		goto unlock;
 
+	if (p->in_iowait) {
+		delayacct_blkio_end(p);
+		atomic_dec(&task_rq(p)->nr_iowait);
+	}
+
 #ifdef CONFIG_SMP
+	p->sched_contributes_to_load = !!task_contributes_to_load(p);
+	p->state = TASK_WAKING;
+
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
 	 * possible to, falsely, observe p->on_cpu == 0.
@@ -2572,6 +2588,16 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
+	 * this task as prev, considering queueing p on the remote CPUs wake_list
+	 * which potentially sends an IPI instead of spinning on p->on_cpu to
+	 * let the waker make forward progress. This is safe because IRQs are
+	 * disabled and the IPI will deliver after on_cpu is cleared.
+	 */
+	if (READ_ONCE(p->on_cpu) && ttwu_queue_remote(p, cpu, wake_flags))
+		goto unlock;
+
+	/*
+	 * If the owning (remote) CPU is still in the middle of schedule() with
 	 * this task as prev, wait until its done referencing the task.
 	 *
 	 * Pairs with the smp_store_release() in finish_task().
@@ -2581,28 +2607,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	smp_cond_load_acquire(&p->on_cpu, !VAL);
 
-	p->sched_contributes_to_load = !!task_contributes_to_load(p);
-	p->state = TASK_WAKING;
-
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
-
 	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
 	if (task_cpu(p) != cpu) {
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
 	}
-
-#else /* CONFIG_SMP */
-
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
-
 #endif /* CONFIG_SMP */
 
 	ttwu_queue(p, cpu, wake_flags);
