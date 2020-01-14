Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E7C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AD424690
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgANVDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729009AbgANVDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E0124687;
        Tue, 14 Jan 2020 21:03:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLe-000D8w-JW; Tue, 14 Jan 2020 16:03:38 -0500
Message-Id: <20200114210338.473494259@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 19/26] tracing/boot: Add per-event settings
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add per-event settings for boottime tracing. User can set filter,
actions and enable on each event on boot. The event entries are
under ftrace.event.GROUP.EVENT node (note that the option key
includes event's group name and event name.) This supports below
configs.

 - ftrace.event.GROUP.EVENT.enable
   Enables GROUP:EVENT tracing.

 - ftrace.event.GROUP.EVENT.filter = FILTER
   Set FILTER rule to the GROUP:EVENT.

 - ftrace.event.GROUP.EVENT.actions = ACTION[, ACTION2...]
   Set ACTIONs to the GROUP:EVENT.

For example,

  ftrace.event.sched.sched_process_exec {
                filter = "pid < 128"
		enable
  }

this will enable tracing "sched:sched_process_exec" event
with "pid < 128" filter.

Link: http://lkml.kernel.org/r/157867238942.17873.11177628789184546198.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c           | 60 +++++++++++++++++++++++++++++
 kernel/trace/trace_events_trigger.c |  2 +-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 4b41310184df..37524031533e 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -56,6 +56,7 @@ trace_boot_set_ftrace_options(struct trace_array *tr, struct xbc_node *node)
 
 #ifdef CONFIG_EVENT_TRACING
 extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 
 static void __init
 trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
@@ -74,8 +75,66 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 			pr_err("Failed to enable event: %s\n", p);
 	}
 }
+
+static void __init
+trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
+			  struct xbc_node *enode)
+{
+	struct trace_event_file *file;
+	struct xbc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *p, *group, *event;
+
+	group = xbc_node_get_data(gnode);
+	event = xbc_node_get_data(enode);
+
+	mutex_lock(&event_mutex);
+	file = find_event_file(tr, group, event);
+	if (!file) {
+		pr_err("Failed to find event: %s:%s\n", group, event);
+		goto out;
+	}
+
+	p = xbc_node_find_value(enode, "filter", NULL);
+	if (p && *p != '\0') {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+			pr_err("filter string is too long: %s\n", p);
+		else if (apply_event_filter(file, buf) < 0)
+			pr_err("Failed to apply filter: %s\n", buf);
+	}
+
+	xbc_node_for_each_array_value(enode, "actions", anode, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+			pr_err("action string is too long: %s\n", p);
+		else if (trigger_process_regex(file, buf) < 0)
+			pr_err("Failed to apply an action: %s\n", buf);
+	}
+
+	if (xbc_node_find_value(enode, "enable", NULL)) {
+		if (trace_event_enable_disable(file, 1, 0) < 0)
+			pr_err("Failed to enable event node: %s:%s\n",
+				group, event);
+	}
+out:
+	mutex_unlock(&event_mutex);
+}
+
+static void __init
+trace_boot_init_events(struct trace_array *tr, struct xbc_node *node)
+{
+	struct xbc_node *gnode, *enode;
+
+	node = xbc_node_find_child(node, "event");
+	if (!node)
+		return;
+	/* per-event key starts with "event.GROUP.EVENT" */
+	xbc_node_for_each_child(node, gnode)
+		xbc_node_for_each_child(gnode, enode)
+			trace_boot_init_one_event(tr, gnode, enode);
+}
 #else
 #define trace_boot_enable_events(tr, node) do {} while (0)
+#define trace_boot_init_events(tr, node) do {} while (0)
 #endif
 
 static void __init
@@ -104,6 +163,7 @@ static int __init trace_boot_init(void)
 		return 0;
 
 	trace_boot_set_ftrace_options(tr, trace_node);
+	trace_boot_init_events(tr, trace_node);
 	trace_boot_enable_events(tr, trace_node);
 	trace_boot_enable_tracer(tr, trace_node);
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 2cd53ca21b51..d8ada4c6f3f7 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -213,7 +213,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static int trigger_process_regex(struct trace_event_file *file, char *buff)
+int trigger_process_regex(struct trace_event_file *file, char *buff)
 {
 	char *command, *next = buff;
 	struct event_command *p;
-- 
2.24.1


