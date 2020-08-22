Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71755C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52695207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHUPqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:46:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10253 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbgHUPqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:46:11 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 54A0117A4900C0881F6B;
        Fri, 21 Aug 2020 23:46:07 +0800 (CST)
Received: from huawei.com (10.151.151.249) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 23:45:57 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>,
        <thara.gopinath@linaro.org>, <pauld@redhat.com>,
        <vincent.donnefort@arm.com>, <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2] sched: Add trace for task wake up latency and leave running time
Date:   Sat, 22 Aug 2020 00:08:14 +0000
Message-ID: <20200822000814.33189-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) The perf event sched_switch is used to record scheduling tracks,
   which consumes a large amount of CPU resources and disk space.
   Therefore, a mechanism is required to record only the scheduling
   delay greater than a certain threshold. This patch supports this
   feature. For example, if the threshold is 10 ms, you can run the
   following command to only record the scheduling track with the
   scheduling delay greater than 10 ms.

   echo 'time > 10000000' > /sys/kernel/debug/tracing/events/sched/sched_wakeup_latency/filter
   echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup_latency/enable

2) Similarly, when tune performance, we usually want to know which
   tasks are not running for a long time that is greater than a
   certain threshold, Use the following commands can easily implement
   it.

   echo 'time > 10000000' > /sys/kernel/debug/tracing/events/sched/sched_leave_running_time/filter
   echo 1 > /sys/kernel/debug/tracing/events/sched/sched_leave_running_time/enable

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 include/linux/sched.h        |  7 ++++
 include/trace/events/sched.h | 66 ++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c          | 20 +++++++++++
 3 files changed, 93 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd930efd3..edb622c40a90 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1324,6 +1324,13 @@ struct task_struct {
 	/* CPU-specific state of this task: */
 	struct thread_struct		thread;
 
+	/* Task wake up time stamp */
+	u64				ts_wakeup;
+	/* Previous task switch out time stamp */
+	u64				pre_ts_end;
+	/* Next task switch in time stamp */
+	u64				next_ts_start;
+	bool				wakeup_state;
 	/*
 	 * WARNING: on x86, 'thread_struct' contains a variable-sized
 	 * structure.  It *MUST* be at the end of 'task_struct'.
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fec25b9cfbaf..e99c6d573a42 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -183,6 +183,72 @@ TRACE_EVENT(sched_switch,
 		__entry->next_comm, __entry->next_pid, __entry->next_prio)
 );
 
+DECLARE_EVENT_CLASS(sched_latency_template,
+
+	TP_PROTO(bool preempt,
+		 struct task_struct *prev,
+		 struct task_struct *next,
+		 u64 time),
+
+	TP_ARGS(preempt, prev, next, time),
+
+	TP_STRUCT__entry(
+		__array(	char,	prev_comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	prev_pid			)
+		__field(	int,	prev_prio			)
+		__field(	long,	prev_state			)
+		__array(	char,	next_comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	next_pid			)
+		__field(	int,	next_prio			)
+		__field(	u64,	time				)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		__entry->prev_pid	= prev->pid;
+		__entry->prev_prio	= prev->prio;
+		__entry->prev_state	= __trace_sched_switch_state(preempt, prev);
+		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+		__entry->next_pid	= next->pid;
+		__entry->next_prio	= next->prio;
+		__entry->time		= time;
+		/* XXX SCHED_DEADLINE */
+	),
+
+	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d passed time=%llu (ns)",
+		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
+
+		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
+		  __print_flags(__entry->prev_state & (TASK_REPORT_MAX - 1), "|",
+				{ TASK_INTERRUPTIBLE, "S" },
+				{ TASK_UNINTERRUPTIBLE, "D" },
+				{ __TASK_STOPPED, "T" },
+				{ __TASK_TRACED, "t" },
+				{ EXIT_DEAD, "X" },
+				{ EXIT_ZOMBIE, "Z" },
+				{ TASK_PARKED, "P" },
+				{ TASK_DEAD, "I" }) :
+		  "R",
+
+		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
+		__entry->next_comm, __entry->next_pid, __entry->next_prio,
+		__entry->time)
+);
+
+DEFINE_EVENT(sched_latency_template, sched_wakeup_latency,
+	TP_PROTO(bool preempt,
+		 struct task_struct *prev,
+		 struct task_struct *next,
+		 u64 time),
+	TP_ARGS(preempt, prev, next, time));
+
+DEFINE_EVENT(sched_latency_template, sched_leave_running_time,
+	TP_PROTO(bool preempt,
+		 struct task_struct *prev,
+		 struct task_struct *next,
+		 u64 time),
+	TP_ARGS(preempt, prev, next, time));
+
 /*
  * Tracepoint for a task being migrated:
  */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8471a0f7eb32..b5a1928dc948 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2464,6 +2464,8 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 {
 	check_preempt_curr(rq, p, wake_flags);
 	p->state = TASK_RUNNING;
+	p->ts_wakeup = local_clock();
+	p->wakeup_state = true;
 	trace_sched_wakeup(p);
 
 #ifdef CONFIG_SMP
@@ -2846,6 +2848,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		success = 1;
 		trace_sched_waking(p);
 		p->state = TASK_RUNNING;
+		p->ts_wakeup = local_clock();
+		p->wakeup_state = true;
 		trace_sched_wakeup(p);
 		goto out;
 	}
@@ -3299,6 +3303,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
+	p->ts_wakeup = 0;
+	p->wakeup_state = false;
+	p->pre_ts_end = p->next_ts_start = 0;
 	return 0;
 }
 
@@ -3355,6 +3362,8 @@ void wake_up_new_task(struct task_struct *p)
 	post_init_entity_util_avg(p);
 
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
+	p->ts_wakeup = local_clock();
+	p->wakeup_state = true;
 	trace_sched_wakeup_new(p);
 	check_preempt_curr(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
@@ -4521,8 +4530,19 @@ static void __sched notrace __schedule(bool preempt)
 
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
+		next->next_ts_start = prev->pre_ts_end = local_clock();
+
 		trace_sched_switch(preempt, prev, next);
 
+		if (next->ts_wakeup && next->wakeup_state) {
+			trace_sched_wakeup_latency(preempt, prev, next,
+				next->next_ts_start - next->ts_wakeup);
+			next->wakeup_state = false;
+		}
+
+		trace_sched_leave_running_time(preempt, prev,
+			next, next->next_ts_start - next->pre_ts_end);
+
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
-- 
2.17.1

