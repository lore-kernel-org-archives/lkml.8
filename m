Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF3EC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71DF2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kTWtt6LF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sX3sw7eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgIDIXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbgIDIXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:23:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6340BC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 01:23:35 -0700 (PDT)
Date:   Fri, 4 Sep 2020 10:23:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599207812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mMDo4/nZGcm4PVutxJ2woYLUnE6VLxTPtQbJgJYovjc=;
        b=kTWtt6LF2SvMRcD1MqbqXeNFKi5ahCulSRGbI/gN1Yazn9LCxmshrQdrwgIZDuCoyU0fG0
        mGKGhmjnh5+eJQzV3IBMfD9ixr3IKH9TJiKJNDmYISf6JZXjg1XQc8hrgTy4lcOoSY7UhM
        U34/mtQeYi8rHPXi03uTlH4M6pBDNz3QRSlg1MIG0BM+jMJ1aP7LK44LKU3JKKNV1nDtko
        TA+yS8y7MV18PUUMj8nPb12eYR8AzaEHYaVNQcssS+0+Ppg+CCBVuXR1jqkD3+lwWQx0Vf
        sEes2XtT87cHBCkAap4zCCEaO0OhqNJZQdxku9ubNO4cUNsqCdqdHDx0Ovb11w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599207812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mMDo4/nZGcm4PVutxJ2woYLUnE6VLxTPtQbJgJYovjc=;
        b=sX3sw7eg0OezKvqHtION2PG3jnx6SY9636zOPq+N5pR9PHtjooUtL+Op4LvwyeIbX9BONU
        SbtnT46zaiZD4GDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] tracing: Make the space reserved for the pid wider
Message-ID: <20200904082331.dcdkrr3bkn3e4qlg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 64bit CONFIG_BASE_SMALL=0 systems PID_MAX_LIMIT is set by default to
4194304. During boot the kernel sets a new value based on number of CPUs
but no lower than 32768. It is 1024 per CPU so with 128 CPUs the default
becomes 131072 which needs six digits. 
This value can be increased during run time but must not exceed the
initial upper limit.

Systemd sometime after v241 sets it to the upper limit during boot. The
result is that when the pid exceeds five digits, the trace output is a
little hard to read because it is no longer properly padded (same like
on big iron with 98+ CPUs).

Increase the pid padding to seven digits.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/trace/trace.c        | 38 ++++++++++++++++++-------------------
 kernel/trace/trace_output.c | 12 ++++++------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f40d850ebabcc..2a7c26345e835 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3782,14 +3782,14 @@ unsigned long trace_total_entries(struct trace_array *tr)
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                  _------=> CPU#            \n"
-		    "#                 / _-----=> irqs-off        \n"
-		    "#                | / _----=> need-resched    \n"
-		    "#                || / _---=> hardirq/softirq \n"
-		    "#                ||| / _--=> preempt-depth   \n"
-		    "#                |||| /     delay            \n"
-		    "#  cmd     pid   ||||| time  |   caller      \n"
-		    "#     \\   /      |||||  \\    |   /         \n");
+	seq_puts(m, "#                    _------=> CPU#            \n"
+		    "#                   / _-----=> irqs-off        \n"
+		    "#                  | / _----=> need-resched    \n"
+		    "#                  || / _---=> hardirq/softirq \n"
+		    "#                  ||| / _--=> preempt-depth   \n"
+		    "#                  |||| /     delay            \n"
+		    "#  cmd     pid     ||||| time  |   caller      \n"
+		    "#     \\   /        |||||  \\    |   /         \n");
 }
 
 static void print_event_info(struct array_buffer *buf, struct seq_file *m)
@@ -3810,26 +3810,26 @@ static void print_func_help_header(struct array_buffer *buf, struct seq_file *m,
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#           TASK-PID   %s  CPU#   TIMESTAMP  FUNCTION\n", tgid ? "TGID     " : "");
-	seq_printf(m, "#              | |     %s    |       |         |\n",	 tgid ? "  |      " : "");
+	seq_printf(m, "#           TASK-PID    %s CPU#     TIMESTAMP  FUNCTION\n", tgid ? "   TGID   " : "");
+	seq_printf(m, "#              | |      %s   |         |         |\n",      tgid ? "     |    " : "");
 }
 
 static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file *m,
 				       unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
-	const char *space = "          ";
-	int prec = tgid ? 10 : 2;
+	const char *space = "            ";
+	int prec = tgid ? 12 : 2;
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#                          %.*s  _-----=> irqs-off\n", prec, space);
-	seq_printf(m, "#                          %.*s / _----=> need-resched\n", prec, space);
-	seq_printf(m, "#                          %.*s| / _---=> hardirq/softirq\n", prec, space);
-	seq_printf(m, "#                          %.*s|| / _--=> preempt-depth\n", prec, space);
-	seq_printf(m, "#                          %.*s||| /     delay\n", prec, space);
-	seq_printf(m, "#           TASK-PID %.*sCPU#  ||||    TIMESTAMP  FUNCTION\n", prec, "   TGID   ");
-	seq_printf(m, "#              | |   %.*s  |   ||||       |         |\n", prec, "     |    ");
+	seq_printf(m, "#                            %.*s  _-----=> irqs-off\n", prec, space);
+	seq_printf(m, "#                            %.*s / _----=> need-resched\n", prec, space);
+	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq\n", prec, space);
+	seq_printf(m, "#                            %.*s|| / _--=> preempt-depth\n", prec, space);
+	seq_printf(m, "#                            %.*s||| /     delay\n", prec, space);
+	seq_printf(m, "#           TASK-PID  %.*s CPU#  ||||   TIMESTAMP  FUNCTION\n", prec, "     TGID   ");
+	seq_printf(m, "#              | |    %.*s   |   ||||      |         |\n", prec, "       |    ");
 }
 
 void
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 4d1893564912d..000e9dc224c61 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -497,7 +497,7 @@ lat_print_generic(struct trace_seq *s, struct trace_entry *entry, int cpu)
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%8.8s-%-5d %3d",
+	trace_seq_printf(s, "%8.8s-%-7d %3d",
 			 comm, entry->pid, cpu);
 
 	return trace_print_lat_fmt(s, entry);
@@ -588,15 +588,15 @@ int trace_print_context(struct trace_iterator *iter)
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%16s-%-5d ", comm, entry->pid);
+	trace_seq_printf(s, "%16s-%-7d ", comm, entry->pid);
 
 	if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
 		unsigned int tgid = trace_find_tgid(entry->pid);
 
 		if (!tgid)
-			trace_seq_printf(s, "(-----) ");
+			trace_seq_printf(s, "(-------) ");
 		else
-			trace_seq_printf(s, "(%5d) ", tgid);
+			trace_seq_printf(s, "(%7d) ", tgid);
 	}
 
 	trace_seq_printf(s, "[%03d] ", iter->cpu);
@@ -636,7 +636,7 @@ int trace_print_lat_context(struct trace_iterator *iter)
 		trace_find_cmdline(entry->pid, comm);
 
 		trace_seq_printf(
-			s, "%16s %5d %3d %d %08x %08lx ",
+			s, "%16s %7d %3d %d %08x %08lx ",
 			comm, entry->pid, iter->cpu, entry->flags,
 			entry->preempt_count, iter->idx);
 	} else {
@@ -917,7 +917,7 @@ static enum print_line_t trace_ctxwake_print(struct trace_iterator *iter,
 	S = task_index_to_char(field->prev_state);
 	trace_find_cmdline(field->next_pid, comm);
 	trace_seq_printf(&iter->seq,
-			 " %5d:%3d:%c %s [%03d] %5d:%3d:%c %s\n",
+			 " %7d:%3d:%c %s [%03d] %7d:%3d:%c %s\n",
 			 field->prev_pid,
 			 field->prev_prio,
 			 S, delim,
-- 
2.28.0

