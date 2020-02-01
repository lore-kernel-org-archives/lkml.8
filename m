Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A5EC35246
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EDB2073D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgBASMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:12:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgBASMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:12:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19D520728;
        Sat,  1 Feb 2020 18:12:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixxFw-001Il7-Tv; Sat, 01 Feb 2020 13:12:32 -0500
Message-Id: <20200201181232.804196729@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 01 Feb 2020 13:12:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 1/6] tracing: Change trace_boot to use synth_event interface
References: <20200201181210.203806308@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Have trace_boot_add_synth_event() use the synth_event interface.

Also, rename synth_event_run_cmd() to synth_event_run_command() now
that trace_boot's version is gone.

Link: http://lkml.kernel.org/r/94f1fa0e31846d0bddca916b8663404b20559e34.1580323897.git.zanussi@kernel.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c        | 31 ++++++++++++-------------------
 kernel/trace/trace_events_hist.c |  9 ++-------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 2298a70cdda6..06d7feb5255f 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -125,38 +125,31 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 #endif
 
 #ifdef CONFIG_HIST_TRIGGERS
-extern int synth_event_run_command(const char *command);
-
 static int __init
 trace_boot_add_synth_event(struct xbc_node *node, const char *event)
 {
+	struct dynevent_cmd cmd;
 	struct xbc_node *anode;
-	char buf[MAX_BUF_LEN], *q;
+	char buf[MAX_BUF_LEN];
 	const char *p;
-	int len, delta, ret;
+	int ret;
 
-	len = ARRAY_SIZE(buf);
-	delta = snprintf(buf, len, "%s", event);
-	if (delta >= len) {
-		pr_err("Event name is too long: %s\n", event);
-		return -E2BIG;
-	}
-	len -= delta; q = buf + delta;
+	synth_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
+
+	ret = synth_event_gen_cmd_start(&cmd, event, NULL);
+	if (ret)
+		return ret;
 
 	xbc_node_for_each_array_value(node, "fields", anode, p) {
-		delta = snprintf(q, len, " %s;", p);
-		if (delta >= len) {
-			pr_err("fields string is too long: %s\n", p);
-			return -E2BIG;
-		}
-		len -= delta; q += delta;
+		ret = synth_event_add_field_str(&cmd, p);
+		if (ret)
+			return ret;
 	}
 
-	ret = synth_event_run_command(buf);
+	ret = synth_event_gen_cmd_end(&cmd);
 	if (ret < 0)
 		pr_err("Failed to add synthetic event: %s\n", buf);
 
-
 	return ret;
 }
 #else
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4d56a4f0310d..2e88c9805f4b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1755,12 +1755,7 @@ static int create_or_delete_synth_event(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-int synth_event_run_command(const char *command)
-{
-	return trace_run_command(command, create_or_delete_synth_event);
-}
-
-static int synth_event_run_cmd(struct dynevent_cmd *cmd)
+static int synth_event_run_command(struct dynevent_cmd *cmd)
 {
 	struct synth_event *se;
 	int ret;
@@ -1790,7 +1785,7 @@ static int synth_event_run_cmd(struct dynevent_cmd *cmd)
 void synth_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
 {
 	dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_SYNTH,
-			  synth_event_run_cmd);
+			  synth_event_run_command);
 }
 EXPORT_SYMBOL_GPL(synth_event_cmd_init);
 
-- 
2.24.1


