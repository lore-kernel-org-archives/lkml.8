Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5440C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF876207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgAUOtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:49:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:32782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgAUOtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:49:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63EFD207E0;
        Tue, 21 Jan 2020 14:49:07 +0000 (UTC)
Date:   Tue, 21 Jan 2020 09:49:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Fixes for v5.5
Message-ID: <20200121094906.421206d7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Various tracing fixes:

 - Fix a function comparison warning for a xen trace event macro
 - Fix a double perf_event linking to a trace_uprobe_filter for multiple events
 - Fix suspicious RCU warnings in trace event code for using
    list_for_each_entry_rcu() when the "_rcu" portion wasn't needed.
 - Fix a bug in the histogram code when using the same variable
 - Fix a NULL pointer dereference when tracefs lockdown enabled and calling
    trace_set_default_clock()


Please pull the latest trace-v5.5-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.5-rc6

Tag SHA1: f920461f2655601c33276a60a2fb39d0b4f24e28
Head SHA1: bf24daac8f2bd5b8affaec03c2be1d20bcdd6837


Changbin Du (1):
      tracing: xen: Ordered comparison of function pointers

Masami Hiramatsu (2):
      tracing/uprobe: Fix double perf_event linking on multiprobe uprobe
      tracing: trigger: Replace unneeded RCU-list traversals

Masami Ichikawa (1):
      tracing: Do not set trace clock if tracefs lockdown is in effect

Steven Rostedt (VMware) (1):
      tracing: Fix histogram code when expression has same var as value

----
 include/trace/events/xen.h          |   6 +-
 kernel/trace/trace.c                |   5 ++
 kernel/trace/trace_events_hist.c    |  63 ++++++++++++++----
 kernel/trace/trace_events_trigger.c |  20 ++++--
 kernel/trace/trace_kprobe.c         |   2 +-
 kernel/trace/trace_probe.c          |   5 +-
 kernel/trace/trace_probe.h          |   3 +-
 kernel/trace/trace_uprobe.c         | 124 +++++++++++++++++++++++-------------
 8 files changed, 163 insertions(+), 65 deletions(-)
---------------------------
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index 9a0e8af21310..a5ccfa67bc5c 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -66,7 +66,11 @@ TRACE_EVENT(xen_mc_callback,
 	    TP_PROTO(xen_mc_callback_fn_t fn, void *data),
 	    TP_ARGS(fn, data),
 	    TP_STRUCT__entry(
-		    __field(xen_mc_callback_fn_t, fn)
+		    /*
+		     * Use field_struct to avoid is_signed_type()
+		     * comparison of a function pointer.
+		     */
+		    __field_struct(xen_mc_callback_fn_t, fn)
 		    __field(void *, data)
 		    ),
 	    TP_fast_assign(
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ddb7e7f5fe8d..5b6ee4aadc26 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9420,6 +9420,11 @@ __init static int tracing_set_default_clock(void)
 {
 	/* sched_clock_stable() is determined in late_initcall */
 	if (!trace_boot_clock && !sched_clock_stable()) {
+		if (security_locked_down(LOCKDOWN_TRACEFS)) {
+			pr_warn("Can not set tracing clock due to lockdown\n");
+			return -EPERM;
+		}
+
 		printk(KERN_WARNING
 		       "Unstable clock detected, switching default tracing clock to \"global\"\n"
 		       "If you want to keep using the local clock, then add:\n"
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f62de5f43e79..6ac35b9e195d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -116,6 +116,7 @@ struct hist_field {
 	struct ftrace_event_field	*field;
 	unsigned long			flags;
 	hist_field_fn_t			fn;
+	unsigned int			ref;
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
@@ -1766,11 +1767,13 @@ static struct hist_field *find_var(struct hist_trigger_data *hist_data,
 	struct event_trigger_data *test;
 	struct hist_field *hist_field;
 
+	lockdep_assert_held(&event_mutex);
+
 	hist_field = find_var_field(hist_data, var_name);
 	if (hist_field)
 		return hist_field;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			test_data = test->private_data;
 			hist_field = find_var_field(test_data, var_name);
@@ -1820,7 +1823,9 @@ static struct hist_field *find_file_var(struct trace_event_file *file,
 	struct event_trigger_data *test;
 	struct hist_field *hist_field;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			test_data = test->private_data;
 			hist_field = find_var_field(test_data, var_name);
@@ -2423,8 +2428,16 @@ static int contains_operator(char *str)
 	return field_op;
 }
 
+static void get_hist_field(struct hist_field *hist_field)
+{
+	hist_field->ref++;
+}
+
 static void __destroy_hist_field(struct hist_field *hist_field)
 {
+	if (--hist_field->ref > 1)
+		return;
+
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
 	kfree(hist_field->type);
@@ -2466,6 +2479,8 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (!hist_field)
 		return NULL;
 
+	hist_field->ref = 1;
+
 	hist_field->hist_data = hist_data;
 
 	if (flags & HIST_FIELD_FL_EXPR || flags & HIST_FIELD_FL_ALIAS)
@@ -2661,6 +2676,17 @@ static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
 {
 	unsigned long flags = HIST_FIELD_FL_VAR_REF;
 	struct hist_field *ref_field;
+	int i;
+
+	/* Check if the variable already exists */
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		ref_field = hist_data->var_refs[i];
+		if (ref_field->var.idx == var_field->var.idx &&
+		    ref_field->var.hist_data == var_field->hist_data) {
+			get_hist_field(ref_field);
+			return ref_field;
+		}
+	}
 
 	ref_field = create_hist_field(var_field->hist_data, NULL, flags, NULL);
 	if (ref_field) {
@@ -3115,7 +3141,9 @@ static char *find_trigger_filter(struct hist_trigger_data *hist_data,
 {
 	struct event_trigger_data *test;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (test->private_data == hist_data)
 				return test->filter_str;
@@ -3166,9 +3194,11 @@ find_compatible_hist(struct hist_trigger_data *target_hist_data,
 	struct event_trigger_data *test;
 	unsigned int n_keys;
 
+	lockdep_assert_held(&event_mutex);
+
 	n_keys = target_hist_data->n_fields - target_hist_data->n_vals;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			hist_data = test->private_data;
 
@@ -5528,7 +5558,7 @@ static int hist_show(struct seq_file *m, void *v)
 		goto out_unlock;
 	}
 
-	list_for_each_entry_rcu(data, &event_file->triggers, list) {
+	list_for_each_entry(data, &event_file->triggers, list) {
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
 			hist_trigger_show(m, data, n++);
 	}
@@ -5921,7 +5951,9 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 	if (hist_data->attrs->name && !named_data)
 		goto new;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (!hist_trigger_match(data, test, named_data, false))
 				continue;
@@ -6005,10 +6037,12 @@ static bool have_hist_trigger_match(struct event_trigger_data *data,
 	struct event_trigger_data *test, *named_data = NULL;
 	bool match = false;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (hist_data->attrs->name)
 		named_data = find_named_trigger(hist_data->attrs->name);
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (hist_trigger_match(data, test, named_data, false)) {
 				match = true;
@@ -6026,10 +6060,12 @@ static bool hist_trigger_check_refs(struct event_trigger_data *data,
 	struct hist_trigger_data *hist_data = data->private_data;
 	struct event_trigger_data *test, *named_data = NULL;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (hist_data->attrs->name)
 		named_data = find_named_trigger(hist_data->attrs->name);
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (!hist_trigger_match(data, test, named_data, false))
 				continue;
@@ -6051,10 +6087,12 @@ static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 	struct event_trigger_data *test, *named_data = NULL;
 	bool unregistered = false;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (hist_data->attrs->name)
 		named_data = find_named_trigger(hist_data->attrs->name);
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (!hist_trigger_match(data, test, named_data, false))
 				continue;
@@ -6080,7 +6118,9 @@ static bool hist_file_check_refs(struct trace_event_file *file)
 	struct hist_trigger_data *hist_data;
 	struct event_trigger_data *test;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			hist_data = test->private_data;
 			if (check_var_refs(hist_data))
@@ -6323,7 +6363,8 @@ hist_enable_trigger(struct event_trigger_data *data, void *rec,
 	struct enable_trigger_data *enable_data = data->private_data;
 	struct event_trigger_data *test;
 
-	list_for_each_entry_rcu(test, &enable_data->file->triggers, list) {
+	list_for_each_entry_rcu(test, &enable_data->file->triggers, list,
+				lockdep_is_held(&event_mutex)) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (enable_data->enable)
 				test->paused = false;
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 2cd53ca21b51..40106fff06a4 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -501,7 +501,9 @@ void update_cond_flag(struct trace_event_file *file)
 	struct event_trigger_data *data;
 	bool set_cond = false;
 
-	list_for_each_entry_rcu(data, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(data, &file->triggers, list) {
 		if (data->filter || event_command_post_trigger(data->cmd_ops) ||
 		    event_command_needs_rec(data->cmd_ops)) {
 			set_cond = true;
@@ -536,7 +538,9 @@ static int register_trigger(char *glob, struct event_trigger_ops *ops,
 	struct event_trigger_data *test;
 	int ret = 0;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type) {
 			ret = -EEXIST;
 			goto out;
@@ -581,7 +585,9 @@ static void unregister_trigger(char *glob, struct event_trigger_ops *ops,
 	struct event_trigger_data *data;
 	bool unregistered = false;
 
-	list_for_each_entry_rcu(data, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(data, &file->triggers, list) {
 		if (data->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
 			unregistered = true;
 			list_del_rcu(&data->list);
@@ -1497,7 +1503,9 @@ int event_enable_register_trigger(char *glob,
 	struct event_trigger_data *test;
 	int ret = 0;
 
-	list_for_each_entry_rcu(test, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
 		test_enable_data = test->private_data;
 		if (test_enable_data &&
 		    (test->cmd_ops->trigger_type ==
@@ -1537,7 +1545,9 @@ void event_enable_unregister_trigger(char *glob,
 	struct event_trigger_data *data;
 	bool unregistered = false;
 
-	list_for_each_entry_rcu(data, &file->triggers, list) {
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(data, &file->triggers, list) {
 		enable_data = data->private_data;
 		if (enable_data &&
 		    (data->cmd_ops->trigger_type ==
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7f890262c8a3..3e5f9c7d939c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -290,7 +290,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 	INIT_HLIST_NODE(&tk->rp.kp.hlist);
 	INIT_LIST_HEAD(&tk->rp.kp.list);
 
-	ret = trace_probe_init(&tk->tp, event, group);
+	ret = trace_probe_init(&tk->tp, event, group, 0);
 	if (ret < 0)
 		goto error;
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 905b10af5d5c..bba18cf44a30 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -984,7 +984,7 @@ void trace_probe_cleanup(struct trace_probe *tp)
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
-		     const char *group)
+		     const char *group, size_t event_data_size)
 {
 	struct trace_event_call *call;
 	int ret = 0;
@@ -992,7 +992,8 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 	if (!event || !group)
 		return -EINVAL;
 
-	tp->event = kzalloc(sizeof(struct trace_probe_event), GFP_KERNEL);
+	tp->event = kzalloc(sizeof(struct trace_probe_event) + event_data_size,
+			    GFP_KERNEL);
 	if (!tp->event)
 		return -ENOMEM;
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 4ee703728aec..03e4e180058d 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -230,6 +230,7 @@ struct trace_probe_event {
 	struct trace_event_call		call;
 	struct list_head 		files;
 	struct list_head		probes;
+	char				data[0];
 };
 
 struct trace_probe {
@@ -322,7 +323,7 @@ static inline bool trace_probe_has_single_file(struct trace_probe *tp)
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
-		     const char *group);
+		     const char *group, size_t event_data_size);
 void trace_probe_cleanup(struct trace_probe *tp);
 int trace_probe_append(struct trace_probe *tp, struct trace_probe *to);
 void trace_probe_unlink(struct trace_probe *tp);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 352073d36585..f66e202fec13 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -60,7 +60,6 @@ static struct dyn_event_operations trace_uprobe_ops = {
  */
 struct trace_uprobe {
 	struct dyn_event		devent;
-	struct trace_uprobe_filter	filter;
 	struct uprobe_consumer		consumer;
 	struct path			path;
 	struct inode			*inode;
@@ -264,6 +263,14 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
 
+static struct trace_uprobe_filter *
+trace_uprobe_get_filter(struct trace_uprobe *tu)
+{
+	struct trace_probe_event *event = tu->tp.event;
+
+	return (struct trace_uprobe_filter *)&event->data[0];
+}
+
 static inline void init_trace_uprobe_filter(struct trace_uprobe_filter *filter)
 {
 	rwlock_init(&filter->rwlock);
@@ -351,7 +358,8 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	if (!tu)
 		return ERR_PTR(-ENOMEM);
 
-	ret = trace_probe_init(&tu->tp, event, group);
+	ret = trace_probe_init(&tu->tp, event, group,
+				sizeof(struct trace_uprobe_filter));
 	if (ret < 0)
 		goto error;
 
@@ -359,7 +367,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	tu->consumer.handler = uprobe_dispatcher;
 	if (is_ret)
 		tu->consumer.ret_handler = uretprobe_dispatcher;
-	init_trace_uprobe_filter(&tu->filter);
+	init_trace_uprobe_filter(trace_uprobe_get_filter(tu));
 	return tu;
 
 error:
@@ -1067,13 +1075,14 @@ static void __probe_event_disable(struct trace_probe *tp)
 	struct trace_probe *pos;
 	struct trace_uprobe *tu;
 
+	tu = container_of(tp, struct trace_uprobe, tp);
+	WARN_ON(!uprobe_filter_is_empty(trace_uprobe_get_filter(tu)));
+
 	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
 		tu = container_of(pos, struct trace_uprobe, tp);
 		if (!tu->inode)
 			continue;
 
-		WARN_ON(!uprobe_filter_is_empty(&tu->filter));
-
 		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
 		tu->inode = NULL;
 	}
@@ -1108,7 +1117,7 @@ static int probe_event_enable(struct trace_event_call *call,
 	}
 
 	tu = container_of(tp, struct trace_uprobe, tp);
-	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
+	WARN_ON(!uprobe_filter_is_empty(trace_uprobe_get_filter(tu)));
 
 	if (enabled)
 		return 0;
@@ -1205,39 +1214,39 @@ __uprobe_perf_filter(struct trace_uprobe_filter *filter, struct mm_struct *mm)
 }
 
 static inline bool
-uprobe_filter_event(struct trace_uprobe *tu, struct perf_event *event)
+trace_uprobe_filter_event(struct trace_uprobe_filter *filter,
+			  struct perf_event *event)
 {
-	return __uprobe_perf_filter(&tu->filter, event->hw.target->mm);
+	return __uprobe_perf_filter(filter, event->hw.target->mm);
 }
 
-static int uprobe_perf_close(struct trace_uprobe *tu, struct perf_event *event)
+static bool trace_uprobe_filter_remove(struct trace_uprobe_filter *filter,
+				       struct perf_event *event)
 {
 	bool done;
 
-	write_lock(&tu->filter.rwlock);
+	write_lock(&filter->rwlock);
 	if (event->hw.target) {
 		list_del(&event->hw.tp_list);
-		done = tu->filter.nr_systemwide ||
+		done = filter->nr_systemwide ||
 			(event->hw.target->flags & PF_EXITING) ||
-			uprobe_filter_event(tu, event);
+			trace_uprobe_filter_event(filter, event);
 	} else {
-		tu->filter.nr_systemwide--;
-		done = tu->filter.nr_systemwide;
+		filter->nr_systemwide--;
+		done = filter->nr_systemwide;
 	}
-	write_unlock(&tu->filter.rwlock);
-
-	if (!done)
-		return uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
+	write_unlock(&filter->rwlock);
 
-	return 0;
+	return done;
 }
 
-static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event *event)
+/* This returns true if the filter always covers target mm */
+static bool trace_uprobe_filter_add(struct trace_uprobe_filter *filter,
+				    struct perf_event *event)
 {
 	bool done;
-	int err;
 
-	write_lock(&tu->filter.rwlock);
+	write_lock(&filter->rwlock);
 	if (event->hw.target) {
 		/*
 		 * event->parent != NULL means copy_process(), we can avoid
@@ -1247,28 +1256,21 @@ static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event *event)
 		 * attr.enable_on_exec means that exec/mmap will install the
 		 * breakpoints we need.
 		 */
-		done = tu->filter.nr_systemwide ||
+		done = filter->nr_systemwide ||
 			event->parent || event->attr.enable_on_exec ||
-			uprobe_filter_event(tu, event);
-		list_add(&event->hw.tp_list, &tu->filter.perf_events);
+			trace_uprobe_filter_event(filter, event);
+		list_add(&event->hw.tp_list, &filter->perf_events);
 	} else {
-		done = tu->filter.nr_systemwide;
-		tu->filter.nr_systemwide++;
+		done = filter->nr_systemwide;
+		filter->nr_systemwide++;
 	}
-	write_unlock(&tu->filter.rwlock);
+	write_unlock(&filter->rwlock);
 
-	err = 0;
-	if (!done) {
-		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
-		if (err)
-			uprobe_perf_close(tu, event);
-	}
-	return err;
+	return done;
 }
 
-static int uprobe_perf_multi_call(struct trace_event_call *call,
-				  struct perf_event *event,
-		int (*op)(struct trace_uprobe *tu, struct perf_event *event))
+static int uprobe_perf_close(struct trace_event_call *call,
+			     struct perf_event *event)
 {
 	struct trace_probe *pos, *tp;
 	struct trace_uprobe *tu;
@@ -1278,25 +1280,59 @@ static int uprobe_perf_multi_call(struct trace_event_call *call,
 	if (WARN_ON_ONCE(!tp))
 		return -ENODEV;
 
+	tu = container_of(tp, struct trace_uprobe, tp);
+	if (trace_uprobe_filter_remove(trace_uprobe_get_filter(tu), event))
+		return 0;
+
 	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
 		tu = container_of(pos, struct trace_uprobe, tp);
-		ret = op(tu, event);
+		ret = uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
 		if (ret)
 			break;
 	}
 
 	return ret;
 }
+
+static int uprobe_perf_open(struct trace_event_call *call,
+			    struct perf_event *event)
+{
+	struct trace_probe *pos, *tp;
+	struct trace_uprobe *tu;
+	int err = 0;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+
+	tu = container_of(tp, struct trace_uprobe, tp);
+	if (trace_uprobe_filter_add(trace_uprobe_get_filter(tu), event))
+		return 0;
+
+	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
+		if (err) {
+			uprobe_perf_close(call, event);
+			break;
+		}
+	}
+
+	return err;
+}
+
 static bool uprobe_perf_filter(struct uprobe_consumer *uc,
 				enum uprobe_filter_ctx ctx, struct mm_struct *mm)
 {
+	struct trace_uprobe_filter *filter;
 	struct trace_uprobe *tu;
 	int ret;
 
 	tu = container_of(uc, struct trace_uprobe, consumer);
-	read_lock(&tu->filter.rwlock);
-	ret = __uprobe_perf_filter(&tu->filter, mm);
-	read_unlock(&tu->filter.rwlock);
+	filter = trace_uprobe_get_filter(tu);
+
+	read_lock(&filter->rwlock);
+	ret = __uprobe_perf_filter(filter, mm);
+	read_unlock(&filter->rwlock);
 
 	return ret;
 }
@@ -1419,10 +1455,10 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
 		return 0;
 
 	case TRACE_REG_PERF_OPEN:
-		return uprobe_perf_multi_call(event, data, uprobe_perf_open);
+		return uprobe_perf_open(event, data);
 
 	case TRACE_REG_PERF_CLOSE:
-		return uprobe_perf_multi_call(event, data, uprobe_perf_close);
+		return uprobe_perf_close(event, data);
 
 #endif
 	default:
