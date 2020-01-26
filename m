Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0AAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEE321741
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgAZTUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgAZTUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:20:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F7E2075D;
        Sun, 26 Jan 2020 19:20:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ivnSH-000zt0-Ey; Sun, 26 Jan 2020 14:20:21 -0500
Message-Id: <20200126192021.350763989@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 Jan 2020 14:19:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [for-next][PATCH 7/7] tracing: Use pr_err() instead of WARN() for memory failures
References: <20200126191932.984391723@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As warnings can trigger panics, especially when "panic_on_warn" is set,
memory failure warnings can cause panics and fail fuzz testers that are
stressing memory.

Create a MEM_FAIL() macro to use instead of WARN() in the tracing code
(perhaps this should be a kernel wide macro?), and use that for memory
failure issues. This should stop failing fuzz tests due to warnings.

Link: https://lore.kernel.org/r/CACT4Y+ZP-7np20GVRu3p+eZys9GPtbu+JpfV+HtsufAzvTgJrg@mail.gmail.com

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c |  4 ++--
 kernel/trace/trace.c  | 18 +++++++++---------
 kernel/trace/trace.h  | 12 ++++++++++++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5c701765da5b..fdb1a9532420 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5459,7 +5459,7 @@ static void __init set_ftrace_early_graph(char *buf, int enable)
 	struct ftrace_hash *hash;
 
 	hash = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
-	if (WARN_ON(!hash))
+	if (MEM_FAIL(!hash, "Failed to allocate hash\n"))
 		return;
 
 	while (buf) {
@@ -6591,7 +6591,7 @@ static void add_to_clear_hash_list(struct list_head *clear_list,
 
 	func = kmalloc(sizeof(*func), GFP_KERNEL);
 	if (!func) {
-		WARN_ONCE(1, "alloc failure, ftrace filter could be stale\n");
+		MEM_FAIL(1, "alloc failure, ftrace filter could be stale\n");
 		return;
 	}
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0a5569b1cace..6a28b1b9bf42 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3126,7 +3126,7 @@ static int alloc_percpu_trace_buffer(void)
 	struct trace_buffer_struct *buffers;
 
 	buffers = alloc_percpu(struct trace_buffer_struct);
-	if (WARN(!buffers, "Could not allocate percpu trace_printk buffer"))
+	if (MEM_FAIL(!buffers, "Could not allocate percpu trace_printk buffer"))
 		return -ENOMEM;
 
 	trace_percpu_buffer = buffers;
@@ -7932,7 +7932,7 @@ static struct dentry *tracing_dentry_percpu(struct trace_array *tr, int cpu)
 
 	tr->percpu_dir = tracefs_create_dir("per_cpu", d_tracer);
 
-	WARN_ONCE(!tr->percpu_dir,
+	MEM_FAIL(!tr->percpu_dir,
 		  "Could not create tracefs directory 'per_cpu/%d'\n", cpu);
 
 	return tr->percpu_dir;
@@ -8253,7 +8253,7 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 	for (cnt = 0; opts[cnt].name; cnt++) {
 		create_trace_option_file(tr, &topts[cnt], flags,
 					 &opts[cnt]);
-		WARN_ONCE(topts[cnt].entry == NULL,
+		MEM_FAIL(topts[cnt].entry == NULL,
 			  "Failed to create trace option: %s",
 			  opts[cnt].name);
 	}
@@ -8437,7 +8437,7 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 #ifdef CONFIG_TRACER_MAX_TRACE
 	ret = allocate_trace_buffer(tr, &tr->max_buffer,
 				    allocate_snapshot ? size : 1);
-	if (WARN_ON(ret)) {
+	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n")) {
 		ring_buffer_free(tr->array_buffer.buffer);
 		tr->array_buffer.buffer = NULL;
 		free_percpu(tr->array_buffer.data);
@@ -8726,7 +8726,7 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 	trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
 							 instance_mkdir,
 							 instance_rmdir);
-	if (WARN_ON(!trace_instance_dir))
+	if (MEM_FAIL(!trace_instance_dir, "Failed to create instances directory\n"))
 		return;
 }
 
@@ -8796,7 +8796,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 #endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
-		WARN(1, "Could not allocate function filter files");
+		MEM_FAIL(1, "Could not allocate function filter files");
 
 #ifdef CONFIG_TRACER_SNAPSHOT
 	trace_create_file("snapshot", 0644, d_tracer,
@@ -9348,8 +9348,7 @@ __init static int tracer_alloc_buffers(void)
 
 	/* TODO: make the number of buffers hot pluggable with CPUS */
 	if (allocate_trace_buffers(&global_trace, ring_buf_size) < 0) {
-		printk(KERN_ERR "tracer: failed to allocate ring buffer!\n");
-		WARN_ON(1);
+		MEM_FAIL(1, "tracer: failed to allocate ring buffer!\n");
 		goto out_free_savedcmd;
 	}
 
@@ -9422,7 +9421,8 @@ void __init early_trace_init(void)
 	if (tracepoint_printk) {
 		tracepoint_print_iter =
 			kmalloc(sizeof(*tracepoint_print_iter), GFP_KERNEL);
-		if (WARN_ON(!tracepoint_print_iter))
+		if (MEM_FAIL(!tracepoint_print_iter,
+			     "Failed to allocate trace iterator\n"))
 			tracepoint_printk = 0;
 		else
 			static_key_enable(&tracepoint_printk_key.key);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4812a36affac..6bb64d89c321 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -94,6 +94,18 @@ enum trace_type {
 
 #include "trace_entries.h"
 
+/* Use this for memory failure errors */
+#define MEM_FAIL(condition, fmt, ...) ({			\
+	static bool __section(.data.once) __warned;		\
+	int __ret_warn_once = !!(condition);			\
+								\
+	if (unlikely(__ret_warn_once && !__warned)) {		\
+		__warned = true;				\
+		pr_err("ERROR: " fmt, ##__VA_ARGS__);		\
+	}							\
+	unlikely(__ret_warn_once);				\
+})
+
 /*
  * syscalls are special, and need special handling, this is why
  * they are not included in trace_entries.h
-- 
2.24.1


