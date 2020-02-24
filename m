Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B455C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6F420732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgBXRXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:23:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgBXRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2FC720CC7;
        Mon, 24 Feb 2020 17:21:17 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPw-001Ads-Og; Mon, 24 Feb 2020 12:21:16 -0500
Message-Id: <20200224172116.608333548@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 05/15] tracing: Have synthetic event test use raw_smp_processor_id()
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The test code that tests synthetic event creation pushes in as one of its
test fields the current CPU using "smp_processor_id()". As this is just
something to see if the value is correctly passed in, and the actual CPU
used does not matter, use raw_smp_processor_id(), otherwise with debug
preemption enabled, a warning happens as the smp_processor_id() is called
without preemption enabled.

Link: http://lkml.kernel.org/r/20200220162950.35162579@gandalf.local.home

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/synth_event_gen_test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 6866280a9b10..7d56d621ffea 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -114,7 +114,7 @@ static int __init test_gen_synth_cmd(void)
 	vals[1] = (u64)(long)"hula hoops";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
-	vals[4] = smp_processor_id();	/* cpu */
+	vals[4] = raw_smp_processor_id(); /* cpu */
 	vals[5] = (u64)(long)"thneed";	/* my_string_field */
 	vals[6] = 598;			/* my_int_field */
 
@@ -221,7 +221,7 @@ static int __init test_empty_synth_event(void)
 	vals[1] = (u64)(long)"tiddlywinks";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
-	vals[4] = smp_processor_id();	/* cpu */
+	vals[4] = raw_smp_processor_id(); /* cpu */
 	vals[5] = (u64)(long)"thneed_2.0";	/* my_string_field */
 	vals[6] = 399;			/* my_int_field */
 
@@ -293,7 +293,7 @@ static int __init test_create_synth_event(void)
 	vals[1] = (u64)(long)"tiddlywinks";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
-	vals[4] = smp_processor_id();	/* cpu */
+	vals[4] = raw_smp_processor_id(); /* cpu */
 	vals[5] = (u64)(long)"thneed";	/* my_string_field */
 	vals[6] = 398;			/* my_int_field */
 
@@ -345,7 +345,7 @@ static int __init test_add_next_synth_val(void)
 		goto out;
 
 	/* cpu */
-	ret = synth_event_add_next_val(smp_processor_id(), &trace_state);
+	ret = synth_event_add_next_val(raw_smp_processor_id(), &trace_state);
 	if (ret)
 		goto out;
 
@@ -388,7 +388,7 @@ static int __init test_add_synth_val(void)
 	if (ret)
 		goto out;
 
-	ret = synth_event_add_val("cpu", smp_processor_id(), &trace_state);
+	ret = synth_event_add_val("cpu", raw_smp_processor_id(), &trace_state);
 	if (ret)
 		goto out;
 
@@ -427,7 +427,7 @@ static int __init test_trace_synth_event(void)
 				(u64)(long)"clackers",	/* next_comm_field */
 				(u64)1000000,		/* ts_ns */
 				(u64)1000,		/* ts_ms */
-				(u64)smp_processor_id(),/* cpu */
+				(u64)raw_smp_processor_id(), /* cpu */
 				(u64)(long)"Thneed",	/* my_string_field */
 				(u64)999);		/* my_int_field */
 	return ret;
-- 
2.25.0


