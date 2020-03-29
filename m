Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11540C10F26
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD32721655
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgC2Sni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbgC2SnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5740920CC7;
        Sun, 29 Mar 2020 18:43:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIcty-002Fze-6N; Sun, 29 Mar 2020 14:43:18 -0400
Message-Id: <20200329184318.079639822@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:43:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 18/21] tracing: Create set_event_notrace_pid to not trace tasks
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There's currently a way to select a task that should only have its events
traced, but there's no way to select a task not to have itsevents traced.
Add a set_event_notrace_pid file that acts the same as set_event_pid (and is
also affected by event-fork), but the task pids in this file will not be
traced even if they are listed in the set_event_pid file. This makes it easy
for tools like trace-cmd to "hide" itself from beint traced by events when
it is recording other tasks.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c       |  11 +-
 kernel/trace/trace.h        |  25 ++++
 kernel/trace/trace_events.c | 280 ++++++++++++++++++++++++++++--------
 3 files changed, 244 insertions(+), 72 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7239d9acd09f..0bb62e64280c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6987,11 +6987,6 @@ void ftrace_pid_follow_fork(struct trace_array *tr, bool enable)
 	}
 }
 
-enum {
-	TRACE_PIDS		= BIT(0),
-	TRACE_NO_PIDS		= BIT(1),
-};
-
 static void clear_ftrace_pids(struct trace_array *tr, int type)
 {
 	struct trace_pid_list *pid_list;
@@ -7004,13 +6999,11 @@ static void clear_ftrace_pids(struct trace_array *tr, int type)
 						lockdep_is_held(&ftrace_lock));
 
 	/* Make sure there's something to do */
-	if (!(((type & TRACE_PIDS) && pid_list) ||
-	      ((type & TRACE_NO_PIDS) && no_pid_list)))
+	if (!pid_type_enabled(type, pid_list, no_pid_list))
 		return;
 
 	/* See if the pids still need to be checked after this */
-	if (!((!(type & TRACE_PIDS) && pid_list) ||
-	      (!(type & TRACE_NO_PIDS) && no_pid_list))) {
+	if (!still_need_pid_events(type, pid_list, no_pid_list)) {
 		unregister_trace_sched_switch(ftrace_filter_pid_sched_switch_probe, tr);
 		for_each_possible_cpu(cpu)
 			per_cpu_ptr(tr->array_buffer.data, cpu)->ftrace_ignore_pid = FTRACE_PID_TRACE;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6b5ff5adb4ad..4eb1d004d5f2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -207,6 +207,30 @@ struct trace_pid_list {
 	unsigned long			*pids;
 };
 
+enum {
+	TRACE_PIDS		= BIT(0),
+	TRACE_NO_PIDS		= BIT(1),
+};
+
+static inline bool pid_type_enabled(int type, struct trace_pid_list *pid_list,
+				    struct trace_pid_list *no_pid_list)
+{
+	/* Return true if the pid list in type has pids */
+	return ((type & TRACE_PIDS) && pid_list) ||
+		((type & TRACE_NO_PIDS) && no_pid_list);
+}
+
+static inline bool still_need_pid_events(int type, struct trace_pid_list *pid_list,
+					 struct trace_pid_list *no_pid_list)
+{
+	/*
+	 * Turning off what is in @type, return true if the "other"
+	 * pid list, still has pids in it.
+	 */
+	return (!(type & TRACE_PIDS) && pid_list) ||
+		(!(type & TRACE_NO_PIDS) && no_pid_list);
+}
+
 typedef bool (*cond_update_fn_t)(struct trace_array *tr, void *cond_data);
 
 /**
@@ -285,6 +309,7 @@ struct trace_array {
 #endif
 #endif
 	struct trace_pid_list	__rcu *filtered_pids;
+	struct trace_pid_list	__rcu *filtered_no_pids;
 	/*
 	 * max_lock is used to protect the swapping of buffers
 	 * when taking a max snapshot. The buffers themselves are
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c196d0dc5871..242f59e7f17d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -232,10 +232,13 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
 {
 	struct trace_array *tr = trace_file->tr;
 	struct trace_array_cpu *data;
+	struct trace_pid_list *no_pid_list;
 	struct trace_pid_list *pid_list;
 
 	pid_list = rcu_dereference_raw(tr->filtered_pids);
-	if (!pid_list)
+	no_pid_list = rcu_dereference_raw(tr->filtered_no_pids);
+
+	if (!pid_list && !no_pid_list)
 		return false;
 
 	data = this_cpu_ptr(tr->array_buffer.data);
@@ -510,6 +513,9 @@ event_filter_pid_sched_process_exit(void *data, struct task_struct *task)
 
 	pid_list = rcu_dereference_raw(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, NULL, task);
+
+	pid_list = rcu_dereference_raw(tr->filtered_no_pids);
+	trace_filter_add_remove_task(pid_list, NULL, task);
 }
 
 static void
@@ -522,6 +528,9 @@ event_filter_pid_sched_process_fork(void *data,
 
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, self, task);
+
+	pid_list = rcu_dereference_sched(tr->filtered_no_pids);
+	trace_filter_add_remove_task(pid_list, self, task);
 }
 
 void trace_event_follow_fork(struct trace_array *tr, bool enable)
@@ -544,13 +553,23 @@ event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
 		    struct task_struct *prev, struct task_struct *next)
 {
 	struct trace_array *tr = data;
+	struct trace_pid_list *no_pid_list;
 	struct trace_pid_list *pid_list;
+	bool ret;
 
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	no_pid_list = rcu_dereference_sched(tr->filtered_no_pids);
 
-	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, NULL, prev) &&
-		       trace_ignore_this_task(pid_list, NULL, next));
+	/*
+	 * Sched switch is funny, as we only want to ignore it
+	 * in the notrace case if both prev and next should be ignored.
+	 */
+	ret = trace_ignore_this_task(NULL, no_pid_list, prev) &&
+		trace_ignore_this_task(NULL, no_pid_list, next);
+
+	this_cpu_write(tr->array_buffer.data->ignore_pid, ret ||
+		       (trace_ignore_this_task(pid_list, NULL, prev) &&
+			trace_ignore_this_task(pid_list, NULL, next)));
 }
 
 static void
@@ -558,18 +577,21 @@ event_filter_pid_sched_switch_probe_post(void *data, bool preempt,
 		    struct task_struct *prev, struct task_struct *next)
 {
 	struct trace_array *tr = data;
+	struct trace_pid_list *no_pid_list;
 	struct trace_pid_list *pid_list;
 
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	no_pid_list = rcu_dereference_sched(tr->filtered_no_pids);
 
 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, NULL, next));
+		       trace_ignore_this_task(pid_list, no_pid_list, next));
 }
 
 static void
 event_filter_pid_sched_wakeup_probe_pre(void *data, struct task_struct *task)
 {
 	struct trace_array *tr = data;
+	struct trace_pid_list *no_pid_list;
 	struct trace_pid_list *pid_list;
 
 	/* Nothing to do if we are already tracing */
@@ -577,15 +599,17 @@ event_filter_pid_sched_wakeup_probe_pre(void *data, struct task_struct *task)
 		return;
 
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	no_pid_list = rcu_dereference_sched(tr->filtered_no_pids);
 
 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, NULL, task));
+		       trace_ignore_this_task(pid_list, no_pid_list, task));
 }
 
 static void
 event_filter_pid_sched_wakeup_probe_post(void *data, struct task_struct *task)
 {
 	struct trace_array *tr = data;
+	struct trace_pid_list *no_pid_list;
 	struct trace_pid_list *pid_list;
 
 	/* Nothing to do if we are not tracing */
@@ -593,23 +617,15 @@ event_filter_pid_sched_wakeup_probe_post(void *data, struct task_struct *task)
 		return;
 
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	no_pid_list = rcu_dereference_sched(tr->filtered_no_pids);
 
 	/* Set tracing if current is enabled */
 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, NULL, current));
+		       trace_ignore_this_task(pid_list, no_pid_list, current));
 }
 
-static void __ftrace_clear_event_pids(struct trace_array *tr)
+static void unregister_pid_events(struct trace_array *tr)
 {
-	struct trace_pid_list *pid_list;
-	struct trace_event_file *file;
-	int cpu;
-
-	pid_list = rcu_dereference_protected(tr->filtered_pids,
-					     lockdep_is_held(&event_mutex));
-	if (!pid_list)
-		return;
-
 	unregister_trace_sched_switch(event_filter_pid_sched_switch_probe_pre, tr);
 	unregister_trace_sched_switch(event_filter_pid_sched_switch_probe_post, tr);
 
@@ -621,26 +637,55 @@ static void __ftrace_clear_event_pids(struct trace_array *tr)
 
 	unregister_trace_sched_waking(event_filter_pid_sched_wakeup_probe_pre, tr);
 	unregister_trace_sched_waking(event_filter_pid_sched_wakeup_probe_post, tr);
+}
 
-	list_for_each_entry(file, &tr->events, list) {
-		clear_bit(EVENT_FILE_FL_PID_FILTER_BIT, &file->flags);
+static void __ftrace_clear_event_pids(struct trace_array *tr, int type)
+{
+	struct trace_pid_list *pid_list;
+	struct trace_pid_list *no_pid_list;
+	struct trace_event_file *file;
+	int cpu;
+
+	pid_list = rcu_dereference_protected(tr->filtered_pids,
+					     lockdep_is_held(&event_mutex));
+	no_pid_list = rcu_dereference_protected(tr->filtered_no_pids,
+					     lockdep_is_held(&event_mutex));
+
+	/* Make sure there's something to do */
+	if (!pid_type_enabled(type, pid_list, no_pid_list))
+		return;
+
+	if (!still_need_pid_events(type, pid_list, no_pid_list)) {
+		unregister_pid_events(tr);
+
+		list_for_each_entry(file, &tr->events, list) {
+			clear_bit(EVENT_FILE_FL_PID_FILTER_BIT, &file->flags);
+		}
+
+		for_each_possible_cpu(cpu)
+			per_cpu_ptr(tr->array_buffer.data, cpu)->ignore_pid = false;
 	}
 
-	for_each_possible_cpu(cpu)
-		per_cpu_ptr(tr->array_buffer.data, cpu)->ignore_pid = false;
+	if (type & TRACE_PIDS)
+		rcu_assign_pointer(tr->filtered_pids, NULL);
 
-	rcu_assign_pointer(tr->filtered_pids, NULL);
+	if (type & TRACE_NO_PIDS)
+		rcu_assign_pointer(tr->filtered_no_pids, NULL);
 
 	/* Wait till all users are no longer using pid filtering */
 	tracepoint_synchronize_unregister();
 
-	trace_free_pid_list(pid_list);
+	if ((type & TRACE_PIDS) && pid_list)
+		trace_free_pid_list(pid_list);
+
+	if ((type & TRACE_NO_PIDS) && no_pid_list)
+		trace_free_pid_list(no_pid_list);
 }
 
-static void ftrace_clear_event_pids(struct trace_array *tr)
+static void ftrace_clear_event_pids(struct trace_array *tr, int type)
 {
 	mutex_lock(&event_mutex);
-	__ftrace_clear_event_pids(tr);
+	__ftrace_clear_event_pids(tr, type);
 	mutex_unlock(&event_mutex);
 }
 
@@ -1013,15 +1058,32 @@ static void t_stop(struct seq_file *m, void *p)
 }
 
 static void *
-p_next(struct seq_file *m, void *v, loff_t *pos)
+__next(struct seq_file *m, void *v, loff_t *pos, int type)
 {
 	struct trace_array *tr = m->private;
-	struct trace_pid_list *pid_list = rcu_dereference_sched(tr->filtered_pids);
+	struct trace_pid_list *pid_list;
+
+	if (type == TRACE_PIDS)
+		pid_list = rcu_dereference_sched(tr->filtered_pids);
+	else
+		pid_list = rcu_dereference_sched(tr->filtered_no_pids);
 
 	return trace_pid_next(pid_list, v, pos);
 }
 
-static void *p_start(struct seq_file *m, loff_t *pos)
+static void *
+p_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return __next(m, v, pos, TRACE_PIDS);
+}
+
+static void *
+np_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return __next(m, v, pos, TRACE_NO_PIDS);
+}
+
+static void *__start(struct seq_file *m, loff_t *pos, int type)
 	__acquires(RCU)
 {
 	struct trace_pid_list *pid_list;
@@ -1036,7 +1098,10 @@ static void *p_start(struct seq_file *m, loff_t *pos)
 	mutex_lock(&event_mutex);
 	rcu_read_lock_sched();
 
-	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	if (type == TRACE_PIDS)
+		pid_list = rcu_dereference_sched(tr->filtered_pids);
+	else
+		pid_list = rcu_dereference_sched(tr->filtered_no_pids);
 
 	if (!pid_list)
 		return NULL;
@@ -1044,6 +1109,18 @@ static void *p_start(struct seq_file *m, loff_t *pos)
 	return trace_pid_start(pid_list, pos);
 }
 
+static void *p_start(struct seq_file *m, loff_t *pos)
+	__acquires(RCU)
+{
+	return __start(m, pos, TRACE_PIDS);
+}
+
+static void *np_start(struct seq_file *m, loff_t *pos)
+	__acquires(RCU)
+{
+	return __start(m, pos, TRACE_NO_PIDS);
+}
+
 static void p_stop(struct seq_file *m, void *p)
 	__releases(RCU)
 {
@@ -1588,6 +1665,7 @@ static void ignore_task_cpu(void *data)
 {
 	struct trace_array *tr = data;
 	struct trace_pid_list *pid_list;
+	struct trace_pid_list *no_pid_list;
 
 	/*
 	 * This function is called by on_each_cpu() while the
@@ -1595,18 +1673,50 @@ static void ignore_task_cpu(void *data)
 	 */
 	pid_list = rcu_dereference_protected(tr->filtered_pids,
 					     mutex_is_locked(&event_mutex));
+	no_pid_list = rcu_dereference_protected(tr->filtered_no_pids,
+					     mutex_is_locked(&event_mutex));
 
 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, NULL, current));
+		       trace_ignore_this_task(pid_list, no_pid_list, current));
+}
+
+static void register_pid_events(struct trace_array *tr)
+{
+	/*
+	 * Register a probe that is called before all other probes
+	 * to set ignore_pid if next or prev do not match.
+	 * Register a probe this is called after all other probes
+	 * to only keep ignore_pid set if next pid matches.
+	 */
+	register_trace_prio_sched_switch(event_filter_pid_sched_switch_probe_pre,
+					 tr, INT_MAX);
+	register_trace_prio_sched_switch(event_filter_pid_sched_switch_probe_post,
+					 tr, 0);
+
+	register_trace_prio_sched_wakeup(event_filter_pid_sched_wakeup_probe_pre,
+					 tr, INT_MAX);
+	register_trace_prio_sched_wakeup(event_filter_pid_sched_wakeup_probe_post,
+					 tr, 0);
+
+	register_trace_prio_sched_wakeup_new(event_filter_pid_sched_wakeup_probe_pre,
+					     tr, INT_MAX);
+	register_trace_prio_sched_wakeup_new(event_filter_pid_sched_wakeup_probe_post,
+					     tr, 0);
+
+	register_trace_prio_sched_waking(event_filter_pid_sched_wakeup_probe_pre,
+					 tr, INT_MAX);
+	register_trace_prio_sched_waking(event_filter_pid_sched_wakeup_probe_post,
+					 tr, 0);
 }
 
 static ssize_t
-ftrace_event_pid_write(struct file *filp, const char __user *ubuf,
-		       size_t cnt, loff_t *ppos)
+event_pid_write(struct file *filp, const char __user *ubuf,
+		size_t cnt, loff_t *ppos, int type)
 {
 	struct seq_file *m = filp->private_data;
 	struct trace_array *tr = m->private;
 	struct trace_pid_list *filtered_pids = NULL;
+	struct trace_pid_list *other_pids = NULL;
 	struct trace_pid_list *pid_list;
 	struct trace_event_file *file;
 	ssize_t ret;
@@ -1620,14 +1730,26 @@ ftrace_event_pid_write(struct file *filp, const char __user *ubuf,
 
 	mutex_lock(&event_mutex);
 
-	filtered_pids = rcu_dereference_protected(tr->filtered_pids,
-					     lockdep_is_held(&event_mutex));
+	if (type == TRACE_PIDS) {
+		filtered_pids = rcu_dereference_protected(tr->filtered_pids,
+							  lockdep_is_held(&event_mutex));
+		other_pids = rcu_dereference_protected(tr->filtered_no_pids,
+							  lockdep_is_held(&event_mutex));
+	} else {
+		filtered_pids = rcu_dereference_protected(tr->filtered_no_pids,
+							  lockdep_is_held(&event_mutex));
+		other_pids = rcu_dereference_protected(tr->filtered_pids,
+							  lockdep_is_held(&event_mutex));
+	}
 
 	ret = trace_pid_write(filtered_pids, &pid_list, ubuf, cnt);
 	if (ret < 0)
 		goto out;
 
-	rcu_assign_pointer(tr->filtered_pids, pid_list);
+	if (type == TRACE_PIDS)
+		rcu_assign_pointer(tr->filtered_pids, pid_list);
+	else
+		rcu_assign_pointer(tr->filtered_no_pids, pid_list);
 
 	list_for_each_entry(file, &tr->events, list) {
 		set_bit(EVENT_FILE_FL_PID_FILTER_BIT, &file->flags);
@@ -1636,32 +1758,8 @@ ftrace_event_pid_write(struct file *filp, const char __user *ubuf,
 	if (filtered_pids) {
 		tracepoint_synchronize_unregister();
 		trace_free_pid_list(filtered_pids);
-	} else if (pid_list) {
-		/*
-		 * Register a probe that is called before all other probes
-		 * to set ignore_pid if next or prev do not match.
-		 * Register a probe this is called after all other probes
-		 * to only keep ignore_pid set if next pid matches.
-		 */
-		register_trace_prio_sched_switch(event_filter_pid_sched_switch_probe_pre,
-						 tr, INT_MAX);
-		register_trace_prio_sched_switch(event_filter_pid_sched_switch_probe_post,
-						 tr, 0);
-
-		register_trace_prio_sched_wakeup(event_filter_pid_sched_wakeup_probe_pre,
-						 tr, INT_MAX);
-		register_trace_prio_sched_wakeup(event_filter_pid_sched_wakeup_probe_post,
-						 tr, 0);
-
-		register_trace_prio_sched_wakeup_new(event_filter_pid_sched_wakeup_probe_pre,
-						     tr, INT_MAX);
-		register_trace_prio_sched_wakeup_new(event_filter_pid_sched_wakeup_probe_post,
-						     tr, 0);
-
-		register_trace_prio_sched_waking(event_filter_pid_sched_wakeup_probe_pre,
-						 tr, INT_MAX);
-		register_trace_prio_sched_waking(event_filter_pid_sched_wakeup_probe_post,
-						 tr, 0);
+	} else if (pid_list && !other_pids) {
+		register_pid_events(tr);
 	}
 
 	/*
@@ -1680,9 +1778,24 @@ ftrace_event_pid_write(struct file *filp, const char __user *ubuf,
 	return ret;
 }
 
+static ssize_t
+ftrace_event_pid_write(struct file *filp, const char __user *ubuf,
+		       size_t cnt, loff_t *ppos)
+{
+	return event_pid_write(filp, ubuf, cnt, ppos, TRACE_PIDS);
+}
+
+static ssize_t
+ftrace_event_npid_write(struct file *filp, const char __user *ubuf,
+			size_t cnt, loff_t *ppos)
+{
+	return event_pid_write(filp, ubuf, cnt, ppos, TRACE_NO_PIDS);
+}
+
 static int ftrace_event_avail_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_pid_open(struct inode *inode, struct file *file);
+static int ftrace_event_set_npid_open(struct inode *inode, struct file *file);
 static int ftrace_event_release(struct inode *inode, struct file *file);
 
 static const struct seq_operations show_event_seq_ops = {
@@ -1706,6 +1819,13 @@ static const struct seq_operations show_set_pid_seq_ops = {
 	.stop = p_stop,
 };
 
+static const struct seq_operations show_set_no_pid_seq_ops = {
+	.start = np_start,
+	.next = np_next,
+	.show = trace_pid_show,
+	.stop = p_stop,
+};
+
 static const struct file_operations ftrace_avail_fops = {
 	.open = ftrace_event_avail_open,
 	.read = seq_read,
@@ -1729,6 +1849,14 @@ static const struct file_operations ftrace_set_event_pid_fops = {
 	.release = ftrace_event_release,
 };
 
+static const struct file_operations ftrace_set_event_notrace_pid_fops = {
+	.open = ftrace_event_set_npid_open,
+	.read = seq_read,
+	.write = ftrace_event_npid_write,
+	.llseek = seq_lseek,
+	.release = ftrace_event_release,
+};
+
 static const struct file_operations ftrace_enable_fops = {
 	.open = tracing_open_generic,
 	.read = event_enable_read,
@@ -1858,7 +1986,28 @@ ftrace_event_set_pid_open(struct inode *inode, struct file *file)
 
 	if ((file->f_mode & FMODE_WRITE) &&
 	    (file->f_flags & O_TRUNC))
-		ftrace_clear_event_pids(tr);
+		ftrace_clear_event_pids(tr, TRACE_PIDS);
+
+	ret = ftrace_event_open(inode, file, seq_ops);
+	if (ret < 0)
+		trace_array_put(tr);
+	return ret;
+}
+
+static int
+ftrace_event_set_npid_open(struct inode *inode, struct file *file)
+{
+	const struct seq_operations *seq_ops = &show_set_no_pid_seq_ops;
+	struct trace_array *tr = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	if ((file->f_mode & FMODE_WRITE) &&
+	    (file->f_flags & O_TRUNC))
+		ftrace_clear_event_pids(tr, TRACE_NO_PIDS);
 
 	ret = ftrace_event_open(inode, file, seq_ops);
 	if (ret < 0)
@@ -3075,6 +3224,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 	if (!entry)
 		pr_warn("Could not create tracefs 'set_event_pid' entry\n");
 
+	entry = tracefs_create_file("set_event_notrace_pid", 0644, parent,
+				    tr, &ftrace_set_event_notrace_pid_fops);
+	if (!entry)
+		pr_warn("Could not create tracefs 'set_event_notrace_pid' entry\n");
+
 	/* ring buffer internal formats */
 	entry = trace_create_file("header_page", 0444, d_events,
 				  ring_buffer_print_page_header,
@@ -3158,7 +3312,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 	clear_event_triggers(tr);
 
 	/* Clear the pid list */
-	__ftrace_clear_event_pids(tr);
+	__ftrace_clear_event_pids(tr, TRACE_PIDS | TRACE_NO_PIDS);
 
 	/* Disable any running events */
 	__ftrace_set_clr_event_nolock(tr, NULL, NULL, NULL, 0);
-- 
2.25.1


