Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BADC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 20:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0F32076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 20:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbgEXU37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 16:29:59 -0400
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:33043 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728260AbgEXU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 16:29:59 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 5307F1C366A
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:29:57 +0100 (IST)
Received: (qmail 3156 invoked from network); 24 May 2020 20:29:57 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 24 May 2020 20:29:57 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jirka Hladky <jhladky@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        valentin.schneider@arm.com, Hillf Danton <hdanton@sina.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] sched: Optimize ttwu() spinning on p->on_cpu
Date:   Sun, 24 May 2020 21:29:55 +0100
Message-Id: <20200524202956.27665-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200524202956.27665-1-mgorman@techsingularity.net>
References: <20200524202956.27665-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

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
---
 kernel/sched/core.c | 52 +++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..987b8ecf2ee9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2330,7 +2330,7 @@ void scheduler_ipi(void)
 	irq_exit();
 }
 
-static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+static void __ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
 
@@ -2372,6 +2372,17 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
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
@@ -2380,11 +2391,8 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
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
@@ -2566,7 +2574,15 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
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
@@ -2588,6 +2604,16 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	smp_rmb();
 
+	/*
+	 * If the owning (remote) CPU is still in the middle of schedule() with
+	 * this task as prev, considering queueing p on the remote CPUs wake_list
+	 * which potentially sends an IPI instead of spinning on p->on_cpu to
+	 * let the waker make forward progress. This is safe because IRQs are
+	 * disabled and the IPI will deliver after on_cpu is cleared.
+	 */
+	if (READ_ONCE(p->on_cpu) && ttwu_queue_remote(p, cpu, wake_flags))
+		goto unlock;
+
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
 	 * this task as prev, wait until its done referencing the task.
@@ -2599,28 +2625,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
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
-- 
2.26.1

