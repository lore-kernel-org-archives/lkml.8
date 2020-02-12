Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9785AC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775F22467D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgBLTu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:50:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbgBLTu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:50:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05C9024671;
        Wed, 12 Feb 2020 19:50:27 +0000 (UTC)
Date:   Wed, 12 Feb 2020 14:50:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: [PATCH] tracing: Remove bogus 64-bit synth_event_trace() vararg 
 assumption
Message-ID: <20200212145026.0cbaa86b@gandalf.local.home>
In-Reply-To: <1581523144.8740.8.camel@kernel.org>
References: <20200212113444.GS12867@shao2-debian>
        <1581523144.8740.8.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Tom Zanussi <zanussi@kernel.org>

[ Tom, please send patches normally, and not embedded in a reply.
Otherwise it will not be picked up by my patchwork, and may be lost. ]

The vararg code in synth_event_trace() assumed the args were 64 bit
which is not the case on 32 bit systems.  Just use long which should
work on every system, and remove the u64 casts from the synth event
test module.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/synth_event_gen_test.c | 4 ++--
 kernel/trace/trace_events_hist.c    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 4aefe003cb7c..2a7465569a43 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -424,11 +424,11 @@ static int __init test_trace_synth_event(void)
 	/* Trace some bogus values just for testing */
 	ret = synth_event_trace(create_synth_test, 7,	/* number of values */
 				444,			/* next_pid_field */
-				(u64)"clackers",	/* next_comm_field */
+				"clackers",		/* next_comm_field */
 				1000000,		/* ts_ns */
 				1000,			/* ts_ms */
 				smp_processor_id(),	/* cpu */
-				(u64)"Thneed",		/* my_string_field */
+				"Thneed",		/* my_string_field */
 				999);			/* my_int_field */
 	return ret;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 2fcb755e900a..e65276c3c9d1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1883,12 +1883,12 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 
 	va_start(args, n_vals);
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
-		u64 val;
+		long val;
 
-		val = va_arg(args, u64);
+		val = va_arg(args, long);
 
 		if (state.event->fields[i]->is_string) {
-			char *str_val = (char *)(long)val;
+			char *str_val = (char *)val;
 			char *str_field = (char *)&state.entry->fields[n_u64];
 
 			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
-- 
2.14.1
