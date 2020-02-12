Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A9EC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8672073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgBLJhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:37:01 -0500
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:42652 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbgBLJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:37:00 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id D6F92B86E9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:36:58 +0000 (GMT)
Received: (qmail 25318 invoked from network); 12 Feb 2020 09:36:58 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 12 Feb 2020 09:36:58 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 05/11] sched/numa: Distinguish between the different task_numa_migrate failure cases
Date:   Wed, 12 Feb 2020 09:36:48 +0000
Message-Id: <20200212093654.4816-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200212093654.4816-1-mgorman@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched:sched_stick_numa is meant to fire when a task is unable to migrate
to the preferred node but from the trace, it's possibile to tell the
difference between "no CPU found", "migration to idle CPU failed" and
"tasks could not be swapped". Extend the tracepoint accordingly.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/trace/events/sched.h | 51 +++++++++++++++++++++++++++++++++-----------
 kernel/sched/fair.c          |  6 +++---
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 420e80e56e55..3d07c0af4ab8 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -487,7 +487,11 @@ TRACE_EVENT(sched_process_hang,
 );
 #endif /* CONFIG_DETECT_HUNG_TASK */
 
-DECLARE_EVENT_CLASS(sched_move_task_template,
+/*
+ * Tracks migration of tasks from one runqueue to another. Can be used to
+ * detect if automatic NUMA balancing is bouncing between nodes
+ */
+TRACE_EVENT(sched_move_numa,
 
 	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
 
@@ -519,20 +523,43 @@ DECLARE_EVENT_CLASS(sched_move_task_template,
 			__entry->dst_cpu, __entry->dst_nid)
 );
 
-/*
- * Tracks migration of tasks from one runqueue to another. Can be used to
- * detect if automatic NUMA balancing is bouncing between nodes
- */
-DEFINE_EVENT(sched_move_task_template, sched_move_numa,
-	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
+TRACE_EVENT(sched_stick_numa,
 
-	TP_ARGS(tsk, src_cpu, dst_cpu)
-);
+	TP_PROTO(struct task_struct *src_tsk, int src_cpu, struct task_struct *dst_tsk, int dst_cpu),
 
-DEFINE_EVENT(sched_move_task_template, sched_stick_numa,
-	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
+	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu),
 
-	TP_ARGS(tsk, src_cpu, dst_cpu)
+	TP_STRUCT__entry(
+		__field( pid_t,	src_pid			)
+		__field( pid_t,	src_tgid		)
+		__field( pid_t,	src_ngid		)
+		__field( int,	src_cpu			)
+		__field( int,	src_nid			)
+		__field( pid_t,	dst_pid			)
+		__field( pid_t,	dst_tgid		)
+		__field( pid_t,	dst_ngid		)
+		__field( int,	dst_cpu			)
+		__field( int,	dst_nid			)
+	),
+
+	TP_fast_assign(
+		__entry->src_pid	= task_pid_nr(src_tsk);
+		__entry->src_tgid	= task_tgid_nr(src_tsk);
+		__entry->src_ngid	= task_numa_group_id(src_tsk);
+		__entry->src_cpu	= src_cpu;
+		__entry->src_nid	= cpu_to_node(src_cpu);
+		__entry->dst_pid	= dst_tsk ? task_pid_nr(dst_tsk) : 0;
+		__entry->dst_tgid	= dst_tsk ? task_tgid_nr(dst_tsk) : 0;
+		__entry->dst_ngid	= dst_tsk ? task_numa_group_id(dst_tsk) : 0;
+		__entry->dst_cpu	= dst_cpu;
+		__entry->dst_nid	= dst_cpu >= 0 ? cpu_to_node(dst_cpu) : -1;
+	),
+
+	TP_printk("src_pid=%d src_tgid=%d src_ngid=%d src_cpu=%d src_nid=%d dst_pid=%d dst_tgid=%d dst_ngid=%d dst_cpu=%d dst_nid=%d",
+			__entry->src_pid, __entry->src_tgid, __entry->src_ngid,
+			__entry->src_cpu, __entry->src_nid,
+			__entry->dst_pid, __entry->dst_tgid, __entry->dst_ngid,
+			__entry->dst_cpu, __entry->dst_nid)
 );
 
 TRACE_EVENT(sched_swap_numa,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4ab18fba5b82..6005ce28033b 100644
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
-- 
2.16.4

