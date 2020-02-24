Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D5DC11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349E620836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgBXRVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:21:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgBXRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A785422525;
        Mon, 24 Feb 2020 17:21:17 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPw-001AdN-Ie; Mon, 24 Feb 2020 12:21:16 -0500
Message-Id: <20200224172116.421202035@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 04/15] tracing: Fix number printing bug in print_synth_event()
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Fix a varargs-related bug in print_synth_event() which resulted in
strange output and oopses on 32-bit x86 systems. The problem is that
trace_seq_printf() expects the varargs to match the format string, but
print_synth_event() was always passing u64 values regardless.  This
results in unspecified behavior when unpacking with va_arg() in
trace_seq_printf().

Add a function that takes the size into account when calling
trace_seq_printf().

Before:

  modprobe-1731  [003] ....   919.039758: gen_synth_test: next_pid_field=777(null)next_comm_field=hula hoops ts_ns=1000000 ts_ms=1000 cpu=3(null)my_string_field=thneed my_int_field=598(null)

After:

 insmod-1136  [001] ....    36.634590: gen_synth_test: next_pid_field=777 next_comm_field=hula hoops ts_ns=1000000 ts_ms=1000 cpu=1 my_string_field=thneed my_int_field=598

Link: http://lkml.kernel.org/r/a9b59eb515dbbd7d4abe53b347dccf7a8e285657.1581720155.git.zanussi@kernel.org

Reported-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 45622194a34d..f068d55bd37f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -820,6 +820,29 @@ static const char *synth_field_fmt(char *type)
 	return fmt;
 }
 
+static void print_synth_event_num_val(struct trace_seq *s,
+				      char *print_fmt, char *name,
+				      int size, u64 val, char *space)
+{
+	switch (size) {
+	case 1:
+		trace_seq_printf(s, print_fmt, name, (u8)val, space);
+		break;
+
+	case 2:
+		trace_seq_printf(s, print_fmt, name, (u16)val, space);
+		break;
+
+	case 4:
+		trace_seq_printf(s, print_fmt, name, (u32)val, space);
+		break;
+
+	default:
+		trace_seq_printf(s, print_fmt, name, val, space);
+		break;
+	}
+}
+
 static enum print_line_t print_synth_event(struct trace_iterator *iter,
 					   int flags,
 					   struct trace_event *event)
@@ -858,10 +881,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
+			char *space = (i == se->n_fields - 1 ? "" : " ");
 
-			trace_seq_printf(s, print_fmt, se->fields[i]->name,
-					 entry->fields[n_u64],
-					 i == se->n_fields - 1 ? "" : " ");
+			print_synth_event_num_val(s, print_fmt,
+						  se->fields[i]->name,
+						  se->fields[i]->size,
+						  entry->fields[n_u64],
+						  space);
 
 			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
 				trace_seq_puts(s, " (");
-- 
2.25.0


