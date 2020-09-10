Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA98DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9412206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599774658;
	bh=oVN9GF85pkdyT1vUsIhYyDM+zvcZ+4Ygedc8ht+u1Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vM0oUPJYVM/vDkPIAWj/jKrgeWn6ftmssoE3aCxuK/bqid/wKuooo55YiHrhCUv1l
	 al2cfqqBlzdsLZqCjC+RahaeTzLCxiJYxWPTGKYf/ni0m4m0F7EyHechL3SVCTW51l
	 3TbOGM2vIijGpM/4SwtMmGV6K+SQLjvJqmPm4GH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgIJVuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730780AbgIJMi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:38:57 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084B3214F1;
        Thu, 10 Sep 2020 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599741532;
        bh=oVN9GF85pkdyT1vUsIhYyDM+zvcZ+4Ygedc8ht+u1Fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qo/hW2xw7Qg2kppdyQoXfFjfwdYXmgJsg7q43c3BF0zurQ9P3YRsH2qdGbzatMYE8
         awZ/GvmZvS27EmVLbhfe/n6e5ScEXUpjfzQ0ILQ5dJwpMtJcSISSkkdENFjXe6OnCO
         HFXcO8HI+67xQ6ccgvO12P+R4iBva8K4fHJ5PG7Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/6] tracing: Define event fields early stage
Date:   Thu, 10 Sep 2020 21:38:48 +0900
Message-Id: <159974152862.478751.2023768466808361350.stgit@devnote2>
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

Define event fields at early stage so that boot-time tracing can
access the event fields (like per-event filter setting).

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events.c |   92 ++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 37 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a85effb2373b..a2531301b44f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2123,12 +2123,48 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	return NULL;
 }
 
+static int
+event_define_fields(struct trace_event_call *call)
+{
+	struct list_head *head;
+	int ret = 0;
+
+	/*
+	 * Other events may have the same class. Only update
+	 * the fields if they are not already defined.
+	 */
+	head = trace_get_fields(call);
+	if (list_empty(head)) {
+		struct trace_event_fields *field = call->class->fields_array;
+		unsigned int offset = sizeof(struct trace_entry);
+
+		for (; field->type; field++) {
+			if (field->type == TRACE_FUNCTION_TYPE) {
+				field->define_fields(call);
+				break;
+			}
+
+			offset = ALIGN(offset, field->align);
+			ret = trace_define_field(call, field->type, field->name,
+						 offset, field->size,
+						 field->is_signed, field->filter_type);
+			if (WARN_ON_ONCE(ret)) {
+				pr_err("error code is %d\n", ret);
+				break;
+			}
+
+			offset += field->size;
+		}
+	}
+
+	return ret;
+}
+
 static int
 event_create_dir(struct dentry *parent, struct trace_event_file *file)
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	struct list_head *head;
 	struct dentry *d_events;
 	const char *name;
 	int ret;
@@ -2162,35 +2198,10 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 				  &ftrace_event_id_fops);
 #endif
 
-	/*
-	 * Other events may have the same class. Only update
-	 * the fields if they are not already defined.
-	 */
-	head = trace_get_fields(call);
-	if (list_empty(head)) {
-		struct trace_event_fields *field = call->class->fields_array;
-		unsigned int offset = sizeof(struct trace_entry);
-
-		for (; field->type; field++) {
-			if (field->type == TRACE_FUNCTION_TYPE) {
-				ret = field->define_fields(call);
-				break;
-			}
-
-			offset = ALIGN(offset, field->align);
-			ret = trace_define_field(call, field->type, field->name,
-						 offset, field->size,
-						 field->is_signed, field->filter_type);
-			if (ret)
-				break;
-
-			offset += field->size;
-		}
-		if (ret < 0) {
-			pr_warn("Could not initialize trace point events/%s\n",
-				name);
-			return -1;
-		}
+	ret = event_define_fields(call);
+	if (ret < 0) {
+		pr_warn("Could not initialize trace point events/%s\n", name);
+		return ret;
 	}
 
 	/*
@@ -2493,7 +2504,7 @@ __trace_early_add_new_event(struct trace_event_call *call,
 	if (!file)
 		return -ENOMEM;
 
-	return 0;
+	return event_define_fields(call);
 }
 
 struct ftrace_module_file_ops;
@@ -3431,6 +3442,18 @@ static __init int event_trace_enable_again(void)
 
 early_initcall(event_trace_enable_again);
 
+/* Init fields which doesn't related to the tracefs */
+static __init int event_trace_init_fields(void)
+{
+	if (trace_define_generic_fields())
+		pr_warn("tracing: Failed to allocated generic fields");
+
+	if (trace_define_common_fields())
+		pr_warn("tracing: Failed to allocate common fields");
+
+	return 0;
+}
+
 __init int event_trace_init(void)
 {
 	struct trace_array *tr;
@@ -3451,12 +3474,6 @@ __init int event_trace_init(void)
 	if (!entry)
 		pr_warn("Could not create tracefs 'available_events' entry\n");
 
-	if (trace_define_generic_fields())
-		pr_warn("tracing: Failed to allocated generic fields");
-
-	if (trace_define_common_fields())
-		pr_warn("tracing: Failed to allocate common fields");
-
 	ret = early_event_add_tracer(d_tracer, tr);
 	if (ret)
 		return ret;
@@ -3474,6 +3491,7 @@ void __init trace_event_init(void)
 	event_trace_memsetup();
 	init_ftrace_syscalls();
 	event_trace_enable();
+	event_trace_init_fields();
 }
 
 #ifdef CONFIG_EVENT_TRACE_STARTUP_TEST

