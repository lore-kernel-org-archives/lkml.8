Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD76C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D470206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgA3OtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:49:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgA3OsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D70214DB;
        Thu, 30 Jan 2020 14:48:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB75-001CO4-Lm; Thu, 30 Jan 2020 09:48:11 -0500
Message-Id: <20200130144811.553817659@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:47:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 09/21] tracing: Add synth_event_delete()
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

create_or_delete_synth_event() contains code to delete a synthetic
event, which would be useful on its own - specifically, it would be
useful to allow event-creating modules to call it separately.

Separate out the delete code from that function and create an exported
function named synth_event_delete().

Link: http://lkml.kernel.org/r/050db3b06df7f0a4b8a2922da602d1d879c7c1c2.1580323897.git.zanussi@kernel.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h     |  2 ++
 kernel/trace/trace_events_hist.c | 57 +++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8d621a73c97e..25fe743bcbaf 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -354,6 +354,8 @@ extern struct trace_event_file *trace_get_event_file(const char *instance,
 						     const char *event);
 extern void trace_put_event_file(struct trace_event_file *file);
 
+extern int synth_event_delete(const char *name);
+
 /*
  * Event file flags:
  *  ENABLED	  - The event is enabled
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c322826e0726..21e316732700 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1360,29 +1360,54 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	goto out;
 }
 
+static int destroy_synth_event(struct synth_event *se)
+{
+	int ret;
+
+	if (se->ref)
+		ret = -EBUSY;
+	else {
+		ret = unregister_synth_event(se);
+		if (!ret) {
+			dyn_event_remove(&se->devent);
+			free_synth_event(se);
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * synth_event_delete - Delete a synthetic event
+ * @event_name: The name of the new sythetic event
+ *
+ * Delete a synthetic event that was created with synth_event_create().
+ *
+ * Return: 0 if successful, error otherwise.
+ */
+int synth_event_delete(const char *event_name)
+{
+	struct synth_event *se = NULL;
+	int ret = -ENOENT;
+
+	mutex_lock(&event_mutex);
+	se = find_synth_event(event_name);
+	if (se)
+		ret = destroy_synth_event(se);
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(synth_event_delete);
+
 static int create_or_delete_synth_event(int argc, char **argv)
 {
 	const char *name = argv[0];
-	struct synth_event *event = NULL;
 	int ret;
 
 	/* trace_run_command() ensures argc != 0 */
 	if (name[0] == '!') {
-		mutex_lock(&event_mutex);
-		event = find_synth_event(name + 1);
-		if (event) {
-			if (event->ref)
-				ret = -EBUSY;
-			else {
-				ret = unregister_synth_event(event);
-				if (!ret) {
-					dyn_event_remove(&event->devent);
-					free_synth_event(event);
-				}
-			}
-		} else
-			ret = -ENOENT;
-		mutex_unlock(&event_mutex);
+		ret = synth_event_delete(name + 1);
 		return ret;
 	}
 
-- 
2.24.1


