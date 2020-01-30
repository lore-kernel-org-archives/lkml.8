Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4A0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503C9206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgA3Os4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbgA3OsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E4262464B;
        Thu, 30 Jan 2020 14:48:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB76-001CQU-EB; Thu, 30 Jan 2020 09:48:12 -0500
Message-Id: <20200130144812.318486781@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:47:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 14/21] tracing: Add kprobe event command generation functions
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add functions used to generate kprobe event commands, built on top of
the dynevent_cmd interface.

kprobe_event_gen_cmd_start() is used to create a kprobe event command
using a variable arg list, and kretprobe_event_gen_cmd_start() does
the same for kretprobe event commands.  kprobe_event_add_fields() can
be used to add single fields one by one or as a group.  Once all
desired fields are added, kprobe_event_gen_cmd_end() or
kretprobe_event_gen_cmd_end() respectively are used to actually
execute the command and create the event.

Link: http://lkml.kernel.org/r/95cc4696502bb6017f9126f306a45ad19b4cc14f.1580323897.git.zanussi@kernel.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h |  31 +++++++
 kernel/trace/trace_kprobe.c  | 161 +++++++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index bf03d12efb28..7c307a7c9c6a 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -358,6 +358,7 @@ extern void trace_put_event_file(struct trace_event_file *file);
 
 enum dynevent_type {
 	DYNEVENT_TYPE_SYNTH = 1,
+	DYNEVENT_TYPE_KPROBE,
 	DYNEVENT_TYPE_NONE,
 };
 
@@ -442,6 +443,36 @@ extern int synth_event_add_val(const char *field_name, u64 val,
 			       struct synth_event_trace_state *trace_state);
 extern int synth_event_trace_end(struct synth_event_trace_state *trace_state);
 
+extern int kprobe_event_delete(const char *name);
+
+extern void kprobe_event_cmd_init(struct dynevent_cmd *cmd,
+				  char *buf, int maxlen);
+
+#define kprobe_event_gen_cmd_start(cmd, name, loc, ...)			\
+	__kprobe_event_gen_cmd_start(cmd, false, name, loc, ## __VA_ARGS__, NULL)
+
+#define kretprobe_event_gen_cmd_start(cmd, name, loc, ...)		\
+	__kprobe_event_gen_cmd_start(cmd, true, name, loc, ## __VA_ARGS__, NULL)
+
+extern int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd,
+					bool kretprobe,
+					const char *name,
+					const char *loc, ...);
+
+#define kprobe_event_add_fields(cmd, ...)	\
+	__kprobe_event_add_fields(cmd, ## __VA_ARGS__, NULL)
+
+#define kprobe_event_add_field(cmd, field)	\
+	__kprobe_event_add_fields(cmd, field, NULL)
+
+extern int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...);
+
+#define kprobe_event_gen_cmd_end(cmd)		\
+	dynevent_create(cmd)
+
+#define kretprobe_event_gen_cmd_end(cmd)	\
+	dynevent_create(cmd)
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index bf20cd7f2666..f43548b466d0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -906,6 +906,167 @@ int trace_kprobe_run_command(const char *command)
 	return trace_run_command(command, create_or_delete_trace_kprobe);
 }
 
+static int trace_kprobe_run_cmd(struct dynevent_cmd *cmd)
+{
+	return trace_run_command(cmd->buf, create_or_delete_trace_kprobe);
+}
+
+/**
+ * kprobe_event_cmd_init - Initialize a kprobe event command object
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @buf: A pointer to the buffer used to build the command
+ * @maxlen: The length of the buffer passed in @buf
+ *
+ * Initialize a synthetic event command object.  Use this before
+ * calling any of the other kprobe_event functions.
+ */
+void kprobe_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
+{
+	dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_KPROBE,
+			  trace_kprobe_run_cmd);
+}
+EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
+
+/**
+ * __kprobe_event_gen_cmd_start - Generate a kprobe event command from arg list
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @name: The name of the kprobe event
+ * @loc: The location of the kprobe event
+ * @kretprobe: Is this a return probe?
+ * @args: Variable number of arg (pairs), one pair for each field
+ *
+ * NOTE: Users normally won't want to call this function directly, but
+ * rather use the kprobe_event_gen_cmd_start() wrapper, which automatically
+ * adds a NULL to the end of the arg list.  If this function is used
+ * directly, make sure the last arg in the variable arg list is NULL.
+ *
+ * Generate a kprobe event command to be executed by
+ * kprobe_event_gen_cmd_end().  This function can be used to generate the
+ * complete command or only the first part of it; in the latter case,
+ * kprobe_event_add_fields() can be used to add more fields following this.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
+				 const char *name, const char *loc, ...)
+{
+	char buf[MAX_EVENT_NAME_LEN];
+	struct dynevent_arg arg;
+	va_list args;
+	int ret;
+
+	if (cmd->type != DYNEVENT_TYPE_KPROBE)
+		return -EINVAL;
+
+	if (kretprobe)
+		snprintf(buf, MAX_EVENT_NAME_LEN, "r:kprobes/%s", name);
+	else
+		snprintf(buf, MAX_EVENT_NAME_LEN, "p:kprobes/%s", name);
+
+	ret = dynevent_str_add(cmd, buf);
+	if (ret)
+		return ret;
+
+	dynevent_arg_init(&arg, NULL, 0);
+	arg.str = loc;
+	ret = dynevent_arg_add(cmd, &arg);
+	if (ret)
+		return ret;
+
+	va_start(args, loc);
+	for (;;) {
+		const char *field;
+
+		field = va_arg(args, const char *);
+		if (!field)
+			break;
+
+		if (++cmd->n_fields > MAX_TRACE_ARGS) {
+			ret = -EINVAL;
+			break;
+		}
+
+		arg.str = field;
+		ret = dynevent_arg_add(cmd, &arg);
+		if (ret)
+			break;
+	}
+	va_end(args);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__kprobe_event_gen_cmd_start);
+
+/**
+ * __kprobe_event_add_fields - Add probe fields to a kprobe command from arg list
+ * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @args: Variable number of arg (pairs), one pair for each field
+ *
+ * NOTE: Users normally won't want to call this function directly, but
+ * rather use the kprobe_event_add_fields() wrapper, which
+ * automatically adds a NULL to the end of the arg list.  If this
+ * function is used directly, make sure the last arg in the variable
+ * arg list is NULL.
+ *
+ * Add probe fields to an existing kprobe command using a variable
+ * list of args.  Fields are added in the same order they're listed.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...)
+{
+	struct dynevent_arg arg;
+	va_list args;
+	int ret;
+
+	if (cmd->type != DYNEVENT_TYPE_KPROBE)
+		return -EINVAL;
+
+	dynevent_arg_init(&arg, NULL, 0);
+
+	va_start(args, cmd);
+	for (;;) {
+		const char *field;
+
+		field = va_arg(args, const char *);
+		if (!field)
+			break;
+
+		if (++cmd->n_fields > MAX_TRACE_ARGS) {
+			ret = -EINVAL;
+			break;
+		}
+
+		arg.str = field;
+		ret = dynevent_arg_add(cmd, &arg);
+		if (ret)
+			break;
+	}
+	va_end(args);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__kprobe_event_add_fields);
+
+/**
+ * kprobe_event_delete - Delete a kprobe event
+ * @name: The name of the kprobe event to delete
+ *
+ * Delete a kprobe event with the give @name from kernel code rather
+ * than directly from the command line.
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int kprobe_event_delete(const char *name)
+{
+	char buf[MAX_EVENT_NAME_LEN];
+
+	snprintf(buf, MAX_EVENT_NAME_LEN, "-:%s", name);
+
+	return trace_run_command(buf, create_or_delete_trace_kprobe);
+}
+EXPORT_SYMBOL_GPL(kprobe_event_delete);
+
 static int trace_kprobe_release(struct dyn_event *ev)
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
-- 
2.24.1


