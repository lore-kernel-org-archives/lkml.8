Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6570C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722D120BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599741927;
	bh=hQgVtpZwhwf/vdDJDvYnRXakjlhVJf5ntKzIw41Te6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZsPilvKuJRbmHj6FsmzB1B2fC9OF1YYNRwmoQSVdtdz1S0ZLneYhLka7cU9+/b6Dk
	 iDOAgaHdfoso/tvY/NYv3EZ0BMWc8gypvTCvEbyfadUxQU63s2l7ebyOy4FnOtgslG
	 M8ipX1EWZQytZ8nJUJC1H7rXUe77GoxTWDZFDtzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgIJMpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbgIJMkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:40:11 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CDAC21941;
        Thu, 10 Sep 2020 12:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599741551;
        bh=hQgVtpZwhwf/vdDJDvYnRXakjlhVJf5ntKzIw41Te6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mIRJ51OWSe10KDtiKC0UTE5k39k5EXy3Z2j8LFKIWtneBXTLWtpAMR80xKcvWt/pF
         z7A6lpyeqocS6qIcqvpqF2CPh7lIdeuJ7+pw+noe/qKHUSsXqZ3o9XvMA9tdryqNmS
         ldeCiPZ10/2ZqoIv16e+BUg5hsRqlViS6zPX5Erg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4/6] tracing: Enable creating new instance early boot
Date:   Thu, 10 Sep 2020 21:39:07 +0900
Message-Id: <159974154763.478751.6289753509587233103.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159974150897.478751.17933810682730471522.stgit@devnote2>
References: <159974150897.478751.17933810682730471522.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable creating new trace_array instance in early boot stage.
If the instances directory is not created, postpone it until
the tracefs is initialized.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c           |   53 ++++++++++++++++++++++++++++++++--------
 kernel/trace/trace.h           |    7 +++++
 kernel/trace/trace_functions.c |   22 +++++++++++------
 3 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index faf55f5dd99d..f7696db52e7d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8636,6 +8636,24 @@ struct trace_array *trace_array_find_get(const char *instance)
 	return tr;
 }
 
+static int trace_array_create_dir(struct trace_array *tr)
+{
+	int ret;
+
+	tr->dir = tracefs_create_dir(tr->name, trace_instance_dir);
+	if (!tr->dir)
+		return -EINVAL;
+
+	ret = event_trace_add_tracer(tr->dir, tr);
+	if (ret)
+		tracefs_remove(tr->dir);
+
+	init_tracer_tracefs(tr, tr->dir);
+	__update_tracer_options(tr);
+
+	return ret;
+}
+
 static struct trace_array *trace_array_create(const char *name)
 {
 	struct trace_array *tr;
@@ -8671,30 +8689,27 @@ static struct trace_array *trace_array_create(const char *name)
 	if (allocate_trace_buffers(tr, trace_buf_size) < 0)
 		goto out_free_tr;
 
-	tr->dir = tracefs_create_dir(name, trace_instance_dir);
-	if (!tr->dir)
-		goto out_free_tr;
-
-	ret = event_trace_add_tracer(tr->dir, tr);
-	if (ret) {
-		tracefs_remove(tr->dir);
+	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
-	}
 
 	ftrace_init_trace_array(tr);
 
-	init_tracer_tracefs(tr, tr->dir);
 	init_trace_flags_index(tr);
-	__update_tracer_options(tr);
+
+	if (trace_instance_dir) {
+		ret = trace_array_create_dir(tr);
+		if (ret)
+			goto out_free_tr;
+	}
 
 	list_add(&tr->list, &ftrace_trace_arrays);
 
 	tr->ref++;
 
-
 	return tr;
 
  out_free_tr:
+	ftrace_free_ftrace_ops(tr);
 	free_trace_buffers(tr);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree(tr->name);
@@ -8853,11 +8868,27 @@ static int instance_rmdir(const char *name)
 
 static __init void create_trace_instances(struct dentry *d_tracer)
 {
+	struct trace_array *tr;
+
 	trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
 							 instance_mkdir,
 							 instance_rmdir);
 	if (MEM_FAIL(!trace_instance_dir, "Failed to create instances directory\n"))
 		return;
+
+	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (!tr->name)
+			continue;
+		if (MEM_FAIL(trace_array_create_dir(tr) < 0,
+			     "Failed to create instance directory\n"))
+			break;
+	}
+
+	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 }
 
 static void
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 610d21355526..e1b3061ce06d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1125,6 +1125,8 @@ extern int ftrace_is_dead(void);
 int ftrace_create_function_files(struct trace_array *tr,
 				 struct dentry *parent);
 void ftrace_destroy_function_files(struct trace_array *tr);
+int ftrace_allocate_ftrace_ops(struct trace_array *tr);
+void ftrace_free_ftrace_ops(struct trace_array *tr);
 void ftrace_init_global_array_ops(struct trace_array *tr);
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func);
 void ftrace_reset_array_ops(struct trace_array *tr);
@@ -1146,6 +1148,11 @@ ftrace_create_function_files(struct trace_array *tr,
 {
 	return 0;
 }
+static inline int ftrace_allocate_ftrace_ops(struct trace_array *tr)
+{
+	return 0;
+}
+static inline void ftrace_free_ftrace_ops(struct trace_array *tr) { }
 static inline void ftrace_destroy_function_files(struct trace_array *tr) { }
 static inline __init void
 ftrace_init_global_array_ops(struct trace_array *tr) { }
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index dd4dff71d89a..2c2126e1871d 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -34,10 +34,14 @@ enum {
 	TRACE_FUNC_OPT_STACK	= 0x1,
 };
 
-static int allocate_ftrace_ops(struct trace_array *tr)
+int ftrace_allocate_ftrace_ops(struct trace_array *tr)
 {
 	struct ftrace_ops *ops;
 
+	/* The top level array uses the "global_ops" */
+	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
+		return 0;
+
 	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 	if (!ops)
 		return -ENOMEM;
@@ -48,15 +52,19 @@ static int allocate_ftrace_ops(struct trace_array *tr)
 
 	tr->ops = ops;
 	ops->private = tr;
+
 	return 0;
 }
 
+void ftrace_free_ftrace_ops(struct trace_array *tr)
+{
+	kfree(tr->ops);
+	tr->ops = NULL;
+}
 
 int ftrace_create_function_files(struct trace_array *tr,
 				 struct dentry *parent)
 {
-	int ret;
-
 	/*
 	 * The top level array uses the "global_ops", and the files are
 	 * created on boot up.
@@ -64,9 +72,8 @@ int ftrace_create_function_files(struct trace_array *tr,
 	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
 		return 0;
 
-	ret = allocate_ftrace_ops(tr);
-	if (ret)
-		return ret;
+	if (!tr->ops)
+		return -EINVAL;
 
 	ftrace_create_filter_files(tr->ops, parent);
 
@@ -76,8 +83,7 @@ int ftrace_create_function_files(struct trace_array *tr,
 void ftrace_destroy_function_files(struct trace_array *tr)
 {
 	ftrace_destroy_filter_files(tr->ops);
-	kfree(tr->ops);
-	tr->ops = NULL;
+	ftrace_free_ftrace_ops(tr);
 }
 
 static int function_trace_init(struct trace_array *tr)

