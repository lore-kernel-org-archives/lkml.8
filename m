Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A4FC11D34
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1053220CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgBXRXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgBXRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D41D20838;
        Mon, 24 Feb 2020 17:21:17 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPw-001Abu-2d; Mon, 24 Feb 2020 12:21:16 -0500
Message-Id: <20200224172115.943693379@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 01/15] tracing: Make sure synth_event_trace() example always uses u64
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

synth_event_trace() is the varargs version of synth_event_trace_array(),
which takes an array of u64, as do synth_event_add_val() et al.

To not only be consistent with those, but also to address the fact
that synth_event_trace() expects every arg to be of the same type
since it doesn't also pass in e.g. a format string, the caller needs
to make sure all args are of the same type, u64.  u64 is used because
it needs to accomodate the largest type available in synthetic events,
which is u64.

This fixes the bug reported by the kernel test robot/Rong Chen.

Link: https://lore.kernel.org/lkml/20200212113444.GS12867@shao2-debian/
Link: http://lkml.kernel.org/r/894c4e955558b521210ee0642ba194a9e603354c.1581720155.git.zanussi@kernel.org

Fixes: 9fe41efaca084 ("tracing: Add synth event generation test module")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/synth_event_gen_test.c | 34 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 4aefe003cb7c..6866280a9b10 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -111,11 +111,11 @@ static int __init test_gen_synth_cmd(void)
 	/* Create some bogus values just for testing */
 
 	vals[0] = 777;			/* next_pid_field */
-	vals[1] = (u64)"hula hoops";	/* next_comm_field */
+	vals[1] = (u64)(long)"hula hoops";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
 	vals[4] = smp_processor_id();	/* cpu */
-	vals[5] = (u64)"thneed";	/* my_string_field */
+	vals[5] = (u64)(long)"thneed";	/* my_string_field */
 	vals[6] = 598;			/* my_int_field */
 
 	/* Now generate a gen_synth_test event */
@@ -218,11 +218,11 @@ static int __init test_empty_synth_event(void)
 	/* Create some bogus values just for testing */
 
 	vals[0] = 777;			/* next_pid_field */
-	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
+	vals[1] = (u64)(long)"tiddlywinks";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
 	vals[4] = smp_processor_id();	/* cpu */
-	vals[5] = (u64)"thneed_2.0";	/* my_string_field */
+	vals[5] = (u64)(long)"thneed_2.0";	/* my_string_field */
 	vals[6] = 399;			/* my_int_field */
 
 	/* Now trace an empty_synth_test event */
@@ -290,11 +290,11 @@ static int __init test_create_synth_event(void)
 	/* Create some bogus values just for testing */
 
 	vals[0] = 777;			/* next_pid_field */
-	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
+	vals[1] = (u64)(long)"tiddlywinks";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
 	vals[4] = smp_processor_id();	/* cpu */
-	vals[5] = (u64)"thneed";	/* my_string_field */
+	vals[5] = (u64)(long)"thneed";	/* my_string_field */
 	vals[6] = 398;			/* my_int_field */
 
 	/* Now generate a create_synth_test event */
@@ -330,7 +330,7 @@ static int __init test_add_next_synth_val(void)
 		goto out;
 
 	/* next_comm_field */
-	ret = synth_event_add_next_val((u64)"slinky", &trace_state);
+	ret = synth_event_add_next_val((u64)(long)"slinky", &trace_state);
 	if (ret)
 		goto out;
 
@@ -350,7 +350,7 @@ static int __init test_add_next_synth_val(void)
 		goto out;
 
 	/* my_string_field */
-	ret = synth_event_add_next_val((u64)"thneed_2.01", &trace_state);
+	ret = synth_event_add_next_val((u64)(long)"thneed_2.01", &trace_state);
 	if (ret)
 		goto out;
 
@@ -396,12 +396,12 @@ static int __init test_add_synth_val(void)
 	if (ret)
 		goto out;
 
-	ret = synth_event_add_val("next_comm_field", (u64)"silly putty",
+	ret = synth_event_add_val("next_comm_field", (u64)(long)"silly putty",
 				  &trace_state);
 	if (ret)
 		goto out;
 
-	ret = synth_event_add_val("my_string_field", (u64)"thneed_9",
+	ret = synth_event_add_val("my_string_field", (u64)(long)"thneed_9",
 				  &trace_state);
 	if (ret)
 		goto out;
@@ -423,13 +423,13 @@ static int __init test_trace_synth_event(void)
 
 	/* Trace some bogus values just for testing */
 	ret = synth_event_trace(create_synth_test, 7,	/* number of values */
-				444,			/* next_pid_field */
-				(u64)"clackers",	/* next_comm_field */
-				1000000,		/* ts_ns */
-				1000,			/* ts_ms */
-				smp_processor_id(),	/* cpu */
-				(u64)"Thneed",		/* my_string_field */
-				999);			/* my_int_field */
+				(u64)444,		/* next_pid_field */
+				(u64)(long)"clackers",	/* next_comm_field */
+				(u64)1000000,		/* ts_ns */
+				(u64)1000,		/* ts_ms */
+				(u64)smp_processor_id(),/* cpu */
+				(u64)(long)"Thneed",	/* my_string_field */
+				(u64)999);		/* my_int_field */
 	return ret;
 }
 
-- 
2.25.0


