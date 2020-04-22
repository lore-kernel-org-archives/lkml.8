Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873A9C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6023320784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AJZNSrzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDVL30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbgDVL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B025C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IPsokMf7j12ulQ4L+xCcKx1w5TI7LQr2p0tSldOtxhc=; b=AJZNSrzEp21IlLS+Xdfk4y2mqA
        bTO57Z7UlLKDG6wcJxOsF+iVpd6iQYhvLlFghKDMjD9hBoaDPeLsApdqn0Sicc1Z61M7wAKt1chBz
        mfMg622CjzWcxixF5nKsbAzia6HAdc+UvHoYjegIHTgJWFGhn1wiF/4BnFsa3INNgdtHcYN5hdKQQ
        Mo6fQfZDjrUC9hMP7wsovnp6Rln4NIN1oV79fBk/rqH0XYDayuTOhlRUw2fzHW7o30LCAlVpWhxJ5
        U0NClOAyEv71XNb6UwFXQhaask6Jiiy+nGm3bu52c2IuanxIWjolMUYhRLf/FuualNr0Ydrcj1aY4
        ElhnaO5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYv-0003aV-4S; Wed, 22 Apr 2020 11:29:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3205D30788D;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C835A200C9C87; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.574539982@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, daniel.lezcano@linaro.org,
        sudeep.holla@arm.com
Subject: [PATCH 06/23] sched,psci: Convert to sched_set_fifo*()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively changes prio from 99 to 50.

XXX this thing is horrific, it basically open-codes a stop-machine and
idle.

Cc: daniel.lezcano@linaro.org
Cc: sudeep.holla@arm.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/psci/psci_checker.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -272,7 +272,6 @@ static int suspend_test_thread(void *arg
 {
 	int cpu = (long)arg;
 	int i, nb_suspend = 0, nb_shallow_sleep = 0, nb_err = 0;
-	struct sched_param sched_priority = { .sched_priority = MAX_RT_PRIO-1 };
 	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv;
 	/* No need for an actual callback, we just want to wake up the CPU. */
@@ -282,9 +281,8 @@ static int suspend_test_thread(void *arg
 	wait_for_completion(&suspend_threads_started);
 
 	/* Set maximum priority to preempt all other threads on this CPU. */
-	if (sched_setscheduler_nocheck(current, SCHED_FIFO, &sched_priority))
-		pr_warn("Failed to set suspend thread scheduler on CPU %d\n",
-			cpu);
+	if (sched_set_fifo(current))
+		pr_warn("Failed to set suspend thread scheduler on CPU %d\n", cpu);
 
 	dev = this_cpu_read(cpuidle_devices);
 	drv = cpuidle_get_cpu_driver(dev);
@@ -349,11 +347,6 @@ static int suspend_test_thread(void *arg
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


