Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47A6C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A16217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBASMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:12:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgBASMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:12:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFBA620723;
        Sat,  1 Feb 2020 18:12:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixxFx-001Ild-2X; Sat, 01 Feb 2020 13:12:33 -0500
Message-Id: <20200201181232.955517988@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 01 Feb 2020 13:12:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 2/6] tracing: Fix now invalid var_ref_vals assumption in trace action
References: <20200201181210.203806308@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

The patch 'tracing: Fix histogram code when expression has same var as
value' added code to return an existing variable reference when
creating a new variable reference, which resulted in var_ref_vals
slots being reused instead of being duplicated.

The implementation of the trace action assumes that the end of the
var_ref_vals array starting at action_data.var_ref_idx corresponds to
the values that will be assigned to the trace params. The patch
mentioned above invalidates that assumption, which means that each
param needs to explicitly specify its index into var_ref_vals.

This fix changes action_data.var_ref_idx to an array of var ref
indexes to account for that.

Link: https://lore.kernel.org/r/1580335695.6220.8.camel@kernel.org

Fixes: 8bcebc77e85f ("tracing: Fix histogram code when expression has same var as value")
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 53 +++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 2e88c9805f4b..5b4e04780411 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -476,11 +476,12 @@ struct action_data {
 	 * When a histogram trigger is hit, the values of any
 	 * references to variables, including variables being passed
 	 * as parameters to synthetic events, are collected into a
-	 * var_ref_vals array.  This var_ref_idx is the index of the
-	 * first param in the array to be passed to the synthetic
-	 * event invocation.
+	 * var_ref_vals array.  This var_ref_idx array is an array of
+	 * indices into the var_ref_vals array, one for each synthetic
+	 * event param, and is passed to the synthetic event
+	 * invocation.
 	 */
-	unsigned int		var_ref_idx;
+	unsigned int		var_ref_idx[TRACING_MAP_VARS_MAX];
 	struct synth_event	*synth_event;
 	bool			use_trace_keyword;
 	char			*synth_event_name;
@@ -884,14 +885,14 @@ static struct trace_event_functions synth_event_funcs = {
 
 static notrace void trace_event_raw_event_synth(void *__data,
 						u64 *var_ref_vals,
-						unsigned int var_ref_idx)
+						unsigned int *var_ref_idx)
 {
 	struct trace_event_file *trace_file = __data;
 	struct synth_trace_event *entry;
 	struct trace_event_buffer fbuffer;
 	struct trace_buffer *buffer;
 	struct synth_event *event;
-	unsigned int i, n_u64;
+	unsigned int i, n_u64, val_idx;
 	int fields_size = 0;
 
 	event = trace_file->event_call->data;
@@ -914,15 +915,16 @@ static notrace void trace_event_raw_event_synth(void *__data,
 		goto out;
 
 	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
+		val_idx = var_ref_idx[i];
 		if (event->fields[i]->is_string) {
-			char *str_val = (char *)(long)var_ref_vals[var_ref_idx + i];
+			char *str_val = (char *)(long)var_ref_vals[val_idx];
 			char *str_field = (char *)&entry->fields[n_u64];
 
 			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
 			struct synth_field *field = event->fields[i];
-			u64 val = var_ref_vals[var_ref_idx + i];
+			u64 val = var_ref_vals[val_idx];
 
 			switch (field->size) {
 			case 1:
@@ -1122,10 +1124,10 @@ static struct tracepoint *alloc_synth_tracepoint(char *name)
 }
 
 typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
-				    unsigned int var_ref_idx);
+				    unsigned int *var_ref_idx);
 
 static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
-			       unsigned int var_ref_idx)
+			       unsigned int *var_ref_idx)
 {
 	struct tracepoint *tp = event->tp;
 
@@ -3506,6 +3508,22 @@ static int init_var_ref(struct hist_field *ref_field,
 	goto out;
 }
 
+static int find_var_ref_idx(struct hist_trigger_data *hist_data,
+			    struct hist_field *var_field)
+{
+	struct hist_field *ref_field;
+	int i;
+
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		ref_field = hist_data->var_refs[i];
+		if (ref_field->var.idx == var_field->var.idx &&
+		    ref_field->var.hist_data == var_field->hist_data)
+			return i;
+	}
+
+	return -ENOENT;
+}
+
 /**
  * create_var_ref - Create a variable reference and attach it to trigger
  * @hist_data: The trigger that will be referencing the variable
@@ -5071,11 +5089,11 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 	struct trace_array *tr = hist_data->event_file->tr;
 	char *event_name, *param, *system = NULL;
 	struct hist_field *hist_field, *var_ref;
-	unsigned int i, var_ref_idx;
+	unsigned int i;
 	unsigned int field_pos = 0;
 	struct synth_event *event;
 	char *synth_event_name;
-	int ret = 0;
+	int var_ref_idx, ret = 0;
 
 	lockdep_assert_held(&event_mutex);
 
@@ -5092,8 +5110,6 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 
 	event->ref++;
 
-	var_ref_idx = hist_data->n_var_refs;
-
 	for (i = 0; i < data->n_params; i++) {
 		char *p;
 
@@ -5142,6 +5158,14 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 				goto err;
 			}
 
+			var_ref_idx = find_var_ref_idx(hist_data, var_ref);
+			if (WARN_ON(var_ref_idx < 0)) {
+				ret = var_ref_idx;
+				goto err;
+			}
+
+			data->var_ref_idx[i] = var_ref_idx;
+
 			field_pos++;
 			kfree(p);
 			continue;
@@ -5160,7 +5184,6 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 	}
 
 	data->synth_event = event;
-	data->var_ref_idx = var_ref_idx;
  out:
 	return ret;
  err:
-- 
2.24.1


