Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF66C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E33B24658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgANVEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:04:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbgANVDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7FB124694;
        Tue, 14 Jan 2020 21:03:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLe-000D9y-SV; Tue, 14 Jan 2020 16:03:38 -0500
Message-Id: <20200114210338.764148435@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 21/26] tracing/boot: Add synthetic event support
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add synthetic event node support to boot time tracing.
The synthetic event is a kind of event node, but the group
name is "synthetic".

 - ftrace.event.synthetic.EVENT.fields = FIELD[, FIELD2...]
   Defines new synthetic event with FIELDs. Each field should be
   "type varname".

The synthetic node requires "fields" string arraies, which defines
the fields as same as tracing/synth_events interface.

Link: http://lkml.kernel.org/r/157867241236.17873.12411615143321557709.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c        | 47 ++++++++++++++++++++++++++++++++
 kernel/trace/trace_events_hist.c |  5 ++++
 2 files changed, 52 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index a11dc60299fb..3054921b0877 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -118,6 +118,50 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 }
 #endif
 
+#ifdef CONFIG_HIST_TRIGGERS
+extern int synth_event_run_command(const char *command);
+
+static int __init
+trace_boot_add_synth_event(struct xbc_node *node, const char *event)
+{
+	struct xbc_node *anode;
+	char buf[MAX_BUF_LEN], *q;
+	const char *p;
+	int len, delta, ret;
+
+	len = ARRAY_SIZE(buf);
+	delta = snprintf(buf, len, "%s", event);
+	if (delta >= len) {
+		pr_err("Event name is too long: %s\n", event);
+		return -E2BIG;
+	}
+	len -= delta; q = buf + delta;
+
+	xbc_node_for_each_array_value(node, "fields", anode, p) {
+		delta = snprintf(q, len, " %s;", p);
+		if (delta >= len) {
+			pr_err("fields string is too long: %s\n", p);
+			return -E2BIG;
+		}
+		len -= delta; q += delta;
+	}
+
+	ret = synth_event_run_command(buf);
+	if (ret < 0)
+		pr_err("Failed to add synthetic event: %s\n", buf);
+
+
+	return ret;
+}
+#else
+static inline int __init
+trace_boot_add_synth_event(struct xbc_node *node, const char *event)
+{
+	pr_err("Synthetic event is not supported.\n");
+	return -ENOTSUPP;
+}
+#endif
+
 static void __init
 trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			  struct xbc_node *enode)
@@ -133,6 +177,9 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 	if (!strcmp(group, "kprobes"))
 		if (trace_boot_add_kprobe_event(enode, event) < 0)
 			return;
+	if (!strcmp(group, "synthetic"))
+		if (trace_boot_add_synth_event(enode, event) < 0)
+			return;
 
 	mutex_lock(&event_mutex);
 	file = find_event_file(tr, group, event);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1cb4c4c8e5b7..8e90f1ada437 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1384,6 +1384,11 @@ static int create_or_delete_synth_event(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
+int synth_event_run_command(const char *command)
+{
+	return trace_run_command(command, create_or_delete_synth_event);
+}
+
 static int synth_event_create(int argc, const char **argv)
 {
 	const char *name = argv[0];
-- 
2.24.1


