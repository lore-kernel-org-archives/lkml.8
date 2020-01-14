Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09674C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86B824690
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgANVDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbgANVDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C74C42469B;
        Tue, 14 Jan 2020 21:03:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLe-000D9S-Nv; Tue, 14 Jan 2020 16:03:38 -0500
Message-Id: <20200114210338.632619739@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 20/26] tracing/boot Add kprobe event support
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add kprobe event support on event node to boot-time tracing.
If the group name of event is "kprobes", the boot-time tracing
defines new probe event according to "probes" values.

 - ftrace.event.kprobes.EVENT.probes = PROBE[, PROBE2...]
   Defines new kprobe event based on PROBEs. It is able to define
   multiple probes on one event, but those must have same type of
   arguments.

For example,

 ftrace.events.kprobes.myevent {
	probes = "vfs_read $arg1 $arg2";
	enable;
 }

This will add kprobes:myevent on vfs_read with the 1st and the 2nd
arguments.

Link: http://lkml.kernel.org/r/157867240104.17873.9712052065426433111.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c   | 46 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_kprobe.c |  5 ++++
 2 files changed, 51 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 37524031533e..a11dc60299fb 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -76,6 +76,48 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 	}
 }
 
+#ifdef CONFIG_KPROBE_EVENTS
+extern int trace_kprobe_run_command(const char *command);
+
+static int __init
+trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
+{
+	struct xbc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *val;
+	char *p;
+	int len;
+
+	len = snprintf(buf, ARRAY_SIZE(buf) - 1, "p:kprobes/%s ", event);
+	if (len >= ARRAY_SIZE(buf)) {
+		pr_err("Event name is too long: %s\n", event);
+		return -E2BIG;
+	}
+	p = buf + len;
+	len = ARRAY_SIZE(buf) - len;
+
+	xbc_node_for_each_array_value(node, "probes", anode, val) {
+		if (strlcpy(p, val, len) >= len) {
+			pr_err("Probe definition is too long: %s\n", val);
+			return -E2BIG;
+		}
+		if (trace_kprobe_run_command(buf) < 0) {
+			pr_err("Failed to add probe: %s\n", buf);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+#else
+static inline int __init
+trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
+{
+	pr_err("Kprobe event is not supported.\n");
+	return -ENOTSUPP;
+}
+#endif
+
 static void __init
 trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			  struct xbc_node *enode)
@@ -88,6 +130,10 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 	group = xbc_node_get_data(gnode);
 	event = xbc_node_get_data(enode);
 
+	if (!strcmp(group, "kprobes"))
+		if (trace_boot_add_kprobe_event(enode, event) < 0)
+			return;
+
 	mutex_lock(&event_mutex);
 	file = find_event_file(tr, group, event);
 	if (!file) {
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 8113d6aa7bc5..283b7c437440 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -902,6 +902,11 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
+int trace_kprobe_run_command(const char *command)
+{
+	return trace_run_command(command, create_or_delete_trace_kprobe);
+}
+
 static int trace_kprobe_release(struct dyn_event *ev)
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
-- 
2.24.1


