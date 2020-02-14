Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F2C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6403C222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581721016;
	bh=JghGrpZ3BHu2m7hSrp9XI82X/hCDRmk3heuqg9eObzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=q2fw/bmER+9/b06nMfetFEImEXgoajUYfPxtafgbtj1hXfBFQsUiejfy8mJtpVRhJ
	 V1qoHrQCcoVaxF61lVQnPJ7hhf8AzrcEzgliIMdiS7SctiyNmqP1WpI5FJDvRQ/3GC
	 aHEUfm8h0e/geYFRcyoIbfR4qWvfDKrsNHAP0BVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgBNW4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNW4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:56:53 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3110B2187F;
        Fri, 14 Feb 2020 22:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581721012;
        bh=JghGrpZ3BHu2m7hSrp9XI82X/hCDRmk3heuqg9eObzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YEljr5z89i36ErDHnkdwCre90A2IVm+eldxR0f1Z2QkVgcq/P8xSvKO3iOMkKrA2x
         0M410WO72hoWaTC9ge0zpIa9sU7vcjPjSC7uhSHPRzmU2+8K8uI+ee2UClvncFJayA
         nLWM5iRwFmt/z+YHuf7lVyvAKJCzrvvaJb4vX5dw=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] tracing: Fix number printing bug in print_synth_event()
Date:   Fri, 14 Feb 2020 16:56:41 -0600
Message-Id: <a9b59eb515dbbd7d4abe53b347dccf7a8e285657.1581720155.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1581720155.git.zanussi@kernel.org>
References: <cover.1581720155.git.zanussi@kernel.org>
In-Reply-To: <cover.1581720155.git.zanussi@kernel.org>
References: <cover.1581720155.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 95d4c871f87b..b991168cf4ef 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -821,6 +821,29 @@ static const char *synth_field_fmt(char *type)
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
@@ -859,10 +882,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
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
2.14.1

