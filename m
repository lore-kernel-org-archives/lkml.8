Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3016C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79002073B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgBASMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:12:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBASMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:12:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B0C206D3;
        Sat,  1 Feb 2020 18:12:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixxFx-001Im7-7W; Sat, 01 Feb 2020 13:12:33 -0500
Message-Id: <20200201181233.107895184@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 01 Feb 2020 13:12:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 3/6] tracing: Consolidate some synth_event_trace code
References: <20200201181210.203806308@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

The synth_event trace code contains some almost identical functions
and some small functions that are called only once - consolidate the
common code into single functions and fold in the small functions to
simplify the code overall.

Link: http://lkml.kernel.org/r/d1c8d8ad124a653b7543afe801d38c199ca5c20e.1580506712.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 141 +++++++++++++------------------
 1 file changed, 57 insertions(+), 84 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5b4e04780411..42058a1b5146 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2053,24 +2053,72 @@ int synth_event_trace_start(struct trace_event_file *file,
 }
 EXPORT_SYMBOL_GPL(synth_event_trace_start);
 
-static int save_synth_val(struct synth_field *field, u64 val,
-			  struct synth_event_trace_state *trace_state)
+static int __synth_event_add_val(const char *field_name, u64 val,
+				 struct synth_event_trace_state *trace_state)
 {
-	struct synth_trace_event *entry = trace_state->entry;
+	struct synth_field *field = NULL;
+	struct synth_trace_event *entry;
+	struct synth_event *event;
+	int i, ret = 0;
+
+	if (!trace_state) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* can't mix add_next_synth_val() with add_synth_val() */
+	if (field_name) {
+		if (trace_state->add_next) {
+			ret = -EINVAL;
+			goto out;
+		}
+		trace_state->add_name = true;
+	} else {
+		if (trace_state->add_name) {
+			ret = -EINVAL;
+			goto out;
+		}
+		trace_state->add_next = true;
+	}
+
+	if (!trace_state->enabled)
+		goto out;
+
+	event = trace_state->event;
+	if (trace_state->add_name) {
+		for (i = 0; i < event->n_fields; i++) {
+			field = event->fields[i];
+			if (strcmp(field->name, field_name) == 0)
+				break;
+		}
+		if (!field) {
+			ret = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (trace_state->cur_field >= event->n_fields) {
+			ret = -EINVAL;
+			goto out;
+		}
+		field = event->fields[trace_state->cur_field++];
+	}
 
+	entry = trace_state->entry;
 	if (field->is_string) {
 		char *str_val = (char *)(long)val;
 		char *str_field;
 
-		if (!str_val)
-			return -EINVAL;
+		if (!str_val) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		str_field = (char *)&entry->fields[field->offset];
 		strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 	} else
 		entry->fields[field->offset] = val;
-
-	return 0;
+ out:
+	return ret;
 }
 
 /**
@@ -2104,54 +2152,10 @@ static int save_synth_val(struct synth_field *field, u64 val,
 int synth_event_add_next_val(u64 val,
 			     struct synth_event_trace_state *trace_state)
 {
-	struct synth_field *field;
-	struct synth_event *event;
-	int ret = 0;
-
-	if (!trace_state) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* can't mix add_next_synth_val() with add_synth_val() */
-	if (trace_state->add_name) {
-		ret = -EINVAL;
-		goto out;
-	}
-	trace_state->add_next = true;
-
-	if (!trace_state->enabled)
-		goto out;
-
-	event = trace_state->event;
-
-	if (trace_state->cur_field >= event->n_fields) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	field = event->fields[trace_state->cur_field++];
-	ret = save_synth_val(field, val, trace_state);
- out:
-	return ret;
+	return __synth_event_add_val(NULL, val, trace_state);
 }
 EXPORT_SYMBOL_GPL(synth_event_add_next_val);
 
-static struct synth_field *find_synth_field(struct synth_event *event,
-					    const char *field_name)
-{
-	struct synth_field *field = NULL;
-	unsigned int i;
-
-	for (i = 0; i < event->n_fields; i++) {
-		field = event->fields[i];
-		if (strcmp(field->name, field_name) == 0)
-			return field;
-	}
-
-	return NULL;
-}
-
 /**
  * synth_event_add_val - Add a named field's value to an open synth trace
  * @field_name: The name of the synthetic event field value to set
@@ -2183,38 +2187,7 @@ static struct synth_field *find_synth_field(struct synth_event *event,
 int synth_event_add_val(const char *field_name, u64 val,
 			struct synth_event_trace_state *trace_state)
 {
-	struct synth_trace_event *entry;
-	struct synth_event *event;
-	struct synth_field *field;
-	int ret = 0;
-
-	if (!trace_state) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* can't mix add_next_synth_val() with add_synth_val() */
-	if (trace_state->add_next) {
-		ret = -EINVAL;
-		goto out;
-	}
-	trace_state->add_name = true;
-
-	if (!trace_state->enabled)
-		goto out;
-
-	event = trace_state->event;
-	entry = trace_state->entry;
-
-	field = find_synth_field(event, field_name);
-	if (!field) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = save_synth_val(field, val, trace_state);
- out:
-	return ret;
+	return __synth_event_add_val(field_name, val, trace_state);
 }
 EXPORT_SYMBOL_GPL(synth_event_add_val);
 
-- 
2.24.1


