Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE4C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E4A207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580290609;
	bh=DZ6cNW7EQxmYs49rH7B2HqfRf24CHmSwGFZ8QdAhuB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ceFUdBjdohx7Id6XxY4/Mx657VOamlx/mIbKOJIcFyAZZCNZi7G1hvvHSaxB1gsf1
	 9d1/6imToU3XXGuZWudHz+99FUiv7na9jDksx5vwNjl1/KURSI5CtSr8H0MP+ucQXd
	 SDhTZoOI3pttpvRn2JQ0mEqrlUIoUz8zerZrfjJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgA2Jgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgA2Jgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:36:48 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AFC20732;
        Wed, 29 Jan 2020 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580290607;
        bh=DZ6cNW7EQxmYs49rH7B2HqfRf24CHmSwGFZ8QdAhuB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFBiTWdofvYK4lzfXw6OaDRKzBxjmtjlfgHzP5Ne1CVeZyyRYMdAb8bclHovz8mp5
         TOUu6/YhFtnj4l8a4werQROq/4ARsPomYgJjtjMi3U13KNTYo0cqzw/z9P+KAoGAqX
         bSzmRpJNNGvUq1n6uMsC4Lw59mpBjw4unJcIbjik=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing/boot: Move external function declarations to kernel/trace/trace.h
Date:   Wed, 29 Jan 2020 18:36:44 +0900
Message-Id: <158029060405.12381.11944554430359702545.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158029058421.12381.6615257646562417558.stgit@devnote2>
References: <158029058421.12381.6615257646562417558.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move external function declarations into kernel/trace/trace.h
from trace_boot.c for tracing subsystem internal use.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.h      |   17 +++++++++++++++++
 kernel/trace/trace_boot.c |   15 ---------------
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

