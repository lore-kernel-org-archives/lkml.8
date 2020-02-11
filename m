Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DBDC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41581208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgBKNuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgBKNt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:49:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ABC52465D;
        Tue, 11 Feb 2020 13:49:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j1VvK-001aqf-EY; Tue, 11 Feb 2020 08:49:58 -0500
Message-Id: <20200211134958.328823764@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 11 Feb 2020 08:49:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 4/5] tracing: Dont return -EINVAL when tracing soft disabled synth events
References: <20200211134941.229027482@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

There's no reason to return -EINVAL when tracing a synthetic event if
it's soft disabled - treat it the same as if it were hard disabled and
return normally.

Have synth_event_trace() and synth_event_trace_array() just return
normally, and have synth_event_trace_start set the trace state to
disabled and return.

Link: http://lkml.kernel.org/r/df5d02a1625aff97c9866506c5bada6a069982ba.1581374549.git.zanussi@kernel.org

Fixes: 8dcc53ad956d2 ("tracing: Add synth_event_trace() and related functions")
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a546ffa14785..99a02168599b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1828,7 +1828,8 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 	 * called directly by the user, we don't have that but we
 	 * still need to honor not logging when disabled.
 	 */
-	if (!(file->flags & EVENT_FILE_FL_ENABLED))
+	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
+	    trace_trigger_soft_disabled(file))
 		return 0;
 
 	event = file->event_call->data;
@@ -1836,9 +1837,6 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 	if (n_vals != event->n_fields)
 		return -EINVAL;
 
-	if (trace_trigger_soft_disabled(file))
-		return -EINVAL;
-
 	fields_size = event->n_u64 * sizeof(u64);
 
 	/*
@@ -1918,7 +1916,8 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 	 * called directly by the user, we don't have that but we
 	 * still need to honor not logging when disabled.
 	 */
-	if (!(file->flags & EVENT_FILE_FL_ENABLED))
+	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
+	    trace_trigger_soft_disabled(file))
 		return 0;
 
 	event = file->event_call->data;
@@ -1926,9 +1925,6 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 	if (n_vals != event->n_fields)
 		return -EINVAL;
 
-	if (trace_trigger_soft_disabled(file))
-		return -EINVAL;
-
 	fields_size = event->n_u64 * sizeof(u64);
 
 	/*
@@ -2017,7 +2013,8 @@ int synth_event_trace_start(struct trace_event_file *file,
 	 * trace case, we save the enabed state upon start and just
 	 * ignore the following data calls.
 	 */
-	if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
+	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
+	    trace_trigger_soft_disabled(file)) {
 		trace_state->enabled = false;
 		goto out;
 	}
@@ -2026,11 +2023,6 @@ int synth_event_trace_start(struct trace_event_file *file,
 
 	trace_state->event = file->event_call->data;
 
-	if (trace_trigger_soft_disabled(file)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	fields_size = trace_state->event->n_u64 * sizeof(u64);
 
 	/*
-- 
2.24.1


