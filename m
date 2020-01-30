Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0DAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77C4206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgA3OtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbgA3OsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FFB215A4;
        Thu, 30 Jan 2020 14:48:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB74-001CKf-Ks; Thu, 30 Jan 2020 09:48:10 -0500
Message-Id: <20200130144810.532556153@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:47:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 02/21] tracing/boot: Move external function declarations to
 kernel/trace/trace.h
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Move external function declarations into kernel/trace/trace.h
from trace_boot.c for tracing subsystem internal use.

Link: http://lkml.kernel.org/r/158029060405.12381.11944554430359702545.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h      | 17 +++++++++++++++++
 kernel/trace/trace_boot.c | 15 ---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6bb64d89c321..b3075b637d14 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1157,6 +1157,11 @@ int unregister_ftrace_command(struct ftrace_func_command *cmd);
 void ftrace_create_filter_files(struct ftrace_ops *ops,
 				struct dentry *parent);
 void ftrace_destroy_filter_files(struct ftrace_ops *ops);
+
+extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
+			     int len, int reset);
+extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
+			      int len, int reset);
 #else
 struct ftrace_func_command;
 
@@ -1905,6 +1910,15 @@ void trace_printk_start_comm(void);
 int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set);
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
 
+/* Used from boot time tracer */
+extern int trace_set_options(struct trace_array *tr, char *option);
+extern int tracing_set_tracer(struct trace_array *tr, const char *buf);
+extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
+					  unsigned long size, int cpu_id);
+extern int tracing_set_cpumask(struct trace_array *tr,
+				cpumask_var_t tracing_cpumask_new);
+
+
 #define MAX_EVENT_NAME_LEN	64
 
 extern int trace_run_command(const char *buf, int (*createfn)(int, char**));
@@ -1964,6 +1978,9 @@ static inline const char *get_syscall_name(int syscall)
 #ifdef CONFIG_EVENT_TRACING
 void trace_event_init(void);
 void trace_event_eval_update(struct trace_eval_map **map, int len);
+/* Used from boot time tracer */
+extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 #else
 static inline void __init trace_event_init(void) { }
 static inline void trace_event_eval_update(struct trace_eval_map **map, int len) { }
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 5aad41961f03..4d37bf5c3742 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -21,13 +21,6 @@
 
 #define MAX_BUF_LEN 256
 
-extern int trace_set_options(struct trace_array *tr, char *option);
-extern int tracing_set_tracer(struct trace_array *tr, const char *buf);
-extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
-					  unsigned long size, int cpu_id);
-extern int tracing_set_cpumask(struct trace_array *tr,
-				cpumask_var_t tracing_cpumask_new);
-
 static void __init
 trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 {
@@ -76,9 +69,6 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 }
 
 #ifdef CONFIG_EVENT_TRACING
-extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
-extern int trigger_process_regex(struct trace_event_file *file, char *buff);
-
 static void __init
 trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 {
@@ -252,11 +242,6 @@ trace_boot_init_events(struct trace_array *tr, struct xbc_node *node)
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-extern bool ftrace_filter_param __initdata;
-extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
-			     int len, int reset);
-extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
-			      int len, int reset);
 static void __init
 trace_boot_set_ftrace_filter(struct trace_array *tr, struct xbc_node *node)
 {
-- 
2.24.1


