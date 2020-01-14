Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9851C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C9B24658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgANVEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:04:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbgANVDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF3E2468E;
        Tue, 14 Jan 2020 21:03:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLf-000DB0-5a; Tue, 14 Jan 2020 16:03:39 -0500
Message-Id: <20200114210339.056588583@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 23/26] tracing/boot: Add cpu_mask option support
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add ftrace.cpumask option support to boot-time tracing.
This sets cpumask for each instance.

 - ftrace.[instance.INSTANCE.]cpumask = CPUMASK;
   Set the trace cpumask. Note that the CPUMASK should be a string
   which <tracefs>/tracing_cpumask can accepts.

Link: http://lkml.kernel.org/r/157867243625.17873.13613922641273149372.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c      | 42 +++++++++++++++++++++++++++------------
 kernel/trace/trace_boot.c | 14 +++++++++++++
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6c996d1b1687..106bbc0988fe 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4561,20 +4561,13 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 	return count;
 }
 
-static ssize_t
-tracing_cpumask_write(struct file *filp, const char __user *ubuf,
-		      size_t count, loff_t *ppos)
+int tracing_set_cpumask(struct trace_array *tr,
+			cpumask_var_t tracing_cpumask_new)
 {
-	struct trace_array *tr = file_inode(filp)->i_private;
-	cpumask_var_t tracing_cpumask_new;
-	int err, cpu;
-
-	if (!alloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
-		return -ENOMEM;
+	int cpu;
 
-	err = cpumask_parse_user(ubuf, count, tracing_cpumask_new);
-	if (err)
-		goto err_unlock;
+	if (!tr)
+		return -EINVAL;
 
 	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
@@ -4598,11 +4591,34 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	local_irq_enable();
 
 	cpumask_copy(tr->tracing_cpumask, tracing_cpumask_new);
+
+	return 0;
+}
+
+static ssize_t
+tracing_cpumask_write(struct file *filp, const char __user *ubuf,
+		      size_t count, loff_t *ppos)
+{
+	struct trace_array *tr = file_inode(filp)->i_private;
+	cpumask_var_t tracing_cpumask_new;
+	int err;
+
+	if (!alloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = cpumask_parse_user(ubuf, count, tracing_cpumask_new);
+	if (err)
+		goto err_free;
+
+	err = tracing_set_cpumask(tr, tracing_cpumask_new);
+	if (err)
+		goto err_free;
+
 	free_cpumask_var(tracing_cpumask_new);
 
 	return count;
 
-err_unlock:
+err_free:
 	free_cpumask_var(tracing_cpumask_new);
 
 	return err;
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index f5db30d25b0b..81d923c16a4d 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -18,6 +18,8 @@ extern int trace_set_options(struct trace_array *tr, char *option);
 extern int tracing_set_tracer(struct trace_array *tr, const char *buf);
 extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
+extern int tracing_set_cpumask(struct trace_array *tr,
+				cpumask_var_t tracing_cpumask_new);
 
 static void __init
 trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
@@ -52,6 +54,18 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
 			pr_err("Failed to resize trace buffer to %s\n", p);
 	}
+
+	p = xbc_node_find_value(node, "cpumask", NULL);
+	if (p && *p != '\0') {
+		cpumask_var_t new_mask;
+
+		if (alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
+			if (cpumask_parse(p, new_mask) < 0 ||
+			    tracing_set_cpumask(tr, new_mask) < 0)
+				pr_err("Failed to set new CPU mask %s\n", p);
+			free_cpumask_var(new_mask);
+		}
+	}
 }
 
 #ifdef CONFIG_EVENT_TRACING
-- 
2.24.1


