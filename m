Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D934C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FEC2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BOsiQMdC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7GbzfdL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgGXIeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGXIdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E191C0619D3;
        Fri, 24 Jul 2020 01:33:51 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7XfIjk8Dl3H3UaWoRDdbFiFRYm+8kTqLogSOIqH9kd8=;
        b=BOsiQMdCcXQaiKu1yreoRq5iDVClmFjfw6dbr1Syyv5ie5uhOlCVi1SlEoXnWNsMByKgYM
        3P99lAExJGWdWBqXZ0QpA/Ecu/jxdQivkZLArfCBen60NLFFjCltT+Zz3wWPO1f5sBF7bp
        qs5llVEizzkqvI1jwm7O0mcyCkg7JKEySv7TZR2zpiqbU+3dTR4TV9aYxVcEj4i5m6lP0T
        kXA5j9cteOlkFXrIyDPgElFlMdmb12CLJTfi6p+/syRePM0+MKJPHPv0fOcbkZ7qPiT4bZ
        qHHNDn+v7ddzYpJ36utQNMw56G8oFNXqZ4uc417YHB+xwGOa9cWEQUAN/3m9Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7XfIjk8Dl3H3UaWoRDdbFiFRYm+8kTqLogSOIqH9kd8=;
        b=7GbzfdL7vQ2ub0mOgCsTV6qIPsicwslx4oxsx6KzRhwkKdVpwGOoSTLQmBWWkzE1/MGLvf
        vAU+moNxj+Mg/FAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,psci: Convert to sched_set_fifo*()
Cc:     daniel.lezcano@linaro.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962899.4006.12154012216510604486.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     6e6d6efabd2567337f7d97791f7a60aa5fdbcfc2
Gitweb:        https://git.kernel.org/tip/6e6d6efabd2567337f7d97791f7a60aa5fdbcfc2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:21 +02:00

sched,psci: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively changes prio from 99 to 50.

XXX this thing is horrific, it basically open-codes a stop-machine and
idle.

Cc: daniel.lezcano@linaro.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci/psci_checker.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 873841a..a5279a4 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -272,7 +272,6 @@ static int suspend_test_thread(void *arg)
 {
 	int cpu = (long)arg;
 	int i, nb_suspend = 0, nb_shallow_sleep = 0, nb_err = 0;
-	struct sched_param sched_priority = { .sched_priority = MAX_RT_PRIO-1 };
 	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv;
 	/* No need for an actual callback, we just want to wake up the CPU. */
@@ -282,9 +281,8 @@ static int suspend_test_thread(void *arg)
 	wait_for_completion(&suspend_threads_started);
 
 	/* Set maximum priority to preempt all other threads on this CPU. */
-	if (sched_setscheduler_nocheck(current, SCHED_FIFO, &sched_priority))
-		pr_warn("Failed to set suspend thread scheduler on CPU %d\n",
-			cpu);
+	if (sched_set_fifo(current))
+		pr_warn("Failed to set suspend thread scheduler on CPU %d\n", cpu);
 
 	dev = this_cpu_read(cpuidle_devices);
 	drv = cpuidle_get_cpu_driver(dev);
@@ -349,11 +347,6 @@ static int suspend_test_thread(void *arg)
 	if (atomic_dec_return_relaxed(&nb_active_threads) == 0)
 		complete(&suspend_threads_done);
 
-	/* Give up on RT scheduling and wait for termination. */
-	sched_priority.sched_priority = 0;
-	if (sched_setscheduler_nocheck(current, SCHED_NORMAL, &sched_priority))
-		pr_warn("Failed to set suspend thread scheduler on CPU %d\n",
-			cpu);
 	for (;;) {
 		/* Needs to be set first to avoid missing a wakeup. */
 		set_current_state(TASK_INTERRUPTIBLE);
