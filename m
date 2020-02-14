Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B7C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92549222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581721013;
	bh=ZiR0lU2N8oBPEOAU1oKu27pXr9bUiyQ+jcPc+gi/XN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=1e241a5fQJuYqUjFBYfw6soWMpazbxjHdtgmyPaQVC7dCLVIGnuPK3GJV/RPPr9Ig
	 GpP6Xg/ZPx80OKzSARquM6VROGc3Hr9tL9liyeLCnLszsG9Qs7xz3hDndCV2Xitv+q
	 e/sxtQafRBWpIEj677V7lj547Y73vhEbn3VUrTMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgBNW4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbgBNW4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:56:49 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4DA2086A;
        Fri, 14 Feb 2020 22:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581721008;
        bh=ZiR0lU2N8oBPEOAU1oKu27pXr9bUiyQ+jcPc+gi/XN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Ym06BHucZJJR8vRlvMK0bI7cOGer9axa1XUwoB8HBT4LTEm+2O1v9OYKkrlJ2WIY4
         9NUI8CGyuGSWTf/PlAZ+uPuBf46oMLOx5znU4wS8JRp+fPCKTaZFRiWQseIrNULxk/
         il3uRhpgIPFcD02eDgsHog34bmRM3I+ZD4+Vi5o8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] tracing: Make sure synth_event_trace() example always uses u64
Date:   Fri, 14 Feb 2020 16:56:38 -0600
Message-Id: <894c4e955558b521210ee0642ba194a9e603354c.1581720155.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1581720155.git.zanussi@kernel.org>
References: <cover.1581720155.git.zanussi@kernel.org>
In-Reply-To: <cover.1581720155.git.zanussi@kernel.org>
References: <cover.1581720155.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

synth_event_trace() is the varargs version of synth_event_trace_array(),
which takes an array of u64, as do synth_event_add_val() et al.

To not only be consistent with those, but also to address the fact
that synth_event_trace() expects every arg to be of the same type
since it doesn't also pass in e.g. a format string, the caller needs
to make sure all args are of the same type, u64.  u64 is used because
it needs to accomodate the largest type available in synthetic events,
which is u64.

This fixes the bug reported by the kernel test robot/Rong Chen as
reported here:

  https://lore.kernel.org/lkml/20200212113444.GS12867@shao2-debian/

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/synth_event_gen_test.c | 34 +++++++++++++++++-----------------
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
2.14.1

