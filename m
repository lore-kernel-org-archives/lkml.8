Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CDCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BC9206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgA3OsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbgA3OsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942F324682;
        Thu, 30 Jan 2020 14:48:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB75-001CNa-H5; Thu, 30 Jan 2020 09:48:11 -0500
Message-Id: <20200130144811.405011255@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:47:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 08/21] tracing: Add trace_get/put_event_file()
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add a function to get an event file and prevent it from going away on
module or instance removal.

trace_get_event_file() will find an event file in a given instance (if
instance is NULL, it assumes the top trace array) and return it,
pinning the instance's trace array as well as the event's module, if
applicable, so they won't go away while in use.

trace_put_event_file() does the matching release.

Link: http://lkml.kernel.org/r/bb31ac4bdda168d5ed3c4b5f5a4c8f633e8d9118.1580323897.git.zanussi@kernel.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
[ Moved trace_array_put() to end of trace_put_event_file() ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h |  5 +++
 kernel/trace/trace_events.c  | 85 ++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 20948ee56f8c..8d621a73c97e 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -349,6 +349,11 @@ enum {
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
 };
 
+extern struct trace_event_file *trace_get_event_file(const char *instance,
+						     const char *system,
+						     const char *event);
+extern void trace_put_event_file(struct trace_event_file *file);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index dfb736a964d6..da62472b1297 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2536,6 +2536,91 @@ find_event_file(struct trace_array *tr, const char *system, const char *event)
 	return file;
 }
 
+/**
+ * trace_get_event_file - Find and return a trace event file
+ * @instance: The name of the trace instance containing the event
+ * @system: The name of the system containing the event
+ * @event: The name of the event
+ *
+ * Return a trace event file given the trace instance name, trace
+ * system, and trace event name.  If the instance name is NULL, it
+ * refers to the top-level trace array.
+ *
+ * This function will look it up and return it if found, after calling
+ * trace_array_get() to prevent the instance from going away, and
+ * increment the event's module refcount to prevent it from being
+ * removed.
+ *
+ * To release the file, call trace_put_event_file(), which will call
+ * trace_array_put() and decrement the event's module refcount.
+ *
+ * Return: The trace event on success, ERR_PTR otherwise.
+ */
+struct trace_event_file *trace_get_event_file(const char *instance,
+					      const char *system,
+					      const char *event)
+{
+	struct trace_array *tr = top_trace_array();
+	struct trace_event_file *file = NULL;
+	int ret = -EINVAL;
+
+	if (instance) {
+		tr = trace_array_find_get(instance);
+		if (!tr)
+			return ERR_PTR(-ENOENT);
+	} else {
+		ret = trace_array_get(tr);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	mutex_lock(&event_mutex);
+
+	file = find_event_file(tr, system, event);
+	if (!file) {
+		trace_array_put(tr);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Don't let event modules unload while in use */
+	ret = try_module_get(file->event_call->mod);
+	if (!ret) {
+		trace_array_put(tr);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = 0;
+ out:
+	mutex_unlock(&event_mutex);
+
+	if (ret)
+		file = ERR_PTR(ret);
+
+	return file;
+}
+EXPORT_SYMBOL_GPL(trace_get_event_file);
+
+/**
+ * trace_put_event_file - Release a file from trace_get_event_file()
+ * @file: The trace event file
+ *
+ * If a file was retrieved using trace_get_event_file(), this should
+ * be called when it's no longer needed.  It will cancel the previous
+ * trace_array_get() called by that function, and decrement the
+ * event's module refcount.
+ */
+void trace_put_event_file(struct trace_event_file *file)
+{
+	mutex_lock(&event_mutex);
+	module_put(file->event_call->mod);
+	mutex_unlock(&event_mutex);
+
+	trace_array_put(file->tr);
+}
+EXPORT_SYMBOL_GPL(trace_put_event_file);
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 /* Avoid typos */
-- 
2.24.1


