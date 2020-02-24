Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13097C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAEE20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgBXJxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:53:07 -0500
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:60095 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727486AbgBXJxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:53:07 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 5C3F91C359D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:53:05 +0000 (GMT)
Received: (qmail 19624 invoked from network); 24 Feb 2020 09:53:05 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 24 Feb 2020 09:53:05 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 03/13] sched/numa: Distinguish between the different task_numa_migrate failure cases
Date:   Mon, 24 Feb 2020 09:52:13 +0000
Message-Id: <20200224095223.13361-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224095223.13361-1-mgorman@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
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
 include/trace/events/sched.h | 49 ++++++++++++++++++++++++--------------------
 kernel/sched/fair.c          |  6 +++---
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 420e80e56e55..f5b75c5fef7e 100644
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
index d41a2b37694f..6c866fb2129c 100644
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

