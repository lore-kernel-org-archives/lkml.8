Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93404C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E52722D05
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgHDU61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbgHDU6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD7DC22CF8;
        Tue,  4 Aug 2020 20:58:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k340j-006HEU-JX; Tue, 04 Aug 2020 16:58:13 -0400
Message-ID: <20200804205813.485673301@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Aug 2020 16:57:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [for-linus][PATCH 11/17] ftrace: Fix ftrace_trace_task return value
References: <20200804205743.419135730@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

I was attempting to use pid filtering with function_graph, but it wasn't
allowing anything to make it through.  Turns out ftrace_trace_task
returns false if ftrace_ignore_pid is not-empty, which isn't correct
anymore.  We're now setting it to FTRACE_PID_IGNORE if we need to ignore
that pid, otherwise it's set to the pid (which is weird considering the
name) or to FTRACE_PID_TRACE.  Fix the check to check for !=
FTRACE_PID_IGNORE.  With this we can now use function_graph with pid
filtering.

Link: https://lkml.kernel.org/r/20200725005048.1790-1-josef@toxicpanda.com

Fixes: 717e3f5ebc82 ("ftrace: Make function trace pid filtering a bit more exact")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 3 ---
 kernel/trace/trace.h  | 7 ++++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f433cb44300a..4e3a5d79c078 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -139,9 +139,6 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 #endif
 }
 
-#define FTRACE_PID_IGNORE	-1
-#define FTRACE_PID_TRACE	-2
-
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			    struct ftrace_ops *op, struct pt_regs *regs)
 {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f21607f87189..610d21355526 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1103,6 +1103,10 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 extern struct list_head ftrace_pids;
 
 #ifdef CONFIG_FUNCTION_TRACER
+
+#define FTRACE_PID_IGNORE	-1
+#define FTRACE_PID_TRACE	-2
+
 struct ftrace_func_command {
 	struct list_head	list;
 	char			*name;
@@ -1114,7 +1118,8 @@ struct ftrace_func_command {
 extern bool ftrace_filter_param __initdata;
 static inline int ftrace_trace_task(struct trace_array *tr)
 {
-	return !this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid);
+	return this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid) !=
+		FTRACE_PID_IGNORE;
 }
 extern int ftrace_is_dead(void);
 int ftrace_create_function_files(struct trace_array *tr,
-- 
2.26.2


