Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C23BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E74C207FB
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFAM2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbgFAM2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:28:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD307207D5;
        Mon,  1 Jun 2020 12:28:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jfjXz-00276o-Ug; Mon, 01 Jun 2020 08:28:07 -0400
Message-ID: <20200601122807.833466129@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 01 Jun 2020 08:27:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 06/12] tracing: Add hist_debug trace event files for histogram debugging
References: <20200601122729.727113609@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add a new "hist_debug" file for each trace event, which when read will
dump out a bunch of internal details about the hist triggers defined
on that event.

This is normally off but can be enabled by saying 'y' to the new
CONFIG_HIST_TRIGGERS_DEBUG config option.

This is in support of the new Documentation file describing histogram
internals, Documentation/trace/histogram-design.rst, which was
requested by developers trying to understand the internals when
extending or making use of the hist triggers for higher-level tools.

The histogram-design.rst documentation refers to the hist_debug files
and demonstrates their use with output in the test examples.

Link: http://lkml.kernel.org/r/77914c22b0ba493d9783c53bbfbc6087d6a7e1b1.1585941485.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig             |  23 +++
 kernel/trace/trace.h             |   1 +
 kernel/trace/trace_events.c      |   4 +
 kernel/trace/trace_events_hist.c | 273 +++++++++++++++++++++++++++++++
 4 files changed, 301 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 743647005f64..2aec9376825f 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -847,6 +847,29 @@ config KPROBE_EVENT_GEN_TEST
 
 	  If unsure, say N.
 
+config HIST_TRIGGERS_DEBUG
+	bool "Hist trigger debug support"
+	depends on HIST_TRIGGERS
+	help
+          Add "hist_debug" file for each event, which when read will
+          dump out a bunch of internal details about the hist triggers
+          defined on that event.
+
+          The hist_debug file serves a couple of purposes:
+
+            - Helps developers verify that nothing is broken.
+
+            - Provides educational information to support the details
+              of the hist trigger internals as described by
+              Documentation/trace/histogram-design.rst.
+
+          The hist_debug output only covers the data structures
+          related to the histogram definitions themselves and doesn't
+          display the internals of map buckets or variable values of
+          running histograms.
+
+          If unsure, say N.
+
 endif # FTRACE
 
 endif # TRACING_SUPPORT
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4eb1d004d5f2..def769df5bf1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1661,6 +1661,7 @@ extern struct list_head ftrace_events;
 
 extern const struct file_operations event_trigger_fops;
 extern const struct file_operations event_hist_fops;
+extern const struct file_operations event_hist_debug_fops;
 extern const struct file_operations event_inject_fops;
 
 #ifdef CONFIG_HIST_TRIGGERS
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 242f59e7f17d..f6f55682d3e2 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2208,6 +2208,10 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 #ifdef CONFIG_HIST_TRIGGERS
 	trace_create_file("hist", 0444, file->dir, file,
 			  &event_hist_fops);
+#endif
+#ifdef CONFIG_HIST_TRIGGERS_DEBUG
+	trace_create_file("hist_debug", 0444, file->dir, file,
+			  &event_hist_debug_fops);
 #endif
 	trace_create_file("format", 0444, file->dir, call,
 			  &ftrace_event_format_fops);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5cfe8f998b3e..313227da4925 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6478,6 +6478,279 @@ const struct file_operations event_hist_fops = {
 	.release = single_release,
 };
 
+#ifdef CONFIG_HIST_TRIGGERS_DEBUG
+static void hist_field_debug_show_flags(struct seq_file *m,
+					unsigned long flags)
+{
+	seq_puts(m, "      flags:\n");
+
+	if (flags & HIST_FIELD_FL_KEY)
+		seq_puts(m, "        HIST_FIELD_FL_KEY\n");
+	else if (flags & HIST_FIELD_FL_HITCOUNT)
+		seq_puts(m, "        VAL: HIST_FIELD_FL_HITCOUNT\n");
+	else if (flags & HIST_FIELD_FL_VAR)
+		seq_puts(m, "        HIST_FIELD_FL_VAR\n");
+	else if (flags & HIST_FIELD_FL_VAR_REF)
+		seq_puts(m, "        HIST_FIELD_FL_VAR_REF\n");
+	else
+		seq_puts(m, "        VAL: normal u64 value\n");
+
+	if (flags & HIST_FIELD_FL_ALIAS)
+		seq_puts(m, "        HIST_FIELD_FL_ALIAS\n");
+}
+
+static int hist_field_debug_show(struct seq_file *m,
+				 struct hist_field *field, unsigned long flags)
+{
+	if ((field->flags & flags) != flags) {
+		seq_printf(m, "ERROR: bad flags - %lx\n", flags);
+		return -EINVAL;
+	}
+
+	hist_field_debug_show_flags(m, field->flags);
+	if (field->field)
+		seq_printf(m, "      ftrace_event_field name: %s\n",
+			   field->field->name);
+
+	if (field->flags & HIST_FIELD_FL_VAR) {
+		seq_printf(m, "      var.name: %s\n", field->var.name);
+		seq_printf(m, "      var.idx (into tracing_map_elt.vars[]): %u\n",
+			   field->var.idx);
+	}
+
+	if (field->flags & HIST_FIELD_FL_ALIAS)
+		seq_printf(m, "      var_ref_idx (into hist_data->var_refs[]): %u\n",
+			   field->var_ref_idx);
+
+	if (field->flags & HIST_FIELD_FL_VAR_REF) {
+		seq_printf(m, "      name: %s\n", field->name);
+		seq_printf(m, "      var.idx (into tracing_map_elt.vars[]): %u\n",
+			   field->var.idx);
+		seq_printf(m, "      var.hist_data: %p\n", field->var.hist_data);
+		seq_printf(m, "      var_ref_idx (into hist_data->var_refs[]): %u\n",
+			   field->var_ref_idx);
+		if (field->system)
+			seq_printf(m, "      system: %s\n", field->system);
+		if (field->event_name)
+			seq_printf(m, "      event_name: %s\n", field->event_name);
+	}
+
+	seq_printf(m, "      type: %s\n", field->type);
+	seq_printf(m, "      size: %u\n", field->size);
+	seq_printf(m, "      is_signed: %u\n", field->is_signed);
+
+	return 0;
+}
+
+static int field_var_debug_show(struct seq_file *m,
+				struct field_var *field_var, unsigned int i,
+				bool save_vars)
+{
+	const char *vars_name = save_vars ? "save_vars" : "field_vars";
+	struct hist_field *field;
+	int ret = 0;
+
+	seq_printf(m, "\n    hist_data->%s[%d]:\n", vars_name, i);
+
+	field = field_var->var;
+
+	seq_printf(m, "\n      %s[%d].var:\n", vars_name, i);
+
+	hist_field_debug_show_flags(m, field->flags);
+	seq_printf(m, "      var.name: %s\n", field->var.name);
+	seq_printf(m, "      var.idx (into tracing_map_elt.vars[]): %u\n",
+		   field->var.idx);
+
+	field = field_var->val;
+
+	seq_printf(m, "\n      %s[%d].val:\n", vars_name, i);
+	if (field->field)
+		seq_printf(m, "      ftrace_event_field name: %s\n",
+			   field->field->name);
+	else {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	seq_printf(m, "      type: %s\n", field->type);
+	seq_printf(m, "      size: %u\n", field->size);
+	seq_printf(m, "      is_signed: %u\n", field->is_signed);
+out:
+	return ret;
+}
+
+static int hist_action_debug_show(struct seq_file *m,
+				  struct action_data *data, int i)
+{
+	int ret = 0;
+
+	if (data->handler == HANDLER_ONMAX ||
+	    data->handler == HANDLER_ONCHANGE) {
+		seq_printf(m, "\n    hist_data->actions[%d].track_data.var_ref:\n", i);
+		ret = hist_field_debug_show(m, data->track_data.var_ref,
+					    HIST_FIELD_FL_VAR_REF);
+		if (ret)
+			goto out;
+
+		seq_printf(m, "\n    hist_data->actions[%d].track_data.track_var:\n", i);
+		ret = hist_field_debug_show(m, data->track_data.track_var,
+					    HIST_FIELD_FL_VAR);
+		if (ret)
+			goto out;
+	}
+
+	if (data->handler == HANDLER_ONMATCH) {
+		seq_printf(m, "\n    hist_data->actions[%d].match_data.event_system: %s\n",
+			   i, data->match_data.event_system);
+		seq_printf(m, "    hist_data->actions[%d].match_data.event: %s\n",
+			   i, data->match_data.event);
+	}
+out:
+	return ret;
+}
+
+static int hist_actions_debug_show(struct seq_file *m,
+				   struct hist_trigger_data *hist_data)
+{
+	int i, ret = 0;
+
+	if (hist_data->n_actions)
+		seq_puts(m, "\n  action tracking variables (for onmax()/onchange()/onmatch()):\n");
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *action = hist_data->actions[i];
+
+		ret = hist_action_debug_show(m, action, i);
+		if (ret)
+			goto out;
+	}
+
+	if (hist_data->n_save_vars)
+		seq_puts(m, "\n  save action variables (save() params):\n");
+
+	for (i = 0; i < hist_data->n_save_vars; i++) {
+		ret = field_var_debug_show(m, hist_data->save_vars[i], i, true);
+		if (ret)
+			goto out;
+	}
+out:
+	return ret;
+}
+
+static void hist_trigger_debug_show(struct seq_file *m,
+				    struct event_trigger_data *data, int n)
+{
+	struct hist_trigger_data *hist_data;
+	int i, ret;
+
+	if (n > 0)
+		seq_puts(m, "\n\n");
+
+	seq_puts(m, "# event histogram\n#\n# trigger info: ");
+	data->ops->print(m, data->ops, data);
+	seq_puts(m, "#\n\n");
+
+	hist_data = data->private_data;
+
+	seq_printf(m, "hist_data: %p\n\n", hist_data);
+	seq_printf(m, "  n_vals: %u\n", hist_data->n_vals);
+	seq_printf(m, "  n_keys: %u\n", hist_data->n_keys);
+	seq_printf(m, "  n_fields: %u\n", hist_data->n_fields);
+
+	seq_puts(m, "\n  val fields:\n\n");
+
+	seq_puts(m, "    hist_data->fields[0]:\n");
+	ret = hist_field_debug_show(m, hist_data->fields[0],
+				    HIST_FIELD_FL_HITCOUNT);
+	if (ret)
+		return;
+
+	for (i = 1; i < hist_data->n_vals; i++) {
+		seq_printf(m, "\n    hist_data->fields[%d]:\n", i);
+		ret = hist_field_debug_show(m, hist_data->fields[i], 0);
+		if (ret)
+			return;
+	}
+
+	seq_puts(m, "\n  key fields:\n");
+
+	for (i = hist_data->n_vals; i < hist_data->n_fields; i++) {
+		seq_printf(m, "\n    hist_data->fields[%d]:\n", i);
+		ret = hist_field_debug_show(m, hist_data->fields[i],
+					    HIST_FIELD_FL_KEY);
+		if (ret)
+			return;
+	}
+
+	if (hist_data->n_var_refs)
+		seq_puts(m, "\n  variable reference fields:\n");
+
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		seq_printf(m, "\n    hist_data->var_refs[%d]:\n", i);
+		ret = hist_field_debug_show(m, hist_data->var_refs[i],
+					    HIST_FIELD_FL_VAR_REF);
+		if (ret)
+			return;
+	}
+
+	if (hist_data->n_field_vars)
+		seq_puts(m, "\n  field variables:\n");
+
+	for (i = 0; i < hist_data->n_field_vars; i++) {
+		ret = field_var_debug_show(m, hist_data->field_vars[i], i, false);
+		if (ret)
+			return;
+	}
+
+	ret = hist_actions_debug_show(m, hist_data);
+	if (ret)
+		return;
+}
+
+static int hist_debug_show(struct seq_file *m, void *v)
+{
+	struct event_trigger_data *data;
+	struct trace_event_file *event_file;
+	int n = 0, ret = 0;
+
+	mutex_lock(&event_mutex);
+
+	event_file = event_file_data(m->private);
+	if (unlikely(!event_file)) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	list_for_each_entry(data, &event_file->triggers, list) {
+		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
+			hist_trigger_debug_show(m, data, n++);
+	}
+
+ out_unlock:
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int event_hist_debug_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	return single_open(file, hist_debug_show, file);
+}
+
+const struct file_operations event_hist_debug_fops = {
+	.open = event_hist_debug_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+#endif
+
 static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 {
 	const char *field_name = hist_field_name(hist_field, 0);
-- 
2.26.2


