Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3200BC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C152073B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgBASMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:12:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgBASMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:12:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADADC2070C;
        Sat,  1 Feb 2020 18:12:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixxFx-001InZ-Ln; Sat, 01 Feb 2020 13:12:33 -0500
Message-Id: <20200201181233.551764232@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 01 Feb 2020 13:12:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 6/6] tracing: Use seq_buf for building dynevent_cmd string
References: <20200201181210.203806308@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

The dynevent_cmd commands that build up the command string don't need
to do that themselves - there's a seq_buf facility that does pretty
much the same thing those command are doing manually, so use it
instead.

Link: http://lkml.kernel.org/r/eb8a6e835c964d0ab8a38cbf5ffa60746b54a465.1580506712.git.zanussi@kernel.org

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h     |  4 +--
 kernel/trace/trace_dynevent.c    | 48 +++++++++-----------------------
 kernel/trace/trace_events_hist.c |  2 +-
 kernel/trace/trace_kprobe.c      |  2 +-
 4 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 7c307a7c9c6a..67f528ecb9e5 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -367,10 +367,8 @@ struct dynevent_cmd;
 typedef int (*dynevent_create_fn_t)(struct dynevent_cmd *cmd);
 
 struct dynevent_cmd {
-	char			*buf;
+	struct seq_buf		seq;
 	const char		*event_name;
-	int			maxlen;
-	int			remaining;
 	unsigned int		n_fields;
 	enum dynevent_type	type;
 	dynevent_create_fn_t	run_command;
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 204275ec8d71..9f2e8520b748 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -247,8 +247,6 @@ int dynevent_arg_add(struct dynevent_cmd *cmd,
 		     dynevent_check_arg_fn_t check_arg)
 {
 	int ret = 0;
-	int delta;
-	char *q;
 
 	if (check_arg) {
 		ret = check_arg(arg);
@@ -256,14 +254,11 @@ int dynevent_arg_add(struct dynevent_cmd *cmd,
 			return ret;
 	}
 
-	q = cmd->buf + (cmd->maxlen - cmd->remaining);
-
-	delta = snprintf(q, cmd->remaining, " %s%c", arg->str, arg->separator);
-	if (delta >= cmd->remaining) {
-		pr_err("String is too long: %s\n", arg->str);
+	ret = seq_buf_printf(&cmd->seq, " %s%c", arg->str, arg->separator);
+	if (ret) {
+		pr_err("String is too long: %s%c\n", arg->str, arg->separator);
 		return -E2BIG;
 	}
-	cmd->remaining -= delta;
 
 	return ret;
 }
@@ -297,8 +292,6 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
 			  dynevent_check_arg_fn_t check_arg)
 {
 	int ret = 0;
-	int delta;
-	char *q;
 
 	if (check_arg) {
 		ret = check_arg(arg_pair);
@@ -306,23 +299,15 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
 			return ret;
 	}
 
-	q = cmd->buf + (cmd->maxlen - cmd->remaining);
-
-	delta = snprintf(q, cmd->remaining, " %s%c", arg_pair->lhs,
-			 arg_pair->operator);
-	if (delta >= cmd->remaining) {
-		pr_err("field string is too long: %s\n", arg_pair->lhs);
-		return -E2BIG;
-	}
-	cmd->remaining -= delta; q += delta;
-
-	delta = snprintf(q, cmd->remaining, "%s%c", arg_pair->rhs,
-			 arg_pair->separator);
-	if (delta >= cmd->remaining) {
-		pr_err("field string is too long: %s\n", arg_pair->rhs);
+	ret = seq_buf_printf(&cmd->seq, " %s%c%s%c", arg_pair->lhs,
+			     arg_pair->operator, arg_pair->rhs,
+			     arg_pair->separator);
+	if (ret) {
+		pr_err("field string is too long: %s%c%s%c\n", arg_pair->lhs,
+		       arg_pair->operator, arg_pair->rhs,
+		       arg_pair->separator);
 		return -E2BIG;
 	}
-	cmd->remaining -= delta;
 
 	return ret;
 }
@@ -340,17 +325,12 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
 int dynevent_str_add(struct dynevent_cmd *cmd, const char *str)
 {
 	int ret = 0;
-	int delta;
-	char *q;
-
-	q = cmd->buf + (cmd->maxlen - cmd->remaining);
 
-	delta = snprintf(q, cmd->remaining, "%s", str);
-	if (delta >= cmd->remaining) {
+	ret = seq_buf_puts(&cmd->seq, str);
+	if (ret) {
 		pr_err("String is too long: %s\n", str);
 		return -E2BIG;
 	}
-	cmd->remaining -= delta;
 
 	return ret;
 }
@@ -381,9 +361,7 @@ void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen,
 {
 	memset(cmd, '\0', sizeof(*cmd));
 
-	cmd->buf = buf;
-	cmd->maxlen = maxlen;
-	cmd->remaining = cmd->maxlen;
+	seq_buf_init(&cmd->seq, buf, maxlen);
 	cmd->type = type;
 	cmd->run_command = run_command;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d2817fe52f32..b3bcfd8c7332 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1762,7 +1762,7 @@ static int synth_event_run_command(struct dynevent_cmd *cmd)
 	struct synth_event *se;
 	int ret;
 
-	ret = trace_run_command(cmd->buf, create_or_delete_synth_event);
+	ret = trace_run_command(cmd->seq.buffer, create_or_delete_synth_event);
 	if (ret)
 		return ret;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index fe183d4045d2..51efc790aea8 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -903,7 +903,7 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
 
 static int trace_kprobe_run_command(struct dynevent_cmd *cmd)
 {
-	return trace_run_command(cmd->buf, create_or_delete_trace_kprobe);
+	return trace_run_command(cmd->seq.buffer, create_or_delete_trace_kprobe);
 }
 
 /**
-- 
2.24.1


