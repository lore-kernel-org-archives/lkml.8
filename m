Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E6C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3022084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgBXPVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:21:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50374 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgBXPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:21:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6FXB-0005tw-5a; Mon, 24 Feb 2020 16:20:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CBE071C213E;
        Mon, 24 Feb 2020 16:20:33 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:20:33 -0000
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Distinguish between the different
 task_numa_migrate() failure cases
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200224095223.13361-4-mgorman@techsingularity.net>
References: <20200224095223.13361-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158255763355.28353.13311849953336678946.tip-bot2@tip-bot2>
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

Commit-ID:     b2b2042b204796190af7c20069ab790a614c36d0
Gitweb:        https://git.kernel.org/tip/b2b2042b204796190af7c20069ab790a614c36d0
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Mon, 24 Feb 2020 09:52:13 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2020 11:36:33 +01:00

sched/numa: Distinguish between the different task_numa_migrate() failure cases

sched:sched_stick_numa is meant to fire when a task is unable to migrate
to the preferred node but from the trace, it's possibile to tell the
difference between "no CPU found", "migration to idle CPU failed" and
"tasks could not be swapped". Extend the tracepoint accordingly.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
[ Minor edits. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>
Link: https://lore.kernel.org/r/20200224095223.13361-4-mgorman@techsingularity.net
---
 include/trace/events/sched.h | 49 +++++++++++++++++++----------------
 kernel/sched/fair.c          |  6 ++--
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 420e80e..9c3ebb7 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -487,7 +487,11 @@ TRACE_EVENT(sched_process_hang,
 );
 #endif /* CONFIG_DETECT_HUNG_TASK */
 
-DECLARE_EVENT_CLASS(sched_move_task_template,
+/*
+ * Tracks migration of tasks from one runqueue to another. Can be used to
+ * detect if automatic NUMA balancing is bouncing between nodes.
+ */
+TRACE_EVENT(sched_move_numa,
 
 	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
 
@@ -519,23 +523,7 @@ DECLARE_EVENT_CLASS(sched_move_task_template,
 			__entry->dst_cpu, __entry->dst_nid)
 );
 
-/*
- * Tracks migration of tasks from one runqueue to another. Can be used to
- * detect if automatic NUMA balancing is bouncing between nodes
- */
-DEFINE_EVENT(sched_move_task_template, sched_move_numa,
-	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
-
-	TP_ARGS(tsk, src_cpu, dst_cpu)
-);
-
-DEFINE_EVENT(sched_move_task_template, sched_stick_numa,
-	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
-
-	TP_ARGS(tsk, src_cpu, dst_cpu)
-);
-
-TRACE_EVENT(sched_swap_numa,
+DECLARE_EVENT_CLASS(sched_numa_pair_template,
 
 	TP_PROTO(struct task_struct *src_tsk, int src_cpu,
 		 struct task_struct *dst_tsk, int dst_cpu),
@@ -561,11 +549,11 @@ TRACE_EVENT(sched_swap_numa,
 		__entry->src_ngid	= task_numa_group_id(src_tsk);
 		__entry->src_cpu	= src_cpu;
 		__entry->src_nid	= cpu_to_node(src_cpu);
-		__entry->dst_pid	= task_pid_nr(dst_tsk);
-		__entry->dst_tgid	= task_tgid_nr(dst_tsk);
-		__entry->dst_ngid	= task_numa_group_id(dst_tsk);
+		__entry->dst_pid	= dst_tsk ? task_pid_nr(dst_tsk) : 0;
+		__entry->dst_tgid	= dst_tsk ? task_tgid_nr(dst_tsk) : 0;
+		__entry->dst_ngid	= dst_tsk ? task_numa_group_id(dst_tsk) : 0;
 		__entry->dst_cpu	= dst_cpu;
-		__entry->dst_nid	= cpu_to_node(dst_cpu);
+		__entry->dst_nid	= dst_cpu >= 0 ? cpu_to_node(dst_cpu) : -1;
 	),
 
 	TP_printk("src_pid=%d src_tgid=%d src_ngid=%d src_cpu=%d src_nid=%d dst_pid=%d dst_tgid=%d dst_ngid=%d dst_cpu=%d dst_nid=%d",
@@ -575,6 +563,23 @@ TRACE_EVENT(sched_swap_numa,
 			__entry->dst_cpu, __entry->dst_nid)
 );
 
+DEFINE_EVENT(sched_numa_pair_template, sched_stick_numa,
+
+	TP_PROTO(struct task_struct *src_tsk, int src_cpu,
+		 struct task_struct *dst_tsk, int dst_cpu),
+
+	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
+);
+
+DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
+
+	TP_PROTO(struct task_struct *src_tsk, int src_cpu,
+		 struct task_struct *dst_tsk, int dst_cpu),
+
+	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
+);
+
+
 /*
  * Tracepoint for waking a polling cpu without an IPI.
  */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f524ce3..5d9c23c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1849,7 +1849,7 @@ static int task_numa_migrate(struct task_struct *p)
 
 	/* No better CPU than the current one was found. */
 	if (env.best_cpu == -1) {
-		trace_sched_stick_numa(p, env.src_cpu, -1);
+		trace_sched_stick_numa(p, env.src_cpu, NULL, -1);
 		return -EAGAIN;
 	}
 
@@ -1858,7 +1858,7 @@ static int task_numa_migrate(struct task_struct *p)
 		ret = migrate_task_to(p, env.best_cpu);
 		WRITE_ONCE(best_rq->numa_migrate_on, 0);
 		if (ret != 0)
-			trace_sched_stick_numa(p, env.src_cpu, env.best_cpu);
+			trace_sched_stick_numa(p, env.src_cpu, NULL, env.best_cpu);
 		return ret;
 	}
 
@@ -1866,7 +1866,7 @@ static int task_numa_migrate(struct task_struct *p)
 	WRITE_ONCE(best_rq->numa_migrate_on, 0);
 
 	if (ret != 0)
-		trace_sched_stick_numa(p, env.src_cpu, task_cpu(env.best_task));
+		trace_sched_stick_numa(p, env.src_cpu, env.best_task, env.best_cpu);
 	put_task_struct(env.best_task);
 	return ret;
 }
