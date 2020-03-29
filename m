Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED178C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BF3206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgC2Sn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbgC2SnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24AE520787;
        Sun, 29 Mar 2020 18:43:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIcty-002Fz8-1b; Sun, 29 Mar 2020 14:43:18 -0400
Message-Id: <20200329184317.931947778@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:43:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 17/21] ftrace: Create set_ftrace_notrace_pid to not trace tasks
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There's currently a way to select a task that should only be traced by
functions, but there's no way to select a task not to be traced by the
function tracer. Add a set_ftrace_notrace_pid file that acts the same as
set_ftrace_pid (and is also affected by function-fork), but the task pids in
this file will not be traced even if they are listed in the set_ftrace_pid
file. This makes it easy for tools like trace-cmd to "hide" itself from the
function tracer when it is recording other tasks.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c       | 181 +++++++++++++++++++++++++++++++-----
 kernel/trace/trace.c        |  20 ++--
 kernel/trace/trace.h        |   2 +
 kernel/trace/trace_events.c |  12 +--
 4 files changed, 180 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 34ae736cb1f8..7239d9acd09f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -102,7 +102,7 @@ static bool ftrace_pids_enabled(struct ftrace_ops *ops)
 
 	tr = ops->private;
 
-	return tr->function_pids != NULL;
+	return tr->function_pids != NULL || tr->function_no_pids != NULL;
 }
 
 static void ftrace_update_trampoline(struct ftrace_ops *ops);
@@ -6931,10 +6931,12 @@ ftrace_filter_pid_sched_switch_probe(void *data, bool preempt,
 {
 	struct trace_array *tr = data;
 	struct trace_pid_list *pid_list;
+	struct trace_pid_list *no_pid_list;
 
 	pid_list = rcu_dereference_sched(tr->function_pids);
+	no_pid_list = rcu_dereference_sched(tr->function_no_pids);
 
-	if (trace_ignore_this_task(pid_list, next))
+	if (trace_ignore_this_task(pid_list, no_pid_list, next))
 		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
 			       FTRACE_PID_IGNORE);
 	else
@@ -6952,6 +6954,9 @@ ftrace_pid_follow_sched_process_fork(void *data,
 
 	pid_list = rcu_dereference_sched(tr->function_pids);
 	trace_filter_add_remove_task(pid_list, self, task);
+
+	pid_list = rcu_dereference_sched(tr->function_no_pids);
+	trace_filter_add_remove_task(pid_list, self, task);
 }
 
 static void
@@ -6962,6 +6967,9 @@ ftrace_pid_follow_sched_process_exit(void *data, struct task_struct *task)
 
 	pid_list = rcu_dereference_sched(tr->function_pids);
 	trace_filter_add_remove_task(pid_list, NULL, task);
+
+	pid_list = rcu_dereference_sched(tr->function_no_pids);
+	trace_filter_add_remove_task(pid_list, NULL, task);
 }
 
 void ftrace_pid_follow_fork(struct trace_array *tr, bool enable)
@@ -6979,42 +6987,64 @@ void ftrace_pid_follow_fork(struct trace_array *tr, bool enable)
 	}
 }
 
-static void clear_ftrace_pids(struct trace_array *tr)
+enum {
+	TRACE_PIDS		= BIT(0),
+	TRACE_NO_PIDS		= BIT(1),
+};
+
+static void clear_ftrace_pids(struct trace_array *tr, int type)
 {
 	struct trace_pid_list *pid_list;
+	struct trace_pid_list *no_pid_list;
 	int cpu;
 
 	pid_list = rcu_dereference_protected(tr->function_pids,
 					     lockdep_is_held(&ftrace_lock));
-	if (!pid_list)
+	no_pid_list = rcu_dereference_protected(tr->function_no_pids,
+						lockdep_is_held(&ftrace_lock));
+
+	/* Make sure there's something to do */
+	if (!(((type & TRACE_PIDS) && pid_list) ||
+	      ((type & TRACE_NO_PIDS) && no_pid_list)))
 		return;
 
-	unregister_trace_sched_switch(ftrace_filter_pid_sched_switch_probe, tr);
+	/* See if the pids still need to be checked after this */
+	if (!((!(type & TRACE_PIDS) && pid_list) ||
+	      (!(type & TRACE_NO_PIDS) && no_pid_list))) {
+		unregister_trace_sched_switch(ftrace_filter_pid_sched_switch_probe, tr);
+		for_each_possible_cpu(cpu)
+			per_cpu_ptr(tr->array_buffer.data, cpu)->ftrace_ignore_pid = FTRACE_PID_TRACE;
+	}
 
-	for_each_possible_cpu(cpu)
-		per_cpu_ptr(tr->array_buffer.data, cpu)->ftrace_ignore_pid = FTRACE_PID_TRACE;
+	if (type & TRACE_PIDS)
+		rcu_assign_pointer(tr->function_pids, NULL);
 
-	rcu_assign_pointer(tr->function_pids, NULL);
+	if (type & TRACE_NO_PIDS)
+		rcu_assign_pointer(tr->function_no_pids, NULL);
 
 	/* Wait till all users are no longer using pid filtering */
 	synchronize_rcu();
 
-	trace_free_pid_list(pid_list);
+	if ((type & TRACE_PIDS) && pid_list)
+		trace_free_pid_list(pid_list);
+
+	if ((type & TRACE_NO_PIDS) && no_pid_list)
+		trace_free_pid_list(no_pid_list);
 }
 
 void ftrace_clear_pids(struct trace_array *tr)
 {
 	mutex_lock(&ftrace_lock);
 
-	clear_ftrace_pids(tr);
+	clear_ftrace_pids(tr, TRACE_PIDS | TRACE_NO_PIDS);
 
 	mutex_unlock(&ftrace_lock);
 }
 
-static void ftrace_pid_reset(struct trace_array *tr)
+static void ftrace_pid_reset(struct trace_array *tr, int type)
 {
 	mutex_lock(&ftrace_lock);
-	clear_ftrace_pids(tr);
+	clear_ftrace_pids(tr, type);
 
 	ftrace_update_pid_func();
 	ftrace_startup_all(0);
@@ -7078,9 +7108,45 @@ static const struct seq_operations ftrace_pid_sops = {
 	.show = fpid_show,
 };
 
-static int
-ftrace_pid_open(struct inode *inode, struct file *file)
+static void *fnpid_start(struct seq_file *m, loff_t *pos)
+	__acquires(RCU)
+{
+	struct trace_pid_list *pid_list;
+	struct trace_array *tr = m->private;
+
+	mutex_lock(&ftrace_lock);
+	rcu_read_lock_sched();
+
+	pid_list = rcu_dereference_sched(tr->function_no_pids);
+
+	if (!pid_list)
+		return !(*pos) ? FTRACE_NO_PIDS : NULL;
+
+	return trace_pid_start(pid_list, pos);
+}
+
+static void *fnpid_next(struct seq_file *m, void *v, loff_t *pos)
 {
+	struct trace_array *tr = m->private;
+	struct trace_pid_list *pid_list = rcu_dereference_sched(tr->function_no_pids);
+
+	if (v == FTRACE_NO_PIDS) {
+		(*pos)++;
+		return NULL;
+	}
+	return trace_pid_next(pid_list, v, pos);
+}
+
+static const struct seq_operations ftrace_no_pid_sops = {
+	.start = fnpid_start,
+	.next = fnpid_next,
+	.stop = fpid_stop,
+	.show = fpid_show,
+};
+
+static int pid_open(struct inode *inode, struct file *file, int type)
+{
+	const struct seq_operations *seq_ops;
 	struct trace_array *tr = inode->i_private;
 	struct seq_file *m;
 	int ret = 0;
@@ -7091,9 +7157,18 @@ ftrace_pid_open(struct inode *inode, struct file *file)
 
 	if ((file->f_mode & FMODE_WRITE) &&
 	    (file->f_flags & O_TRUNC))
-		ftrace_pid_reset(tr);
+		ftrace_pid_reset(tr, type);
+
+	switch (type) {
+	case TRACE_PIDS:
+		seq_ops = &ftrace_pid_sops;
+		break;
+	case TRACE_NO_PIDS:
+		seq_ops = &ftrace_no_pid_sops;
+		break;
+	}
 
-	ret = seq_open(file, &ftrace_pid_sops);
+	ret = seq_open(file, seq_ops);
 	if (ret < 0) {
 		trace_array_put(tr);
 	} else {
@@ -7105,10 +7180,23 @@ ftrace_pid_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static int
+ftrace_pid_open(struct inode *inode, struct file *file)
+{
+	return pid_open(inode, file, TRACE_PIDS);
+}
+
+static int
+ftrace_no_pid_open(struct inode *inode, struct file *file)
+{
+	return pid_open(inode, file, TRACE_NO_PIDS);
+}
+
 static void ignore_task_cpu(void *data)
 {
 	struct trace_array *tr = data;
 	struct trace_pid_list *pid_list;
+	struct trace_pid_list *no_pid_list;
 
 	/*
 	 * This function is called by on_each_cpu() while the
@@ -7116,8 +7204,10 @@ static void ignore_task_cpu(void *data)
 	 */
 	pid_list = rcu_dereference_protected(tr->function_pids,
 					     mutex_is_locked(&ftrace_lock));
+	no_pid_list = rcu_dereference_protected(tr->function_no_pids,
+						mutex_is_locked(&ftrace_lock));
 
-	if (trace_ignore_this_task(pid_list, current))
+	if (trace_ignore_this_task(pid_list, no_pid_list, current))
 		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
 			       FTRACE_PID_IGNORE);
 	else
@@ -7126,12 +7216,13 @@ static void ignore_task_cpu(void *data)
 }
 
 static ssize_t
-ftrace_pid_write(struct file *filp, const char __user *ubuf,
-		   size_t cnt, loff_t *ppos)
+pid_write(struct file *filp, const char __user *ubuf,
+	  size_t cnt, loff_t *ppos, int type)
 {
 	struct seq_file *m = filp->private_data;
 	struct trace_array *tr = m->private;
-	struct trace_pid_list *filtered_pids = NULL;
+	struct trace_pid_list *filtered_pids;
+	struct trace_pid_list *other_pids;
 	struct trace_pid_list *pid_list;
 	ssize_t ret;
 
@@ -7140,19 +7231,39 @@ ftrace_pid_write(struct file *filp, const char __user *ubuf,
 
 	mutex_lock(&ftrace_lock);
 
-	filtered_pids = rcu_dereference_protected(tr->function_pids,
+	switch (type) {
+	case TRACE_PIDS:
+		filtered_pids = rcu_dereference_protected(tr->function_pids,
 					     lockdep_is_held(&ftrace_lock));
+		other_pids = rcu_dereference_protected(tr->function_no_pids,
+					     lockdep_is_held(&ftrace_lock));
+		break;
+	case TRACE_NO_PIDS:
+		filtered_pids = rcu_dereference_protected(tr->function_no_pids,
+					     lockdep_is_held(&ftrace_lock));
+		other_pids = rcu_dereference_protected(tr->function_pids,
+					     lockdep_is_held(&ftrace_lock));
+		break;
+	}
 
 	ret = trace_pid_write(filtered_pids, &pid_list, ubuf, cnt);
 	if (ret < 0)
 		goto out;
 
-	rcu_assign_pointer(tr->function_pids, pid_list);
+	switch (type) {
+	case TRACE_PIDS:
+		rcu_assign_pointer(tr->function_pids, pid_list);
+		break;
+	case TRACE_NO_PIDS:
+		rcu_assign_pointer(tr->function_no_pids, pid_list);
+		break;
+	}
+
 
 	if (filtered_pids) {
 		synchronize_rcu();
 		trace_free_pid_list(filtered_pids);
-	} else if (pid_list) {
+	} else if (pid_list && !other_pids) {
 		/* Register a probe to set whether to ignore the tracing of a task */
 		register_trace_sched_switch(ftrace_filter_pid_sched_switch_probe, tr);
 	}
@@ -7175,6 +7286,20 @@ ftrace_pid_write(struct file *filp, const char __user *ubuf,
 	return ret;
 }
 
+static ssize_t
+ftrace_pid_write(struct file *filp, const char __user *ubuf,
+		 size_t cnt, loff_t *ppos)
+{
+	return pid_write(filp, ubuf, cnt, ppos, TRACE_PIDS);
+}
+
+static ssize_t
+ftrace_no_pid_write(struct file *filp, const char __user *ubuf,
+		    size_t cnt, loff_t *ppos)
+{
+	return pid_write(filp, ubuf, cnt, ppos, TRACE_NO_PIDS);
+}
+
 static int
 ftrace_pid_release(struct inode *inode, struct file *file)
 {
@@ -7193,10 +7318,20 @@ static const struct file_operations ftrace_pid_fops = {
 	.release	= ftrace_pid_release,
 };
 
+static const struct file_operations ftrace_no_pid_fops = {
+	.open		= ftrace_no_pid_open,
+	.write		= ftrace_no_pid_write,
+	.read		= seq_read,
+	.llseek		= tracing_lseek,
+	.release	= ftrace_pid_release,
+};
+
 void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
 	trace_create_file("set_ftrace_pid", 0644, d_tracer,
 			    tr, &ftrace_pid_fops);
+	trace_create_file("set_ftrace_notrace_pid", 0644, d_tracer,
+			    tr, &ftrace_no_pid_fops);
 }
 
 void __init ftrace_init_tracefs_toplevel(struct trace_array *tr,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5e634b9c1e0a..6519b7afc499 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -386,16 +386,22 @@ trace_find_filtered_pid(struct trace_pid_list *filtered_pids, pid_t search_pid)
  * Returns false if @task should be traced.
  */
 bool
-trace_ignore_this_task(struct trace_pid_list *filtered_pids, struct task_struct *task)
+trace_ignore_this_task(struct trace_pid_list *filtered_pids,
+		       struct trace_pid_list *filtered_no_pids,
+		       struct task_struct *task)
 {
 	/*
-	 * Return false, because if filtered_pids does not exist,
-	 * all pids are good to trace.
+	 * If filterd_no_pids is not empty, and the task's pid is listed
+	 * in filtered_no_pids, then return true.
+	 * Otherwise, if filtered_pids is empty, that means we can
+	 * trace all tasks. If it has content, then only trace pids
+	 * within filtered_pids.
 	 */
-	if (!filtered_pids)
-		return false;
 
-	return !trace_find_filtered_pid(filtered_pids, task->pid);
+	return (filtered_pids &&
+		!trace_find_filtered_pid(filtered_pids, task->pid)) ||
+		(filtered_no_pids &&
+		 trace_find_filtered_pid(filtered_no_pids, task->pid));
 }
 
 /**
@@ -5013,6 +5019,8 @@ static const char readme_msg[] =
 #ifdef CONFIG_FUNCTION_TRACER
 	"  set_ftrace_pid\t- Write pid(s) to only function trace those pids\n"
 	"\t\t    (function)\n"
+	"  set_ftrace_notrace_pid\t- Write pid(s) to not function trace those pids\n"
+	"\t\t    (function)\n"
 #endif
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	"  set_graph_function\t- Trace the nested calls of a function (function_graph)\n"
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index fdc72f5f0bb0..6b5ff5adb4ad 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -331,6 +331,7 @@ struct trace_array {
 #ifdef CONFIG_FUNCTION_TRACER
 	struct ftrace_ops	*ops;
 	struct trace_pid_list	__rcu *function_pids;
+	struct trace_pid_list	__rcu *function_no_pids;
 #ifdef CONFIG_DYNAMIC_FTRACE
 	/* All of these are protected by the ftrace_lock */
 	struct list_head	func_probes;
@@ -782,6 +783,7 @@ extern int pid_max;
 bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
 			     pid_t search_pid);
 bool trace_ignore_this_task(struct trace_pid_list *filtered_pids,
+			    struct trace_pid_list *filtered_no_pids,
 			    struct task_struct *task);
 void trace_filter_add_remove_task(struct trace_pid_list *pid_list,
 				  struct task_struct *self,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f38234ecea18..c196d0dc5871 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -549,8 +549,8 @@ event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
 
 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, prev) &&
-		       trace_ignore_this_task(pid_list, next));
+		       trace_ignore_this_task(pid_list, NULL, prev) &&
+		       trace_ignore_this_task(pid_list, NULL, next));
 }
 
 static void
@@ -563,7 +563,7 @@ event_filter_pid_sched_switch_probe_post(void *data, bool preempt,
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
 
 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, next));
+		       trace_ignore_this_task(pid_list, NULL, next));
 }
 
 static void
@@ -579,7 +579,7 @@ event_filter_pid_sched_wakeup_probe_pre(void *data, struct task_struct *task)
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
 
 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, task));
+		       trace_ignore_this_task(pid_list, NULL, task));
 }
 
 static void
@@ -596,7 +596,7 @@ event_filter_pid_sched_wakeup_probe_post(void *data, struct task_struct *task)
 
 	/* Set tracing if current is enabled */
 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, current));
+		       trace_ignore_this_task(pid_list, NULL, current));
 }
 
 static void __ftrace_clear_event_pids(struct trace_array *tr)
@@ -1597,7 +1597,7 @@ static void ignore_task_cpu(void *data)
 					     mutex_is_locked(&event_mutex));
 
 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, current));
+		       trace_ignore_this_task(pid_list, NULL, current));
 }
 
 static ssize_t
-- 
2.25.1


