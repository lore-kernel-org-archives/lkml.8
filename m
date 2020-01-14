Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7DEC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245142468F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgANVDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgANVDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD3724698;
        Tue, 14 Jan 2020 21:03:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLf-000DBW-A9; Tue, 14 Jan 2020 16:03:39 -0500
Message-Id: <20200114210339.194772148@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 24/26] tracing/boot: Add function tracer filter options
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add below function-tracer filter options to boot-time tracing.

 - ftrace.[instance.INSTANCE.]ftrace.filters
   This will take an array of tracing function filter rules

 - ftrace.[instance.INSTANCE.]ftrace.notraces
   This will take an array of NON-tracing function filter rules

Link: http://lkml.kernel.org/r/157867244841.17873.10933616628243103561.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 81d923c16a4d..fa9603dc6469 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -244,11 +244,51 @@ trace_boot_init_events(struct trace_array *tr, struct xbc_node *node)
 #define trace_boot_init_events(tr, node) do {} while (0)
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+extern bool ftrace_filter_param __initdata;
+extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
+			     int len, int reset);
+extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
+			      int len, int reset);
+static void __init
+trace_boot_set_ftrace_filter(struct trace_array *tr, struct xbc_node *node)
+{
+	struct xbc_node *anode;
+	const char *p;
+	char *q;
+
+	xbc_node_for_each_array_value(node, "ftrace.filters", anode, p) {
+		q = kstrdup(p, GFP_KERNEL);
+		if (!q)
+			return;
+		if (ftrace_set_filter(tr->ops, q, strlen(q), 0) < 0)
+			pr_err("Failed to add %s to ftrace filter\n", p);
+		else
+			ftrace_filter_param = true;
+		kfree(q);
+	}
+	xbc_node_for_each_array_value(node, "ftrace.notraces", anode, p) {
+		q = kstrdup(p, GFP_KERNEL);
+		if (!q)
+			return;
+		if (ftrace_set_notrace(tr->ops, q, strlen(q), 0) < 0)
+			pr_err("Failed to add %s to ftrace filter\n", p);
+		else
+			ftrace_filter_param = true;
+		kfree(q);
+	}
+}
+#else
+#define trace_boot_set_ftrace_filter(tr, node) do {} while (0)
+#endif
+
 static void __init
 trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
 {
 	const char *p;
 
+	trace_boot_set_ftrace_filter(tr, node);
+
 	p = xbc_node_find_value(node, "tracer", NULL);
 	if (p && *p != '\0') {
 		if (tracing_set_tracer(tr, p) < 0)
-- 
2.24.1


