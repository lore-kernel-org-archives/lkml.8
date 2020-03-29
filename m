Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A65CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE25206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgC2SoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbgC2SnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17CC21473;
        Sun, 29 Mar 2020 18:43:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIctx-002Fyc-TC; Sun, 29 Mar 2020 14:43:17 -0400
Message-Id: <20200329184317.785657014@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:43:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 16/21] ftrace: Make function trace pid filtering a bit more exact
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The set_ftrace_pid file is used to filter function tracing to only trace
tasks that are listed in that file. Instead of testing the pids listed in
that file (it's a bitmask) at each function trace event, the logic is done
via a sched_switch hook. A flag is set when the next task to run is in the
list of pids in the set_ftrace_pid file. But the sched_switch hook is not at
the exact location of when the task switches, and the flag gets set before
the task to be traced actually runs. This leaves a residue of traced
functions that do not belong to the pid that should be filtered on.

By changing the logic slightly, where instead of having  a boolean flag to
test, record the pid that should be traced, with special values for not to
trace and always trace. Then at each function call, a check will be made to
see if the function should be ignored, or if the current pid matches the
function that should be traced, and only trace if it matches (or if it has
the special value to always trace).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 32 +++++++++++++++++++++++++-------
 kernel/trace/trace.h  |  4 ++--
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3f7ee102868a..34ae736cb1f8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -139,13 +139,23 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 #endif
 }
 
+#define FTRACE_PID_IGNORE	-1
+#define FTRACE_PID_TRACE	-2
+
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			    struct ftrace_ops *op, struct pt_regs *regs)
 {
 	struct trace_array *tr = op->private;
+	int pid;
 
-	if (tr && this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid))
-		return;
+	if (tr) {
+		pid = this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid);
+		if (pid == FTRACE_PID_IGNORE)
+			return;
+		if (pid != FTRACE_PID_TRACE &&
+		    pid != current->pid)
+			return;
+	}
 
 	op->saved_func(ip, parent_ip, op, regs);
 }
@@ -6924,8 +6934,12 @@ ftrace_filter_pid_sched_switch_probe(void *data, bool preempt,
 
 	pid_list = rcu_dereference_sched(tr->function_pids);
 
-	this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
-		       trace_ignore_this_task(pid_list, next));
+	if (trace_ignore_this_task(pid_list, next))
+		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
+			       FTRACE_PID_IGNORE);
+	else
+		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
+			       next->pid);
 }
 
 static void
@@ -6978,7 +6992,7 @@ static void clear_ftrace_pids(struct trace_array *tr)
 	unregister_trace_sched_switch(ftrace_filter_pid_sched_switch_probe, tr);
 
 	for_each_possible_cpu(cpu)
-		per_cpu_ptr(tr->array_buffer.data, cpu)->ftrace_ignore_pid = false;
+		per_cpu_ptr(tr->array_buffer.data, cpu)->ftrace_ignore_pid = FTRACE_PID_TRACE;
 
 	rcu_assign_pointer(tr->function_pids, NULL);
 
@@ -7103,8 +7117,12 @@ static void ignore_task_cpu(void *data)
 	pid_list = rcu_dereference_protected(tr->function_pids,
 					     mutex_is_locked(&ftrace_lock));
 
-	this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
-		       trace_ignore_this_task(pid_list, current));
+	if (trace_ignore_this_task(pid_list, current))
+		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
+			       FTRACE_PID_IGNORE);
+	else
+		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
+			       current->pid);
 }
 
 static ssize_t
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f37e05135986..fdc72f5f0bb0 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -178,10 +178,10 @@ struct trace_array_cpu {
 	kuid_t			uid;
 	char			comm[TASK_COMM_LEN];
 
-	bool			ignore_pid;
 #ifdef CONFIG_FUNCTION_TRACER
-	bool			ftrace_ignore_pid;
+	int			ftrace_ignore_pid;
 #endif
+	bool			ignore_pid;
 };
 
 struct tracer;
-- 
2.25.1


