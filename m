Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B83C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12ACE20663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GjCNvXhc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vm5laUuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgG2Kyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:54:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2Kyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:54:52 -0400
Date:   Wed, 29 Jul 2020 10:54:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596020089;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2YtiANiuId38HfM0lHPbqZZRMIQuKvJ65i0+RblqyVA=;
        b=GjCNvXhcY7htkn24fs0XRyH5DffEHZNPCN2a1ri+/kGl7yH0TJ4oQYZ8Qx9IRohwFnHLr+
        9Oi0ciVonoT2EnFdIayd5MBE3Kw8eqRN5wPg7GHzeR1bybl3ofd4ikFEb/YZwt7gYmwMjA
        4PbGxug3w+0XQPpGNR5/n5RVO0cTe/g1Vv5NyKAp8epxkuuL30BUWZZVUf43d4l5VBmRNh
        Hj1u1WzjjpnGE4EPRS6uT02l+9smo/m0XUOAHwwD1zUzO4nv9MzeLuL4YcrfiKcq18LlZn
        ZDkMVmD692jBnShF0YJC1kwutQSz7LLpVqOHuttQ0tLm8KG0WhCyjRZ8r7cjLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596020089;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2YtiANiuId38HfM0lHPbqZZRMIQuKvJ65i0+RblqyVA=;
        b=Vm5laUuTb1zD30BrhcfjMYcp+fbzkZDilL7Zjx3MJm6mTXTXLyHuFOoCn+DlkFzl5rEQZA
        fuq3vjOoV52vm/Dw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,tracing: Convert to sched_set_fifo()
Cc:     kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720214918.GM5523@worktop.programming.kicks-ass.net>
References: <20200720214918.GM5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159602008837.4006.13518683366691612365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     4fd5750af02ab7bba7c58a073060cc1da8a69173
Gitweb:        https://git.kernel.org/tip/4fd5750af02ab7bba7c58a073060cc1da8a69173
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 20 Jul 2020 23:49:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 11:43:53 +02:00

sched,tracing: Convert to sched_set_fifo()

One module user of sched_setscheduler() was overlooked and is
obviously causing build failures.

Convert ring_buffer_benchmark to use sched_set_fifo_low() when fifo==1
and sched_set_fifo() when fifo==2. This is a bit of an abuse, but it
makes the thing 'work' again.

Specifically, it enables all combinations that were previously
possible:

  producer higher than consumer
  consumer higher than producer

Fixes: 616d91b68cd5 ("sched: Remove sched_setscheduler*() EXPORTs")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20200720214918.GM5523@worktop.programming.kicks-ass.net
---
 kernel/trace/ring_buffer_benchmark.c | 48 ++++++++++++---------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 8df0aa8..78e5765 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -45,8 +45,8 @@ MODULE_PARM_DESC(write_iteration, "# of writes between timestamp readings");
 static int producer_nice = MAX_NICE;
 static int consumer_nice = MAX_NICE;
 
-static int producer_fifo = -1;
-static int consumer_fifo = -1;
+static int producer_fifo;
+static int consumer_fifo;
 
 module_param(producer_nice, int, 0644);
 MODULE_PARM_DESC(producer_nice, "nice prio for producer");
@@ -55,10 +55,10 @@ module_param(consumer_nice, int, 0644);
 MODULE_PARM_DESC(consumer_nice, "nice prio for consumer");
 
 module_param(producer_fifo, int, 0644);
-MODULE_PARM_DESC(producer_fifo, "fifo prio for producer");
+MODULE_PARM_DESC(producer_fifo, "use fifo for producer: 0 - disabled, 1 - low prio, 2 - fifo");
 
 module_param(consumer_fifo, int, 0644);
-MODULE_PARM_DESC(consumer_fifo, "fifo prio for consumer");
+MODULE_PARM_DESC(consumer_fifo, "use fifo for consumer: 0 - disabled, 1 - low prio, 2 - fifo");
 
 static int read_events;
 
@@ -303,22 +303,22 @@ static void ring_buffer_producer(void)
 		trace_printk("ERROR!\n");
 
 	if (!disable_reader) {
-		if (consumer_fifo < 0)
+		if (consumer_fifo)
+			trace_printk("Running Consumer at SCHED_FIFO %s\n",
+				     consumer_fifo == 1 ? "low" : "high");
+		else
 			trace_printk("Running Consumer at nice: %d\n",
 				     consumer_nice);
-		else
-			trace_printk("Running Consumer at SCHED_FIFO %d\n",
-				     consumer_fifo);
 	}
-	if (producer_fifo < 0)
+	if (producer_fifo)
+		trace_printk("Running Producer at SCHED_FIFO %s\n",
+			     producer_fifo == 1 ? "low" : "high");
+	else
 		trace_printk("Running Producer at nice: %d\n",
 			     producer_nice);
-	else
-		trace_printk("Running Producer at SCHED_FIFO %d\n",
-			     producer_fifo);
 
 	/* Let the user know that the test is running at low priority */
-	if (producer_fifo < 0 && consumer_fifo < 0 &&
+	if (!producer_fifo && !consumer_fifo &&
 	    producer_nice == MAX_NICE && consumer_nice == MAX_NICE)
 		trace_printk("WARNING!!! This test is running at lowest priority.\n");
 
@@ -455,21 +455,19 @@ static int __init ring_buffer_benchmark_init(void)
 	 * Run them as low-prio background tasks by default:
 	 */
 	if (!disable_reader) {
-		if (consumer_fifo >= 0) {
-			struct sched_param param = {
-				.sched_priority = consumer_fifo
-			};
-			sched_setscheduler(consumer, SCHED_FIFO, &param);
-		} else
+		if (consumer_fifo >= 2)
+			sched_set_fifo(consumer);
+		else if (consumer_fifo == 1)
+			sched_set_fifo_low(consumer);
+		else
 			set_user_nice(consumer, consumer_nice);
 	}
 
-	if (producer_fifo >= 0) {
-		struct sched_param param = {
-			.sched_priority = producer_fifo
-		};
-		sched_setscheduler(producer, SCHED_FIFO, &param);
-	} else
+	if (producer_fifo >= 2)
+		sched_set_fifo(producer);
+	else if (producer_fifo == 1)
+		sched_set_fifo_low(producer);
+	else
 		set_user_nice(producer, producer_nice);
 
 	return 0;
