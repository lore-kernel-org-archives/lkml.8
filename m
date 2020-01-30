Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27377C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A9B21734
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgA3OsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbgA3OsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC1B22522;
        Thu, 30 Jan 2020 14:48:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB75-001CN6-CL; Thu, 30 Jan 2020 09:48:11 -0500
Message-Id: <20200130144811.265074620@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:47:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 07/21] tracing: Add trace_array_find/_get() to find instance trace arrays
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add a new trace_array_find() function that can be used to find a trace
array given the instance name, and replace existing code that does the
same thing with it.  Also add trace_array_find_get() which does the
same but returns the trace array after upping its refcount.

Also make both available for use outside of trace.c.

Link: http://lkml.kernel.org/r/cb68528c975eba95bee4561ac67dd1499423b2e5.1580323897.git.zanussi@kernel.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 43 +++++++++++++++++++++++++++++++++----------
 kernel/trace/trace.h |  2 ++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d144fd94aa8..183b031a3828 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8499,6 +8499,34 @@ static void update_tracer_options(struct trace_array *tr)
 	mutex_unlock(&trace_types_lock);
 }
 
+/* Must have trace_types_lock held */
+struct trace_array *trace_array_find(const char *instance)
+{
+	struct trace_array *tr, *found = NULL;
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr->name && strcmp(tr->name, instance) == 0) {
+			found = tr;
+			break;
+		}
+	}
+
+	return found;
+}
+
+struct trace_array *trace_array_find_get(const char *instance)
+{
+	struct trace_array *tr;
+
+	mutex_lock(&trace_types_lock);
+	tr = trace_array_find(instance);
+	if (tr)
+		tr->ref++;
+	mutex_unlock(&trace_types_lock);
+
+	return tr;
+}
+
 static struct trace_array *trace_array_create(const char *name)
 {
 	struct trace_array *tr;
@@ -8575,10 +8603,8 @@ static int instance_mkdir(const char *name)
 	mutex_lock(&trace_types_lock);
 
 	ret = -EEXIST;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0)
-			goto out_unlock;
-	}
+	if (trace_array_find(name))
+		goto out_unlock;
 
 	tr = trace_array_create(name);
 
@@ -8706,12 +8732,9 @@ static int instance_rmdir(const char *name)
 	mutex_lock(&trace_types_lock);
 
 	ret = -ENODEV;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0) {
-			ret = __remove_instance(tr);
-			break;
-		}
-	}
+	tr = trace_array_find(name);
+	if (tr)
+		ret = __remove_instance(tr);
 
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b3075b637d14..f5480a2aa334 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -358,6 +358,8 @@ extern struct mutex trace_types_lock;
 
 extern int trace_array_get(struct trace_array *tr);
 extern int tracing_check_open_get_tr(struct trace_array *tr);
+extern struct trace_array *trace_array_find(const char *instance);
+extern struct trace_array *trace_array_find_get(const char *instance);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
-- 
2.24.1


