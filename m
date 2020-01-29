Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02248C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD51320716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580335699;
	bh=43A+DFV4SVboEPFOMS+4gRYwt1lAD42l1kKilJPNVxY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=n4MLR5fnHuzLo1TOSHweZP7BcpcRA/I0gRp78IUuHF0D9gPN66stGbrNN1mkGfpLv
	 LfU3t+EPeYvawwuKreERNBKAKmPvue/9TPdDSEYR7XjFIVtaDWI/t/l9O5j0zFV4qm
	 YlnutzYCl5QDrPitWlWF9qNTtJAT8AMRWcFCesl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgA2WIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:08:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgA2WIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:08:18 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 055A320702;
        Wed, 29 Jan 2020 22:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580335697;
        bh=43A+DFV4SVboEPFOMS+4gRYwt1lAD42l1kKilJPNVxY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YloweLLLtSEw34LnQJr678dbIDhepna6PyfruvDdpvIS2Rn03dDpd50stxJY8PyyC
         YugglZ3ZuJ+SdhnwjFU72AqUuv0bjfyA+4ee3n8RrW7nzwLnQpzzDRMK3iqh/9fpYc
         Ohemmc7aADhbJ2vY5LEcUiE2rJwIxQlelnhS8NhI=
Message-ID: <1580335695.6220.8.camel@kernel.org>
Subject: Re: Using matched variables in trace actions
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Jan 2020 16:08:15 -0600
In-Reply-To: <20200128220138.50b203d3@rorschach.local.home>
References: <20200128220138.50b203d3@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 2020-01-28 at 22:01 -0500, Steven Rostedt wrote:
> Hi Tom,
> 
> I was debugging a histogram that wasn't working.
> 
> I had the following:
> 
>  # cd /sys/kernel/tracing/
>  # echo 'first u64 start_time u64 end_time pid_t pid u64 delta' > synthetic_events
>  # echo 'hist:keys=pid:start_time=common_timestamp' > events/sched/sched_waking/trigger
>  # echo 'hist:keys=next_pid:delta=common_timestamp-$start_time:onmatch(sched.sched_waking).first($start_time,common_timestamp,next_pid,$delta)' > events/sched/sched_switch/trigger
> 
> Which produced:
> 
>  # echo 1 > synthetic/enable
>  # cat trace
> [..]
>           <idle>-0     [005] d..4   342.980379: first: start_time=342980373002 end_time=197 pid=43140 delta=18446744072217752717
>           <idle>-0     [000] d..4   342.980439: first: start_time=342980434369 end_time=1598 pid=44526 delta=18446744072239552512
>           <idle>-0     [005] d..4   342.980495: first: start_time=342980489992 end_time=197 pid=44739 delta=18446744072217752717

This problem is fallout of the 'tracing: Fix histogram code when
expression has same var as value' fix, which because now that the
var_ref_vals var ref positions are unique, breaks the assumption that
the trace action params are all in a row at the end.  So in this case,
they're one off and so the values are skewed by one position.

The patch below fixes the problem for me and passes all the ftrace
tests.

Tom

[PATCH] tracing: Fix now invalid var_ref_vals assumption in trace action

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

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 53 ++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 95a2ba9ff495..cb52ae05f6fe 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -475,11 +475,12 @@ struct action_data {
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
@@ -881,14 +882,14 @@ static struct trace_event_functions synth_event_funcs = {
 
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
@@ -911,15 +912,16 @@ static notrace void trace_event_raw_event_synth(void *__data,
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
@@ -1119,10 +1121,10 @@ static struct tracepoint *alloc_synth_tracepoint(char *name)
 }
 
 typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
-				    unsigned int var_ref_idx);
+				    unsigned int *var_ref_idx);
 
 static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
-			       unsigned int var_ref_idx)
+			       unsigned int *var_ref_idx)
 {
 	struct tracepoint *tp = event->tp;
 
@@ -2663,6 +2665,22 @@ static int init_var_ref(struct hist_field *ref_field,
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
@@ -4239,11 +4257,11 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
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
 
@@ -4260,8 +4278,6 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 
 	event->ref++;
 
-	var_ref_idx = hist_data->n_var_refs;
-
 	for (i = 0; i < data->n_params; i++) {
 		char *p;
 
@@ -4310,6 +4326,14 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
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
@@ -4328,7 +4352,6 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 	}
 
 	data->synth_event = event;
-	data->var_ref_idx = var_ref_idx;
  out:
 	return ret;
  err:
-- 
2.14.1



