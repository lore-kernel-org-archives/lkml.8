Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09E2206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgA3OsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:48:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbgA3OsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A382124695;
        Thu, 30 Jan 2020 14:48:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB76-001CQy-JA; Thu, 30 Jan 2020 09:48:12 -0500
Message-Id: <20200130144812.469324081@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:47:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 15/21] tracing: Change trace_boot to use kprobe_event interface
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Have trace_boot_add_kprobe_event() use the kprobe_event interface.

Also, rename kprobe_event_run_cmd() to kprobe_event_run_command() now
that trace_boot's version is gone.

Link: http://lkml.kernel.org/r/af5429d11291ab1e9a85a0ff944af3b2bcf193c7.1580323897.git.zanussi@kernel.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c   | 35 +++++++++++++++--------------------
 kernel/trace/trace_kprobe.c |  9 ++-------
 2 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 4d37bf5c3742..2298a70cdda6 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -88,37 +88,32 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 }
 
 #ifdef CONFIG_KPROBE_EVENTS
-extern int trace_kprobe_run_command(const char *command);
-
 static int __init
 trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 {
+	struct dynevent_cmd cmd;
 	struct xbc_node *anode;
 	char buf[MAX_BUF_LEN];
 	const char *val;
-	char *p;
-	int len;
+	int ret;
 
-	len = snprintf(buf, ARRAY_SIZE(buf) - 1, "p:kprobes/%s ", event);
-	if (len >= ARRAY_SIZE(buf)) {
-		pr_err("Event name is too long: %s\n", event);
-		return -E2BIG;
-	}
-	p = buf + len;
-	len = ARRAY_SIZE(buf) - len;
+	kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
+
+	ret = kprobe_event_gen_cmd_start(&cmd, event, NULL);
+	if (ret)
+		return ret;
 
 	xbc_node_for_each_array_value(node, "probes", anode, val) {
-		if (strlcpy(p, val, len) >= len) {
-			pr_err("Probe definition is too long: %s\n", val);
-			return -E2BIG;
-		}
-		if (trace_kprobe_run_command(buf) < 0) {
-			pr_err("Failed to add probe: %s\n", buf);
-			return -EINVAL;
-		}
+		ret = kprobe_event_add_field(&cmd, val);
+		if (ret)
+			return ret;
 	}
 
-	return 0;
+	ret = kprobe_event_gen_cmd_end(&cmd);
+	if (ret)
+		pr_err("Failed to add probe: %s\n", buf);
+
+	return ret;
 }
 #else
 static inline int __init
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index f43548b466d0..307abb724a71 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -901,12 +901,7 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-int trace_kprobe_run_command(const char *command)
-{
-	return trace_run_command(command, create_or_delete_trace_kprobe);
-}
-
-static int trace_kprobe_run_cmd(struct dynevent_cmd *cmd)
+static int trace_kprobe_run_command(struct dynevent_cmd *cmd)
 {
 	return trace_run_command(cmd->buf, create_or_delete_trace_kprobe);
 }
@@ -923,7 +918,7 @@ static int trace_kprobe_run_cmd(struct dynevent_cmd *cmd)
 void kprobe_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
 {
 	dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_KPROBE,
-			  trace_kprobe_run_cmd);
+			  trace_kprobe_run_command);
 }
 EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
 
-- 
2.24.1


